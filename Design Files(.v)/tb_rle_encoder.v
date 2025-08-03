`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 21:13:40
// Design Name: 
// Module Name: tb_rle_encoder
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


module tb_rle_encoder;
    reg clk = 0;
    reg rst;
    reg [7:0] data_in;
    reg data_valid;
    wire [7:0] run_value;
    wire [7:0] run_length;
    wire run_valid;

    rle_encoder uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_valid(data_valid),
        .run_value(run_value),
        .run_length(run_length),
        .run_valid(run_valid)
    );

    always #5 clk = ~clk;

    initial begin
        rst = 1;
        data_valid = 0;
        data_in = 0;
        #15;
        rst = 0;

        // Input: A A A B B A
        send_byte(8'd65);  // A
        send_byte(8'd65);  // A
        send_byte(8'd65);  // A
        send_byte(8'd66);  // B
        send_byte(8'd66);  // B
        send_byte(8'd65);  // A

        #50;
        $stop;
    end

    task send_byte;
        input [7:0] value;
        begin
            data_in = value;
            data_valid = 1;
            #10;
            data_valid = 0;
            #10;
        end
    endtask
endmodule
