`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2026 10:55:00
// Design Name: 
// Module Name: uart_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps

module uart_tb;

    reg rst;
    reg [7:0] data_in;
    reg wr_en;
    reg clk;
    reg rdy_clr;

    wire rdy;
    wire busy;
    wire [7:0] dout;

    // DUT instantiation
    uart_top dut(
        rst,
        data_in,
        wr_en,
        clk,
        rdy_clr,
        rdy,
        busy,
        dout
    );

    // Initial conditions
    initial begin
        clk     = 1'b0;
        rst     = 1'b1;
        data_in = 8'd0;
        wr_en   = 1'b0;
        rdy_clr = 1'b0;
    end

    // Clock generation: 100 MHz
    always #5 clk = ~clk;

    // Task to send byte
    task send_byte(input [7:0] din);
    begin
        @(negedge clk);
        data_in = din;
        wr_en = 1'b1;

        @(negedge clk);
        wr_en = 1'b0;
    end
    endtask

    // Task to clear ready
    task clear_ready;
    begin
        @(negedge clk);
        rdy_clr = 1'b1;

        @(negedge clk);
        rdy_clr = 1'b0;
    end
    endtask

    // Main test sequence
    initial begin

        // Reset
        repeat(10) @(negedge clk);
        rst = 1'b0;

        // First byte: 0x41
        send_byte(8'h41);

        wait(rdy == 1'b1);

        $display("--------------------------------");
        $display("First byte received = %h", dout);

        if (dout == 8'h41)
            $display("TEST 1 PASSED");
        else
            $display("TEST 1 FAILED");

        // Wait for transmitter to finish
        wait(busy == 1'b0);

        clear_ready;

        // Second byte: 0x55
        send_byte(8'h55);

        wait(rdy == 1'b1);

        $display("--------------------------------");
        $display("Second byte received = %h", dout);

        if (dout == 8'h55)
            $display("TEST 2 PASSED");
        else
            $display("TEST 2 FAILED");

        wait(busy == 1'b0);

        clear_ready;

        $display("--------------------------------");
        $display("UART SIMULATION COMPLETED");
        $display("--------------------------------");

        #100;
        $finish;

    end

    // Monitor
    initial begin
        $monitor(
            "Time=%0t rst=%b wr_en=%b data_in=%h busy=%b rdy=%b dout=%h",
            $time, rst, wr_en, data_in, busy, rdy, dout
        );
    end

    // Simulation timeout
    initial begin
        #3000000;
        $display("ERROR: Simulation timeout!");
        $finish;
    end

endmodule

