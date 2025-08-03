`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2025 00:14:56
// Design Name: 
// Module Name: top_module_AXI_tb
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




module top_module_AXI_tb();
    reg clk;
    reg rst;
    
    // CNN AXI Interface
    reg [4:0] cnn_awaddr;
    reg [2:0] cnn_awprot;
    reg cnn_awvalid;
    wire cnn_awready;
    reg [31:0] cnn_wdata;
    reg [3:0] cnn_wstrb;
    reg cnn_wvalid;
    wire cnn_wready;
    wire [1:0] cnn_bresp;
    wire cnn_bvalid;
    reg cnn_bready;
    reg [4:0] cnn_araddr;
    reg [2:0] cnn_arprot;
    reg cnn_arvalid;
    wire cnn_arready;
    wire [31:0] cnn_rdata;
    wire [1:0] cnn_rresp;
    wire cnn_rvalid;
    reg cnn_rready;
    
    // Kalman AXI Interface
    reg [3:0] kal_awaddr;
    reg kal_awvalid;
    wire kal_awready;
    reg [31:0] kal_wdata;
    reg kal_wvalid;
    wire kal_wready;
    wire [1:0] kal_bresp;
    wire kal_bvalid;
    reg kal_bready;
    reg [3:0] kal_araddr;
    reg kal_arvalid;
    wire kal_arready;
    wire [31:0] kal_rdata;
    wire [1:0] kal_rresp;
    wire kal_rvalid;
    reg kal_rready;
    
    // Motor AXI Interface
    reg [3:0] motor_awaddr;
    reg motor_awvalid;
    wire motor_awready;
    reg [31:0] motor_wdata;
    reg motor_wvalid;
    wire motor_wready;
    wire [1:0] motor_bresp;
    wire motor_bvalid;
    reg motor_bready;
    reg [3:0] motor_araddr;
    reg motor_arvalid;
    wire motor_arready;
    wire [31:0] motor_rdata;
    wire [1:0] motor_rresp;
    wire motor_rvalid;
    reg motor_rready;
    wire motor_pwm;
    wire motor_dir;
    
    // RLE AXI Interface
    reg [5:0] rle_awaddr;
    reg [2:0] rle_awprot;
    reg rle_awvalid;
    wire rle_awready;
    reg [31:0] rle_wdata;
    reg [3:0] rle_wstrb;
    reg rle_wvalid;
    wire rle_wready;
    wire [1:0] rle_bresp;
    wire rle_bvalid;
    reg rle_bready;
    reg [5:0] rle_araddr;
    reg [2:0] rle_arprot;
    reg rle_arvalid;
    wire rle_arready;
    wire [31:0] rle_rdata;
    wire [1:0] rle_rresp;
    wire rle_rvalid;
    reg rle_rready;
    
    // Outputs
    wire [7:0] gpio_out;
    
    // Instantiate DUT
    top_module dut (
        .clk(clk),
        .rst(rst),
        // CNN
        .cnn_awaddr(cnn_awaddr),
        .cnn_awprot(cnn_awprot),
        .cnn_awvalid(cnn_awvalid),
        .cnn_awready(cnn_awready),
        .cnn_wdata(cnn_wdata),
        .cnn_wstrb(cnn_wstrb),
        .cnn_wvalid(cnn_wvalid),
        .cnn_wready(cnn_wready),
        .cnn_bresp(cnn_bresp),
        .cnn_bvalid(cnn_bvalid),
        .cnn_bready(cnn_bready),
        .cnn_araddr(cnn_araddr),
        .cnn_arprot(cnn_arprot),
        .cnn_arvalid(cnn_arvalid),
        .cnn_arready(cnn_arready),
        .cnn_rdata(cnn_rdata),
        .cnn_rresp(cnn_rresp),
        .cnn_rvalid(cnn_rvalid),
        .cnn_rready(cnn_rready),
        // Kalman
        .kal_awaddr(kal_awaddr),
        .kal_awvalid(kal_awvalid),
        .kal_awready(kal_awready),
        .kal_wdata(kal_wdata),
        .kal_wvalid(kal_wvalid),
        .kal_wready(kal_wready),
        .kal_bresp(kal_bresp),
        .kal_bvalid(kal_bvalid),
        .kal_bready(kal_bready),
        .kal_araddr(kal_araddr),
        .kal_arvalid(kal_arvalid),
        .kal_arready(kal_arready),
        .kal_rdata(kal_rdata),
        .kal_rresp(kal_rresp),
        .kal_rvalid(kal_rvalid),
        .kal_rready(kal_rready),
        // Motor
        .motor_awaddr(motor_awaddr),
        .motor_awvalid(motor_awvalid),
        .motor_awready(motor_awready),
        .motor_wdata(motor_wdata),
        .motor_wvalid(motor_wvalid),
        .motor_wready(motor_wready),
        .motor_bresp(motor_bresp),
        .motor_bvalid(motor_bvalid),
        .motor_bready(motor_bready),
        .motor_araddr(motor_araddr),
        .motor_arvalid(motor_arvalid),
        .motor_arready(motor_arready),
        .motor_rdata(motor_rdata),
        .motor_rresp(motor_rresp),
        .motor_rvalid(motor_rvalid),
        .motor_rready(motor_rready),
        .motor_pwm(motor_pwm),
        .motor_dir(motor_dir),
        // RLE
        .rle_awaddr(rle_awaddr),
        .rle_awprot(rle_awprot),
        .rle_awvalid(rle_awvalid),
        .rle_awready(rle_awready),
        .rle_wdata(rle_wdata),
        .rle_wstrb(rle_wstrb),
        .rle_wvalid(rle_wvalid),
        .rle_wready(rle_wready),
        .rle_bresp(rle_bresp),
        .rle_bvalid(rle_bvalid),
        .rle_bready(rle_bready),
        .rle_araddr(rle_araddr),
        .rle_arprot(rle_arprot),
        .rle_arvalid(rle_arvalid),
        .rle_arready(rle_arready),
        .rle_rdata(rle_rdata),
        .rle_rresp(rle_rresp),
        .rle_rvalid(rle_rvalid),
        .rle_rready(rle_rready),
        // GPIO
        .gpio_out(gpio_out)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // AXI Task: Generic Write
    task axi_write;
        input [31:0] awaddr;
        input [31:0] wdata;
        input [3:0] wstrb;
        output [1:0] bresp;
        input [1:0] port; // 0:CNN, 1:Kalman, 2:Motor, 3:RLE
        
        begin
            // Set address phase
            case(port)
                2'd0: begin // CNN
                    cnn_awaddr = awaddr[4:0];
                    cnn_awvalid = 1'b1;
                    cnn_wdata = wdata;
                    cnn_wstrb = wstrb;
                    cnn_wvalid = 1'b1;
                end
                2'd1: begin // Kalman
                    kal_awaddr = awaddr[3:0];
                    kal_awvalid = 1'b1;
                    kal_wdata = wdata;
                    kal_wvalid = 1'b1;
                end
                2'd2: begin // Motor
                    motor_awaddr = awaddr[3:0];
                    motor_awvalid = 1'b1;
                    motor_wdata = wdata;
                    motor_wvalid = 1'b1;
                end
                2'd3: begin // RLE
                    rle_awaddr = awaddr[5:0];
                    rle_awvalid = 1'b1;
                    rle_wdata = wdata;
                    rle_wstrb = wstrb;
                    rle_wvalid = 1'b1;
                end
            endcase
            
            // Wait for ready
            case(port)
                2'd0: wait(cnn_awready && cnn_wready);
                2'd1: wait(kal_awready && kal_wready);
                2'd2: wait(motor_awready && motor_wready);
                2'd3: wait(rle_awready && rle_wready);
            endcase
            
            @(posedge clk);
            case(port)
                2'd0: begin cnn_awvalid = 0; cnn_wvalid = 0; end
                2'd1: begin kal_awvalid = 0; kal_wvalid = 0; end
                2'd2: begin motor_awvalid = 0; motor_wvalid = 0; end
                2'd3: begin rle_awvalid = 0; rle_wvalid = 0; end
            endcase
            
            // Response phase
            case(port)
                2'd0: begin
                    cnn_bready = 1'b1;
                    wait(cnn_bvalid);
                    bresp = cnn_bresp;
                    @(posedge clk);
                    cnn_bready = 1'b0;
                end
                2'd1: begin
                    kal_bready = 1'b1;
                    wait(kal_bvalid);
                    bresp = kal_bresp;
                    @(posedge clk);
                    kal_bready = 1'b0;
                end
                2'd2: begin
                    motor_bready = 1'b1;
                    wait(motor_bvalid);
                    bresp = motor_bresp;
                    @(posedge clk);
                    motor_bready = 1'b0;
                end
                2'd3: begin
                    rle_bready = 1'b1;
                    wait(rle_bvalid);
                    bresp = rle_bresp;
                    @(posedge clk);
                    rle_bready = 1'b0;
                end
            endcase
        end
    endtask
    
    // AXI Task: Generic Read
    task axi_read;
        input [31:0] araddr;
        output [31:0] rdata;
        output [1:0] rresp;
        input [1:0] port; // 0:CNN, 1:Kalman, 2:Motor, 3:RLE
        
        begin
            // Set address phase
            case(port)
                2'd0: begin
                    cnn_araddr = araddr[4:0];
                    cnn_arvalid = 1'b1;
                end
                2'd1: begin
                    kal_araddr = araddr[3:0];
                    kal_arvalid = 1'b1;
                end
                2'd2: begin
                    motor_araddr = araddr[3:0];
                    motor_arvalid = 1'b1;
                end
                2'd3: begin
                    rle_araddr = araddr[5:0];
                    rle_arvalid = 1'b1;
                end
            endcase
            
            // Wait for ready
            case(port)
                2'd0: wait(cnn_arready);
                2'd1: wait(kal_arready);
                2'd2: wait(motor_arready);
                2'd3: wait(rle_arready);
            endcase
            @(posedge clk);
            case(port)
                2'd0: cnn_arvalid = 0;
                2'd1: kal_arvalid = 0;
                2'd2: motor_arvalid = 0;
                2'd3: rle_arvalid = 0;
            endcase
            
            // Data phase
            case(port)
                2'd0: begin
                    cnn_rready = 1'b1;
                    wait(cnn_rvalid);
                    rdata = cnn_rdata;
                    rresp = cnn_rresp;
                    @(posedge clk);
                    cnn_rready = 1'b0;
                end
                2'd1: begin
                    kal_rready = 1'b1;
                    wait(kal_rvalid);
                    rdata = kal_rdata;
                    rresp = kal_rresp;
                    @(posedge clk);
                    kal_rready = 1'b0;
                end
                2'd2: begin
                    motor_rready = 1'b1;
                    wait(motor_rvalid);
                    rdata = motor_rdata;
                    rresp = motor_rresp;
                    @(posedge clk);
                    motor_rready = 1'b0;
                end
                2'd3: begin
                    rle_rready = 1'b1;
                    wait(rle_rvalid);
                    rdata = rle_rdata;
                    rresp = rle_rresp;
                    @(posedge clk);
                    rle_rready = 1'b0;
                end
            endcase
        end
    endtask
    
    // Test variables
    reg [31:0] read_data;
    reg [1:0] resp;
    integer i;
    reg [7:0] test_image [0:8];
    reg [7:0] test_kernel [0:8];
    integer cnn_expected;
    reg [7:0] test_stream [0:19];
    
    // Main test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        // CNN
        cnn_awaddr = 0; cnn_awprot = 0; cnn_awvalid = 0;
        cnn_wdata = 0; cnn_wstrb = 0; cnn_wvalid = 0;
        cnn_bready = 0;
        cnn_araddr = 0; cnn_arprot = 0; cnn_arvalid = 0;
        cnn_rready = 0;
        // Kalman
        kal_awaddr = 0; kal_awvalid = 0;
        kal_wdata = 0; kal_wvalid = 0;
        kal_bready = 0;
        kal_araddr = 0; kal_arvalid = 0;
        kal_rready = 0;
        // Motor
        motor_awaddr = 0; motor_awvalid = 0;
        motor_wdata = 0; motor_wvalid = 0;
        motor_bready = 0;
        motor_araddr = 0; motor_arvalid = 0;
        motor_rready = 0;
        // RLE
        rle_awaddr = 0; rle_awprot = 0; rle_awvalid = 0;
        rle_wdata = 0; rle_wstrb = 0; rle_wvalid = 0;
        rle_bready = 0;
        rle_araddr = 0; rle_arprot = 0; rle_arvalid = 0;
        rle_rready = 0;
        
        // Apply reset
        #20;
        rst = 0;
        #50;
        rst = 1;
        #20;
        
        $display("Starting testbench...");
        
        // 1. Test CNN IP
        $display("Testing CNN IP...");
        // Initialize test vectors (3x3 image and kernel)
        // Image: 1 to 9
        for(i = 0; i < 9; i = i + 1) begin
            test_image[i] = i + 1;
        end
        // Kernel: identity (diagonal ones)
        test_kernel[0] = 1; test_kernel[1] = 0; test_kernel[2] = 0;
        test_kernel[3] = 0; test_kernel[4] = 1; test_kernel[5] = 0;
        test_kernel[6] = 0; test_kernel[7] = 0; test_kernel[8] = 1;
        
        // Write image pixels (addresses 0 to 8)
        for(i = 0; i < 9; i = i + 1) begin
            axi_write(i, test_image[i], 4'b1111, resp, 0);
            if(resp !== 2'b00) $error("CNN write error at addr %0d", i);
        end
        
        // Write kernel values (addresses 9 to 17)
        for(i = 0; i < 9; i = i + 1) begin
            axi_write(9 + i, test_kernel[i], 4'b1111, resp, 0);
            if(resp !== 2'b00) $error("CNN write error at addr %0d", 9 + i);
        end
        
        // Trigger convolution (write to address 17)
        axi_write(17, 0, 4'b1111, resp, 0);
        if(resp !== 2'b00) $error("CNN trigger error");
        
        // Calculate expected result (dot product: 1*1 + 2*0 + ... + 9*1 = 1+5+9=15)
        cnn_expected = 0;
        for(i = 0; i < 9; i = i + 1)
            cnn_expected = cnn_expected + test_image[i] * test_kernel[i];
        
        // Wait for computation (allow a few cycles)
        #100;
        // Read result from address 21
        axi_read(21, read_data, resp, 0);
        $display("CNN Result: %0d (Expected: %0d)", read_data, cnn_expected);
        if(read_data !== cnn_expected) 
            $error("CNN result mismatch!");
        
        // 2. Test Kalman Filter
        $display("Testing Kalman Filter...");
        // Write measurement value (Q16.16 format: 1.0 = 65536)
        axi_write(0, 32'd65536, 0, resp, 1); // Write 1.0
        if(resp !== 2'b00) $error("Kalman write error");
        
        // Read state estimate
        #100;
        axi_read(8, read_data, resp, 1);
        $display("Kalman Estimate: %0d", read_data);
        // Should be non-zero after measurement
        if(read_data == 0) 
            $error("Kalman estimate not updated!");
        
        // 3. Test Motor Controller
        $display("Testing Motor Controller...");
        // Set speed to 150 (out of 255)
        axi_write(0, 32'd150, 0, resp, 2);
        if(resp !== 2'b00) $error("Motor speed write error");
        
        // Set direction to 1
        axi_write(4, 32'd1, 0, resp, 2);
        if(resp !== 2'b00) $error("Motor dir write error");
        
        // Read back settings
        axi_read(0, read_data, resp, 2);
        $display("Motor Speed: %0d", read_data[7:0]);
        if(read_data[7:0] !== 8'd150) 
            $error("Motor speed readback mismatch!");
        
        axi_read(4, read_data, resp, 2);
        $display("Motor Direction: %0d", read_data[0]);
        if(read_data[0] !== 1'b1) 
            $error("Motor direction readback mismatch!");
        
        // 4. Test RLE Encoder
        $display("Testing RLE Encoder...");
        // Create test stream: "AAAABBBCCD"
        test_stream[0] = "A";
        test_stream[1] = "A";
        test_stream[2] = "A";
        test_stream[3] = "A";
        test_stream[4] = "B";
        test_stream[5] = "B";
        test_stream[6] = "B";
        test_stream[7] = "C";
        test_stream[8] = "C";
        test_stream[9] = "D";
        // Fill rest with zeros
        for(i = 10; i < 20; i = i + 1)
            test_stream[i] = 0;
        
        // Write stream data (addresses 0 to 19)
        for(i = 0; i < 20; i = i + 1) begin
            axi_write(i, test_stream[i], 4'b0001, resp, 3);
            if(resp !== 2'b00) $error("RLE write error at addr %0d", i);
        end
        
        // Trigger encoding (write to address 32)
        axi_write(32, 0, 4'b1111, resp, 3);
        if(resp !== 2'b00) $error("RLE trigger error");
        
        // Wait for encoding
        #100;
        
        // Read encoded results
        // First run: 4 A's
        // Set index to 0 (write to address 36)
        axi_write(36, 0, 4'b1111, resp, 3);
        axi_read(40, read_data, resp, 3); // Read value at address 40
        $display("RLE[0] Value: %0s (Expected: A)", read_data[7:0]);
        if(read_data[7:0] !== "A") $error("RLE value 0 mismatch!");
        
        axi_read(44, read_data, resp, 3); // Read count at address 44
        $display("RLE[0] Count: %0d (Expected: 4)", read_data[7:0]);
        if(read_data[7:0] !== 4) $error("RLE count 0 mismatch!");
        
        // Second run: 3 B's
        // Set index to 1 (write to address 36)
        axi_write(36, 1, 4'b1111, resp, 3);
        axi_read(40, read_data, resp, 3); // Read value
        $display("RLE[1] Value: %0s (Expected: B)", read_data[7:0]);
        if(read_data[7:0] !== "B") $error("RLE value 1 mismatch!");
        
        axi_read(44, read_data, resp, 3); // Read count
        $display("RLE[1] Count: %0d (Expected: 3)", read_data[7:0]);
        if(read_data[7:0] !== 3) $error("RLE count 1 mismatch!");
        
        // Third run: 2 C's
        axi_write(36, 2, 4'b1111, resp, 3);
        axi_read(40, read_data, resp, 3);
        $display("RLE[2] Value: %0s (Expected: C)", read_data[7:0]);
        if(read_data[7:0] !== "C") $error("RLE value 2 mismatch!");
        
        axi_read(44, read_data, resp, 3);
        $display("RLE[2] Count: %0d (Expected: 2)", read_data[7:0]);
        if(read_data[7:0] !== 2) $error("RLE count 2 mismatch!");
        
        // Fourth run: 1 D
        axi_write(36, 3, 4'b1111, resp, 3);
        axi_read(40, read_data, resp, 3);
        $display("RLE[3] Value: %0s (Expected: D)", read_data[7:0]);
        if(read_data[7:0] !== "D") $error("RLE value 3 mismatch!");
        
        axi_read(44, read_data, resp, 3);
        $display("RLE[3] Count: %0d (Expected: 1)", read_data[7:0]);
        if(read_data[7:0] !== 1) $error("RLE count 3 mismatch!");
        
        // Final GPIO check
        $display("GPIO Output: %0d (Expected CNN LSB: %0d)", 
                 gpio_out, cnn_expected[7:0]);
        if(gpio_out !== cnn_expected[7:0])
            $error("GPIO output mismatch!");
        
        // Test completed
        #100;
        $display("All tests completed successfully!");
        $finish;
    end
    
    // Monitor GPIO output
    always @(gpio_out) begin
        $display("[%0t] GPIO_OUT changed to %0d", $time, gpio_out);
    end
    
    // Waveform dump
    initial begin
        $dumpfile("top_module_AXI_tb.vcd");
        $dumpvars(0, top_module_AXI_tb);
    end
endmodule




