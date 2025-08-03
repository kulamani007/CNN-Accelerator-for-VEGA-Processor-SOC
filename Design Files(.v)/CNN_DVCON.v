`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2025 17:03:16
// Design Name: 
// Module Name: CNN_DVCON
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


module CNN_DVCON #(parameter DATA_WIDTH = 8, OUT_WIDTH = 20) (
    input                       aclk,
    input                       aresetn,

    // AXI4-Stream Slave Interface (input image patch + kernel)
    input  [DATA_WIDTH*18-1:0]  s_axis_tdata,   // 9 image + 9 kernel values
    input                       s_axis_tvalid,
    output                      s_axis_tready,

    // AXI4-Stream Master Interface (output result)
    output reg [OUT_WIDTH-1:0]  m_axis_tdata,
    output reg                  m_axis_tvalid,
    input                       m_axis_tready
);

    // Internal signals
    reg  [DATA_WIDTH-1:0] img[0:8];
    reg  [DATA_WIDTH-1:0] ker[0:8];
    reg  [2*DATA_WIDTH-1:0] mults[0:8];
    reg  [OUT_WIDTH-1:0] partial_sum;
    integer i;

    // Handshake
    assign s_axis_tready = 1'b1;  // Always ready to accept

    always @(posedge aclk) begin
        if (!aresetn) begin
            m_axis_tvalid <= 0;
            m_axis_tdata <= 0;
            partial_sum <= 0;
        end else begin
            if (s_axis_tvalid) begin
                // Extract image and kernel values
                for (i = 0; i < 9; i = i + 1) begin
                    img[i] <= s_axis_tdata[i*DATA_WIDTH +: DATA_WIDTH];
                    ker[i] <= s_axis_tdata[(i+9)*DATA_WIDTH +: DATA_WIDTH];
                end
            end
        end
    end

    // Stage 1: Multiply
    always @(posedge aclk) begin
        if (!aresetn) begin
            for (i = 0; i < 9; i = i + 1)
                mults[i] <= 0;
        end else begin
            for (i = 0; i < 9; i = i + 1)
                mults[i] <= img[i] * ker[i];
        end
    end

    // Stage 2: Sum and Saturate
    always @(posedge aclk) begin
        if (!aresetn) begin
            partial_sum <= 0;
            m_axis_tvalid <= 0;
        end else begin
            partial_sum <= mults[0] + mults[1] + mults[2] + mults[3] + mults[4] +
                           mults[5] + mults[6] + mults[7] + mults[8];
            // Saturation logic (to OUT_WIDTH max)
            if (partial_sum > {OUT_WIDTH{1'b1}})
                m_axis_tdata <= {OUT_WIDTH{1'b1}};
            else
                m_axis_tdata <= partial_sum;

            m_axis_tvalid <= 1;
        end
    end
endmodule



