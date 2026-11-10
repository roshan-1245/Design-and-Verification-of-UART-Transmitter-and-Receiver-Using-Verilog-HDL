`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2026 10:48:49
// Design Name: 
// Module Name: uart_top
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



module uart_top(
    input rst,
    input [7:0] data_in,
    input wr_en,
    input clk,
    input rdy_clr,
    output rdy,
    output busy,
    output [7:0] dout
);

    wire tx_enb;
    wire rx_enb;
    wire tx_temp;

    // Baud rate generator
    baud_rate_generator bg(
        .clk(clk),
        .tx_enb(tx_enb),
        .rx_enb(rx_enb)
    );

    // UART transmitter
    transmitter us(
        .clk(clk),
        .wr_enb(wr_en),
        .enb(tx_enb),
        .rst(rst),
        .data_in(data_in),
        .tx(tx_temp),
        .busy(busy)
    );

    // UART receiver
    uart_reciever ur(
        .clk(clk),
        .rst(rst),
        .rx_cr(tx_temp),
        .clk_en(rx_enb),
        .rdy_clr(rdy_clr),
        .rdy(rdy),
        .data_out(dout)
    );

endmodule




