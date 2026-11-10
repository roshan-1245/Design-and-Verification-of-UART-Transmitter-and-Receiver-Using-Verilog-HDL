`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2026 11:12:18
// Design Name: 
// Module Name: baud_rate_generator
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



module baud_rate_generator(
    input clk,
    output tx_enb,
    output rx_enb
);

    reg [12:0] tx_counter = 13'd0;
    reg [9:0] rx_counter = 10'd0;

    // Transmitter enable: approximately 19200 baud
    always @(posedge clk) begin
        if (tx_counter == 13'd5208)
            tx_counter <= 13'd0;
        else
            tx_counter <= tx_counter + 1'b1;
    end

    // Receiver enable: approximately 16x oversampling
    always @(posedge clk) begin
        if (rx_counter == 10'd325)
            rx_counter <= 10'd0;
        else
            rx_counter <= rx_counter + 1'b1;
    end

    assign tx_enb = (tx_counter == 0);
    assign rx_enb = (rx_counter == 0);

endmodule


