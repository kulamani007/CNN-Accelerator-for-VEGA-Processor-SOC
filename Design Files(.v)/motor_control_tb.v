`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2025 21:57:41
// Design Name: 
// Module Name: motor_control_tb
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


module motor_control_tb;
    reg clk = 0;
    reg rst;
    reg [7:0] obj_pos;
    wire pwm_out;
    wire dir_left, dir_right;

    motor_control uut (
        .clk(clk),
        .rst(rst),
        .object_position(obj_pos),
        .pwm_out(pwm_out),
        .dir_left(dir_left),
        .dir_right(dir_right)
    );

    always #5 clk = ~clk;  // 100MHz clock

    initial begin
        rst = 1;
        obj_pos = 8'd0;
        #20;
        rst = 0;

        // Object far left
        obj_pos = 8'd50;
        #100;
        $display("LEFT: dir_left = %b, dir_right = %b, pwm = %b", dir_left, dir_right, pwm_out);

        // Object far right
        obj_pos = 8'd200;
        #100;
        $display("RIGHT: dir_left = %b, dir_right = %b, pwm = %b", dir_left, dir_right, pwm_out);

        // Object centered
        obj_pos = 8'd128;
        #100;
        $display("CENTER: dir_left = %b, dir_right = %b, pwm = %b", dir_left, dir_right, pwm_out);

        $stop;
    end
endmodule