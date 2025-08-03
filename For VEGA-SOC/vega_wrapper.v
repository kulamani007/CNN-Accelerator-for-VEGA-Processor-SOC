`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2025 21:47:40
// Design Name: 
// Module Name: vega_wrapper
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


module vega_wrapper(
    input  wire        s_axi_aclk,
    input  wire        s_axi_aresetn,
    
    // Simplified AXI-Lite Interface
    input  wire [31:0] s_axi_awaddr,
    input  wire        s_axi_awvalid,
    output wire        s_axi_awready,
    input  wire [31:0] s_axi_wdata,
    input  wire [3:0]  s_axi_wstrb,
    input  wire        s_axi_wvalid,
    output wire        s_axi_wready,
    output wire [1:0]  s_axi_bresp,
    output wire        s_axi_bvalid,
    input  wire        s_axi_bready,
    input  wire [31:0] s_axi_araddr,
    input  wire        s_axi_arvalid,
    output wire        s_axi_arready,
    output wire [31:0] s_axi_rdata,
    output wire [1:0]  s_axi_rresp,
    output wire        s_axi_rvalid,
    input  wire        s_axi_rready,
    
    output wire [7:0]  gpio_out
);

    wire rst = ~s_axi_aresetn;  // Convert to active-high reset
    
    top_module your_accelerator (
        .clk(s_axi_aclk),
        .rst(rst),
        
        // CNN AXI
        .cnn_awaddr(s_axi_awaddr[4:0]),
        .cnn_awprot(3'b0),
        .cnn_awvalid(s_axi_awvalid),
        .cnn_awready(s_axi_awready),
        .cnn_wdata(s_axi_wdata),
        .cnn_wstrb(s_axi_wstrb),
        .cnn_wvalid(s_axi_wvalid),
        .cnn_wready(s_axi_wready),
        .cnn_bresp(s_axi_bresp),
        .cnn_bvalid(s_axi_bvalid),
        .cnn_bready(s_axi_bready),
        .cnn_araddr(s_axi_araddr[4:0]),
        .cnn_arprot(3'b0),
        .cnn_arvalid(s_axi_arvalid),
        .cnn_arready(s_axi_arready),
        .cnn_rdata(s_axi_rdata),
        .cnn_rresp(s_axi_rresp),
        .cnn_rvalid(s_axi_rvalid),
        .cnn_rready(s_axi_rready),
        
        // Tie off unused interfaces
        .kal_awaddr(4'b0),
        .kal_awvalid(1'b0),
        .kal_wdata(32'b0),
        .kal_wvalid(1'b0),
        .kal_bready(1'b0),
        .kal_araddr(4'b0),
        .kal_arvalid(1'b0),
        .kal_rready(1'b0),
        
        .motor_awaddr(4'b0),
        .motor_awvalid(1'b0),
        .motor_wdata(32'b0),
        .motor_wvalid(1'b0),
        .motor_bready(1'b0),
        .motor_araddr(4'b0),
        .motor_arvalid(1'b0),
        .motor_rready(1'b0),
        
        .rle_awaddr(6'b0),
        .rle_awvalid(1'b0),
        .rle_wdata(32'b0),
        .rle_wvalid(1'b0),
        .rle_bready(1'b0),
        .rle_araddr(6'b0),
        .rle_arvalid(1'b0),
        .rle_rready(1'b0),
        
        .gpio_out(gpio_out),
        
        // Unused outputs
        .motor_pwm(),
        .motor_dir()
    );
endmodule