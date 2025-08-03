`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2025 20:51:38
// Design Name: 
// Module Name: kalman_filter
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


module kalman_filter (
    input clk,
    input rst,
    input [15:0] measurement,   // Noisy sensor input (e.g., from IMU)
    output reg [15:0] estimate  // Filtered result
);

    // Parameters (fixed-point or constants)
    parameter GAIN = 8'd10;  // Kalman Gain approximation (0.1 scaled to 8-bit = 10)

    reg [15:0] last_estimate;
    reg [15:0] innovation;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            last_estimate <= 0;
            estimate <= 0;
        end else begin
            // innovation = measurement - last_estimate
            innovation <= measurement - last_estimate;
            // new_estimate = last_estimate + GAIN * innovation (scaled)
            estimate <= last_estimate + ((GAIN * innovation) >> 8);
            last_estimate <= estimate;
        end
    end
endmodule
