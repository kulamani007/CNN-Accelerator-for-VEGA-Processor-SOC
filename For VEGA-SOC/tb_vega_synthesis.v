`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2025 21:50:11
// Design Name: 
// Module Name: tb_vega_synthesis
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


module tb_vega_soc_integration();

    // Clock and Reset
    reg clk;
    reg rst_n;  // Active low reset

    // AXI-lite interface wires
    reg  [31:0] awaddr;
    reg         awvalid;
    wire        awready;
    reg  [31:0] wdata;
    reg  [3:0]  wstrb;
    reg         wvalid;
    wire        wready;
    wire [1:0]  bresp;
    wire        bvalid;
    reg         bready;
    reg  [31:0] araddr;
    reg         arvalid;
    wire        arready;
    wire [31:0] rdata;
    wire [1:0]  rresp;
    wire        rvalid;
    reg         rready;

    // Outputs
    wire [7:0] gpio_out;

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Instantiate the DUT
    vega_wrapper uut (
        .s_axi_aclk(clk),
        .s_axi_aresetn(rst_n),
        .s_axi_awaddr(awaddr),
        .s_axi_awvalid(awvalid),
        .s_axi_awready(awready),
        .s_axi_wdata(wdata),
        .s_axi_wstrb(wstrb),
        .s_axi_wvalid(wvalid),
        .s_axi_wready(wready),
        .s_axi_bresp(bresp),
        .s_axi_bvalid(bvalid),
        .s_axi_bready(bready),
        .s_axi_araddr(araddr),
        .s_axi_arvalid(arvalid),
        .s_axi_arready(arready),
        .s_axi_rdata(rdata),
        .s_axi_rresp(rresp),
        .s_axi_rvalid(rvalid),
        .s_axi_rready(rready),
        .gpio_out(gpio_out)
    );

    // AXI Write Task
    task axi_write;
        input [31:0] addr;
        input [31:0] data;
        begin
            @(posedge clk);
            awaddr <= addr;
            awvalid <= 1;
            wdata <= data;
            wstrb <= 4'b1111;
            wvalid <= 1;
            bready <= 1;

            wait(awready && wready);
            @(posedge clk);
            awvalid <= 0;
            wvalid <= 0;
            wait(bvalid);
            @(posedge clk);
            bready <= 0;
        end
    endtask

    // AXI Read Task
    task axi_read;
        input [31:0] addr;
        output [31:0] out_data;
        begin
            @(posedge clk);
            araddr <= addr;
            arvalid <= 1;
            rready <= 1;

            wait(arready);
            @(posedge clk);
            arvalid <= 0;

            wait(rvalid);
            out_data = rdata;
            @(posedge clk);
            rready <= 0;
        end
    endtask

    integer i;
    reg [31:0] temp;

    // Simulation sequence
    initial begin
        // Initialize
        rst_n = 0;
        awaddr = 0; awvalid = 0;
        wdata = 0;  wstrb = 0; wvalid = 0;
        bready = 0; araddr = 0;
        arvalid = 0; rready = 0;

        #50 rst_n = 1;
        #50;

        $display("\n[INFO] --- Starting CNN IP Transaction ---");
        // Load CNN image and kernel data
        for (i = 0; i < 9; i = i + 1) begin
            axi_write(i, i+1);  // image: 1 to 9
        end
        for (i = 0; i < 9; i = i + 1) begin
            axi_write(i+9, i+1);  // kernel: 1 to 9
        end
        axi_write(17, 0);  // Trigger convolution
        axi_read(21, temp);
        $display("CNN Output: %0d", temp);

        $display("\n[INFO] --- GPIO Output: %0d ---", gpio_out);

        $display("\n[INFO] --- Testing KALMAN Module ---");
        axi_write(0, 32'd65536); // Write 1.0 measurement (Q16.16)
        axi_read(8, temp);
        $display("Kalman Estimate: %0d", temp);

        $display("\n[INFO] --- Testing MOTOR Module ---");
        axi_write(0, 32'd150); // Speed
        axi_write(4, 32'd1);   // Direction
        axi_read(0, temp);
        $display("Motor Speed: %0d", temp);
        axi_read(4, temp);
        $display("Motor Direction: %0d", temp);

        $display("\n[INFO] --- Testing RLE Module ---");
        // Input: AAAABBBCCD (char "A"=65, "B"=66, etc.)
        axi_write(0, 65); axi_write(1, 65); axi_write(2, 65); axi_write(3, 65);
        axi_write(4, 66); axi_write(5, 66); axi_write(6, 66);
        axi_write(7, 67); axi_write(8, 67); axi_write(9, 68);
        axi_write(32, 0); // Trigger encoding
        axi_write(36, 0); // Set index to 0
        axi_read(40, temp); $display("RLE[0] Value: %c", temp[7:0]);
        axi_read(44, temp); $display("RLE[0] Count: %0d", temp[7:0]);

        axi_write(36, 1);
        axi_read(40, temp); $display("RLE[1] Value: %c", temp[7:0]);
        axi_read(44, temp); $display("RLE[1] Count: %0d", temp[7:0]);

        #100;
        $display("\n[INFO] --- Testbench Finished ---");
        $finish;
    end

    // Waveform
    initial begin
        $dumpfile("vega_soc_integration.vcd");
        $dumpvars(0, tb_vega_soc_integration);
    end

endmodule
