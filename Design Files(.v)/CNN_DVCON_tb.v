`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2025 17:08:51
// Design Name: 
// Module Name: CNN_DVCON_tb
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


module CNN_DVCON_tb;
    reg clk = 0;
    reg rstn;
    reg [143:0] tdata; // 18 x 8-bit = 144 bits
    reg tvalid;
    wire tready;
    wire [19:0] result;
    wire valid;
    reg ready = 1;

    CNN_DVCON uut (
        .aclk(clk),
        .aresetn(rstn),
        .s_axis_tdata(tdata),
        .s_axis_tvalid(tvalid),
        .s_axis_tready(tready),
        .m_axis_tdata(result),
        .m_axis_tvalid(valid),
        .m_axis_tready(ready)
    );

    always #5 clk = ~clk;

        initial begin
        rstn = 0;
        tvalid = 0;
        tdata = 0;
        #20;
        rstn = 1;
        #10;

        // Provide valid sample input
        // IMAGE: [10,20,30,40,50,60,70,80,90]
        // KERNEL: [1,0,-1,1,0,-1,1,0,-1] --> for Verilog unsigned, -1 = 8'd255

        tdata = {
            8'd1,   8'd0,   8'd255,   // ker0, ker1, ker2
            8'd1,   8'd0,   8'd255,   // ker3, ker4, ker5
            8'd1,   8'd0,   8'd255,   // ker6, ker7, ker8
            8'd10,  8'd20,  8'd30,    // img0, img1, img2
            8'd40,  8'd50,  8'd60,    // img3, img4, img5
            8'd70,  8'd80,  8'd90     // img6, img7, img8
        };  // Concatenated from MSB to LSB

        tvalid = 1;
        #10;
        tvalid = 0;

        wait(valid == 1);
        $display("Convolution Result: %d", result);
        #10;
        $stop;
    end

endmodule

