`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2026 11:29:31
// Design Name: 
// Module Name: transmitter
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

module transmitter(
    input clk,
    input wr_enb,
    input enb,
    input rst,
    input [7:0] data_in,
    output reg tx,
    output busy
);

    parameter idle_state  = 2'b00;
    parameter start_state = 2'b01;
    parameter data_state  = 2'b10;
    parameter stop_state  = 2'b11;

    reg [7:0] data;
    reg [2:0] index;
    reg [1:0] state;

    always @(posedge clk) begin

        if (rst) begin
            state <= idle_state;
            tx    <= 1'b1;
            index <= 3'b000;
            data  <= 8'b0;
        end

        else begin

            case (state)

                // IDLE STATE
                idle_state: begin
                    tx <= 1'b1;

                    if (wr_enb) begin
                        data  <= data_in;
                        index <= 3'b000;
                        state <= start_state;
                    end
                end

                // START BIT
                start_state: begin
                    if (enb) begin
                        tx    <= 1'b0;
                        state <= data_state;
                    end
                end

                // DATA TRANSMISSION
                data_state: begin
                    if (enb) begin

                        tx <= data[index];

                        if (index == 3'd7) begin
                            state <= stop_state;
                        end
                        else begin
                            index <= index + 1'b1;
                        end

                    end
                end

                // STOP BIT
                stop_state: begin
                    if (enb) begin
                        tx    <= 1'b1;
                        state <= idle_state;
                    end
                end

                default: begin
                    state <= idle_state;
                    tx    <= 1'b1;
                end

            endcase
        end
    end

    assign busy = (state != idle_state);

endmodule
