`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.11.2026 12:28:07
// Design Name: 
// Module Name: uart_reciever
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




module uart_reciever(
    input clk,
    input rst,
    input rx_cr,
    input clk_en,
    input rdy_clr,
    output reg rdy,
    output reg [7:0] data_out
);

    parameter start_state = 2'b00;
    parameter data_state  = 2'b01;
    parameter stop_state  = 2'b10;

    reg [1:0] state;
    reg [3:0] sample;
    reg [2:0] index;
    reg [7:0] temp_register;

    always @(posedge clk) begin

        if (rst) begin
            state         <= start_state;
            sample        <= 4'd0;
            index         <= 3'd0;
            temp_register <= 8'd0;
            data_out      <= 8'd0;
            rdy           <= 1'b0;
        end

        else begin

            if (rdy_clr)
                rdy <= 1'b0;

            if (clk_en) begin

                case (state)

                    // START BIT DETECTION
                    start_state: begin

                        if (rx_cr == 1'b0) begin

                            if (sample == 4'd7) begin
                                state         <= data_state;
                                sample        <= 4'd0;
                                index         <= 3'd0;
                                temp_register <= 8'd0;
                            end
                            else begin
                                sample <= sample + 1'b1;
                            end

                        end
                        else begin
                            sample <= 4'd0;
                        end

                    end

                    // DATA RECEPTION
                    data_state: begin

                        if (sample == 4'd15) begin

                            sample <= 4'd0;
                            temp_register[index] <= rx_cr;

                            if (index == 3'd7) begin
                                state <= stop_state;
                            end
                            else begin
                                index <= index + 1'b1;
                            end

                        end
                        else begin
                            sample <= sample + 1'b1;
                        end

                    end

                    // STOP BIT DETECTION
                    stop_state: begin

                        if (sample == 4'd15) begin

                            if (rx_cr == 1'b1) begin
                                data_out <= temp_register;
                                rdy <= 1'b1;
                            end

                            state  <= start_state;
                            sample <= 4'd0;

                        end
                        else begin
                            sample <= sample + 1'b1;
                        end

                    end

                    default: begin
                        state  <= start_state;
                        sample <= 4'd0;
                    end

                endcase
            end
        end
    end

endmodule
