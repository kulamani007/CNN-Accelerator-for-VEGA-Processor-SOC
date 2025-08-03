`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2025 21:56:01
// Design Name: 
// Module Name: motor_control
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


module motor_control (
    input        clk,
    input        rst,
    input [7:0]  object_position,  // e.g., 0 (left), 128 (center), 255 (right)
    output reg   pwm_out,
    output reg   dir_left,
    output reg   dir_right
);

    reg [7:0] counter = 0;
    reg [7:0] duty_cycle = 0;

    // PWM Counter Logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            counter <= 0;
        else
            counter <= counter + 1;
    end

    // PWM Signal Generation
    always @(posedge clk or posedge rst) begin
        if (rst)
            pwm_out <= 0;
        else
            pwm_out <= (counter < duty_cycle);
    end

    // Motor Direction & Speed Control based on object position
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            dir_left  <= 0;
            dir_right <= 0;
            duty_cycle <= 0;
        end else begin
            // Assume 128 is center, <128 => left, >128 => right
            if (object_position < 100) begin
                dir_left  <= 1;
                dir_right <= 0;
                duty_cycle <= 8'd200; // Faster turn
            end else if (object_position > 155) begin
                dir_left  <= 0;
                dir_right <= 1;
                duty_cycle <= 8'd200; // Faster turn
            end else begin
                dir_left  <= 0;
                dir_right <= 0;
                duty_cycle <= 8'd100; // Go straight slower
            end
        end
    end
endmodule
