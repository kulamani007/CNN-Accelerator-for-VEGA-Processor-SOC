`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 20:53:39
// Design Name: 
// Module Name: tb_kalman_filter
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


module tb_kalman_filter;
    reg clk = 0;
    reg rst;
    reg [15:0] measurement;
    wire [15:0] estimate;

    kalman_filter uut (
        .clk(clk),
        .rst(rst),
        .measurement(measurement),
        .estimate(estimate)
    );

    always #5 clk = ~clk;

    initial begin
        rst = 1;
        measurement = 0;
        #20;
        rst = 0;

        // Provide noisy sensor values (simulate fluctuating data)
        measurement = 16'd100;
        #10;
        measurement = 16'd120;
        #10;
        measurement = 16'd110;
        #10;
        measurement = 16'd130;
        #10;
        measurement = 16'd125;
        #10;
        measurement = 16'd140;
        #10;
        measurement = 16'd135;
        #10;

        $stop;
    end
endmodule
