`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 21:12:52
// Design Name: 
// Module Name: rle_encoder
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


module rle_encoder (
    input clk,
    input rst,
    input [7:0] data_in,
    input       data_valid,
    output reg [7:0] run_value,
    output reg [7:0] run_length,
    output reg       run_valid
);

    reg [7:0] prev_data;
    reg [7:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            prev_data <= 0;
            count <= 0;
            run_valid <= 0;
        end else if (data_valid) begin
            if (data_in == prev_data && count < 8'hFF) begin
                count <= count + 1;
                run_valid <= 0;
            end else begin
                if (count > 0) begin
                    run_value <= prev_data;
                    run_length <= count;
                    run_valid <= 1;
                end
                prev_data <= data_in;
                count <= 1;
            end
        end else begin
            run_valid <= 0;
        end
    end
endmodule
