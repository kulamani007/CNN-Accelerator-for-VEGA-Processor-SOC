module top_module (
    input wire clk,
    input wire rst,

    // CNN AXI Interface
    input wire [4:0] cnn_awaddr,
    input wire [2:0] cnn_awprot,
    input wire cnn_awvalid,
    output wire cnn_awready,
    input wire [31:0] cnn_wdata,
    input wire [3:0] cnn_wstrb,
    input wire cnn_wvalid,
    output wire cnn_wready,
    output wire [1:0] cnn_bresp,
    output wire cnn_bvalid,
    input wire cnn_bready,
    input wire [4:0] cnn_araddr,
    input wire [2:0] cnn_arprot,
    input wire cnn_arvalid,
    output wire cnn_arready,
    output wire [31:0] cnn_rdata,
    output wire [1:0] cnn_rresp,
    output wire cnn_rvalid,
    input wire cnn_rready,

    // Kalman AXI Interface
    input wire [3:0] kal_awaddr,
    input wire kal_awvalid,
    output wire kal_awready,
    input wire [31:0] kal_wdata,
    input wire kal_wvalid,
    output wire kal_wready,
    output wire [1:0] kal_bresp,
    output wire kal_bvalid,
    input wire kal_bready,
    input wire [3:0] kal_araddr,
    input wire kal_arvalid,
    output wire kal_arready,
    output wire [31:0] kal_rdata,
    output wire [1:0] kal_rresp,
    output wire kal_rvalid,
    input wire kal_rready,

    // Motor AXI Interface
    input wire [3:0] motor_awaddr,
    input wire motor_awvalid,
    output wire motor_awready,
    input wire [31:0] motor_wdata,
    input wire motor_wvalid,
    output wire motor_wready,
    output wire [1:0] motor_bresp,
    output wire motor_bvalid,
    input wire motor_bready,
    input wire [3:0] motor_araddr,
    input wire motor_arvalid,
    output wire motor_arready,
    output wire [31:0] motor_rdata,
    output wire [1:0] motor_rresp,
    output wire motor_rvalid,
    input wire motor_rready,
    output wire motor_pwm,
    output wire motor_dir,

    // RLE AXI Interface
    input wire [5:0] rle_awaddr,
    input wire [2:0] rle_awprot,
    input wire rle_awvalid,
    output wire rle_awready,
    input wire [31:0] rle_wdata,
    input wire [3:0] rle_wstrb,
    input wire rle_wvalid,
    output wire rle_wready,
    output wire [1:0] rle_bresp,
    output wire rle_bvalid,
    input wire rle_bready,
    input wire [5:0] rle_araddr,
    input wire [2:0] rle_arprot,
    input wire rle_arvalid,
    output wire rle_arready,
    output wire [31:0] rle_rdata,
    output wire [1:0] rle_rresp,
    output wire rle_rvalid,
    input wire rle_rready,

    // Final Output
    output wire [7:0] gpio_out
);

    wire [19:0] cnn_output;

    // CNN IP
    cnn_axi_v1_0 cnn_inst (
        .s00_axi_aclk(clk),
        .s00_axi_aresetn(~rst),
        .s00_axi_awaddr(cnn_awaddr),
        .s00_axi_awprot(cnn_awprot),
        .s00_axi_awvalid(cnn_awvalid),
        .s00_axi_awready(cnn_awready),
        .s00_axi_wdata(cnn_wdata),
        .s00_axi_wstrb(cnn_wstrb),
        .s00_axi_wvalid(cnn_wvalid),
        .s00_axi_wready(cnn_wready),
        .s00_axi_bresp(cnn_bresp),
        .s00_axi_bvalid(cnn_bvalid),
        .s00_axi_bready(cnn_bready),
        .s00_axi_araddr(cnn_araddr),
        .s00_axi_arprot(cnn_arprot),
        .s00_axi_arvalid(cnn_arvalid),
        .s00_axi_arready(cnn_arready),
        .s00_axi_rdata(cnn_rdata),
        .s00_axi_rresp(cnn_rresp),
        .s00_axi_rvalid(cnn_rvalid),
        .s00_axi_rready(cnn_rready),
        .gpio_output(cnn_output)
    );

    // Kalman IP
    kalman_axi kalman_inst (
        .s00_axi_aclk(clk),
        .s00_axi_aresetn(~rst),
        .s00_axi_awaddr(kal_awaddr),
        .s00_axi_awvalid(kal_awvalid),
        .s00_axi_awready(kal_awready),
        .s00_axi_wdata(kal_wdata),
        .s00_axi_wvalid(kal_wvalid),
        .s00_axi_wready(kal_wready),
        .s00_axi_bresp(kal_bresp),
        .s00_axi_bvalid(kal_bvalid),
        .s00_axi_bready(kal_bready),
        .s00_axi_araddr(kal_araddr),
        .s00_axi_arvalid(kal_arvalid),
        .s00_axi_arready(kal_arready),
        .s00_axi_rdata(kal_rdata),
        .s00_axi_rresp(kal_rresp),
        .s00_axi_rvalid(kal_rvalid),
        .s00_axi_rready(kal_rready)
    );

    // Motor IP
    motor_axi motor_inst (
        .s00_axi_aclk(clk),
        .s00_axi_aresetn(~rst),
        .s00_axi_awaddr(motor_awaddr),
        .s00_axi_awvalid(motor_awvalid),
        .s00_axi_awready(motor_awready),
        .s00_axi_wdata(motor_wdata),
        .s00_axi_wvalid(motor_wvalid),
        .s00_axi_wready(motor_wready),
        .s00_axi_bresp(motor_bresp),
        .s00_axi_bvalid(motor_bvalid),
        .s00_axi_bready(motor_bready),
        .s00_axi_araddr(motor_araddr),
        .s00_axi_arvalid(motor_arvalid),
        .s00_axi_arready(motor_arready),
        .s00_axi_rdata(motor_rdata),
        .s00_axi_rresp(motor_rresp),
        .s00_axi_rvalid(motor_rvalid),
        .s00_axi_rready(motor_rready),
        .motor_pwm(motor_pwm),
        .motor_dir(motor_dir)
    );

    // RLE IP
    rle_axi rle_inst (
        .s00_axi_aclk(clk),
        .s00_axi_aresetn(~rst),
        .s00_axi_awaddr(rle_awaddr),
        .s00_axi_awprot(rle_awprot),
        .s00_axi_awvalid(rle_awvalid),
        .s00_axi_awready(rle_awready),
        .s00_axi_wdata(rle_wdata),
        .s00_axi_wstrb(rle_wstrb),
        .s00_axi_wvalid(rle_wvalid),
        .s00_axi_wready(rle_wready),
        .s00_axi_bresp(rle_bresp),
        .s00_axi_bvalid(rle_bvalid),
        .s00_axi_bready(rle_bready),
        .s00_axi_araddr(rle_araddr),
        .s00_axi_arprot(rle_arprot),
        .s00_axi_arvalid(rle_arvalid),
        .s00_axi_arready(rle_arready),
        .s00_axi_rdata(rle_rdata),
        .s00_axi_rresp(rle_rresp),
        .s00_axi_rvalid(rle_rvalid),
        .s00_axi_rready(rle_rready)
    );

    assign gpio_out = cnn_output[7:0];  // From CNN IP

endmodule




module cnn_axi_v1_0 #(
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 5
)(
    input wire  s00_axi_aclk,
    input wire  s00_axi_aresetn,

    // AXI Slave Interface
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
    input wire [2 : 0] s00_axi_awprot,
    input wire  s00_axi_awvalid,
    output wire  s00_axi_awready,
    input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
    input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
    input wire  s00_axi_wvalid,
    output wire  s00_axi_wready,
    output wire [1 : 0] s00_axi_bresp,
    output wire  s00_axi_bvalid,
    input wire  s00_axi_bready,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
    input wire [2 : 0] s00_axi_arprot,
    input wire  s00_axi_arvalid,
    output wire  s00_axi_arready,
    output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
    output wire [1 : 0] s00_axi_rresp,
    output wire  s00_axi_rvalid,
    input wire  s00_axi_rready,

    // GPIO-style result output
    output wire [19:0] gpio_output
);

    // AXI Registers
    reg [7:0] image [0:8];
    reg [7:0] kernel[0:8];
    reg [19:0] result;

    reg [C_S00_AXI_DATA_WIDTH-1:0] axi_rdata;
    reg axi_awready, axi_wready, axi_bvalid, axi_rvalid;
    reg [1:0] axi_bresp, axi_rresp;

    assign s00_axi_awready = axi_awready;
    assign s00_axi_wready  = axi_wready;
    assign s00_axi_bresp   = axi_bresp;
    assign s00_axi_bvalid  = axi_bvalid;
    assign s00_axi_arready = axi_awready;
    assign s00_axi_rdata   = axi_rdata;
    assign s00_axi_rresp   = axi_rresp;
    assign s00_axi_rvalid  = axi_rvalid;

    assign gpio_output = result;

    integer i;
    reg [19:0] temp_result;

    always @(posedge s00_axi_aclk) begin
        if (!s00_axi_aresetn) begin
            axi_awready <= 0;
            axi_wready  <= 0;
            axi_bvalid  <= 0;
            axi_rvalid  <= 0;
            axi_rresp   <= 2'b00;
            axi_bresp   <= 2'b00;
            axi_rdata   <= 0;
            result      <= 0;
        end else begin
            // Write address and data handshake
            if (s00_axi_awvalid && !axi_awready)
                axi_awready <= 1;
            else
                axi_awready <= 0;

            if (s00_axi_wvalid && !axi_wready)
                axi_wready <= 1;
            else
                axi_wready <= 0;

            // Write operation
            if (axi_awready && s00_axi_awvalid && axi_wready && s00_axi_wvalid) begin
                axi_bvalid <= 1;
                case (s00_axi_awaddr)
                    5'd0:  image[0]  <= s00_axi_wdata[7:0];
                    5'd1:  image[1]  <= s00_axi_wdata[7:0];
                    5'd2:  image[2]  <= s00_axi_wdata[7:0];
                    5'd3:  image[3]  <= s00_axi_wdata[7:0];
                    5'd4:  image[4]  <= s00_axi_wdata[7:0];
                    5'd5:  image[5]  <= s00_axi_wdata[7:0];
                    5'd6:  image[6]  <= s00_axi_wdata[7:0];
                    5'd7:  image[7]  <= s00_axi_wdata[7:0];
                    5'd8:  image[8]  <= s00_axi_wdata[7:0];

                    5'd9:  kernel[0] <= s00_axi_wdata[7:0];
                    5'd10: kernel[1] <= s00_axi_wdata[7:0];
                    5'd11: kernel[2] <= s00_axi_wdata[7:0];
                    5'd12: kernel[3] <= s00_axi_wdata[7:0];
                    5'd13: kernel[4] <= s00_axi_wdata[7:0];
                    5'd14: kernel[5] <= s00_axi_wdata[7:0];
                    5'd15: kernel[6] <= s00_axi_wdata[7:0];
                    5'd16: kernel[7] <= s00_axi_wdata[7:0];
                    5'd17: begin
                        kernel[8] <= s00_axi_wdata[7:0];
                        temp_result = 0;
                        for (i = 0; i < 9; i = i + 1)
                            temp_result = temp_result + (image[i] * kernel[i]);
                        result <= temp_result;
                    end
                endcase
            end else begin
                axi_bvalid <= 0;
            end

            // Read operation
            if (s00_axi_arvalid && !axi_rvalid) begin
                axi_rvalid <= 1;
                case (s00_axi_araddr)
                    5'd21: axi_rdata <= result;
                    default: axi_rdata <= 32'hDEADBEEF;
                endcase
            end else if (axi_rvalid && s00_axi_rready) begin
                axi_rvalid <= 0;
            end
        end
    end

endmodule


module kalman_axi #(
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 4
)(
    input wire s00_axi_aclk,
    input wire s00_axi_aresetn,

    // AXI-Lite Slave Interface
    input  wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
    input  wire s00_axi_awvalid,
    output wire s00_axi_awready,
    input  wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
    input  wire s00_axi_wvalid,
    output wire s00_axi_wready,
    output wire [1 : 0] s00_axi_bresp,
    output wire s00_axi_bvalid,
    input  wire s00_axi_bready,

    input  wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
    input  wire s00_axi_arvalid,
    output wire s00_axi_arready,
    output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
    output wire [1 : 0] s00_axi_rresp,
    output wire s00_axi_rvalid,
    input  wire s00_axi_rready
);

    // Fixed-point parameters (Q16.16 format)
    reg signed [31:0] Q = 32'd6554;   // 0.1 in Q16.16
    reg signed [31:0] R = 32'd65536;  // 1.0 in Q16.16

    reg signed [31:0] x = 0;          // Estimate
    reg signed [31:0] P = 32'd65536;  // Error covariance (start with 1.0)
    reg signed [31:0] K = 0;          // Kalman gain
    reg signed [31:0] z = 0;          // Measurement

    // AXI registers
    reg [31:0] axi_rdata;
    reg axi_awready, axi_wready, axi_bvalid, axi_rvalid;
    reg [1:0] axi_bresp, axi_rresp;

    assign s00_axi_awready = axi_awready;
    assign s00_axi_wready  = axi_wready;
    assign s00_axi_bresp   = axi_bresp;
    assign s00_axi_bvalid  = axi_bvalid;
    assign s00_axi_arready = axi_awready;
    assign s00_axi_rdata   = axi_rdata;
    assign s00_axi_rresp   = axi_rresp;
    assign s00_axi_rvalid  = axi_rvalid;

    always @(posedge s00_axi_aclk) begin
        if (!s00_axi_aresetn) begin
            x <= 0;
            P <= 32'd65536;
            axi_awready <= 0;
            axi_wready <= 0;
            axi_bvalid <= 0;
            axi_rvalid <= 0;
            axi_rdata <= 0;
            axi_rresp <= 2'b00;
            axi_bresp <= 2'b00;
        end else begin
            // Write operation
            axi_awready <= s00_axi_awvalid;
            axi_wready <= s00_axi_wvalid;

            if (s00_axi_awvalid && s00_axi_wvalid) begin
                axi_bvalid <= 1;
                case (s00_axi_awaddr)
                    4'h0: begin
                        z = s00_axi_wdata;

                        // Kalman Gain: K = P / (P + R)
                        K = (P <<< 16) / (P + R);  // <<< 16 is equivalent to multiplying by 2^16

                        // Estimate update: x = x + K * (z - x)
                        x = x + ((K * (z - x)) >>> 16);

                        // Error covariance update: P = (1 - K) * P
                        P = (((32'd65536 - K) * P) >>> 16);
                    end
                    4'h4: begin
                        x <= 0;
                        P <= 32'd65536;
                    end
                endcase
            end else begin
                axi_bvalid <= 0;
            end

            // Read operation
            if (s00_axi_arvalid && !axi_rvalid) begin
                axi_rvalid <= 1;
                case (s00_axi_araddr)
                    4'h8: axi_rdata <= x;  // Return fixed-point estimate
                    default: axi_rdata <= 32'hDEADBEEF;
                endcase
            end else begin
                axi_rvalid <= 0;
            end
        end
    end

endmodule



module motor_axi #
(
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 4
)
(
    input wire  s00_axi_aclk,
    input wire  s00_axi_aresetn,

    // AXI Slave Interface
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
    input wire  s00_axi_awvalid,
    output wire  s00_axi_awready,
    input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
    input wire  s00_axi_wvalid,
    output wire  s00_axi_wready,
    output wire [1 : 0] s00_axi_bresp,
    output wire  s00_axi_bvalid,
    input wire  s00_axi_bready,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
    input wire  s00_axi_arvalid,
    output wire  s00_axi_arready,
    output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
    output wire [1 : 0] s00_axi_rresp,
    output wire  s00_axi_rvalid,
    input wire  s00_axi_rready,

    // Custom Output GPIOs
    output wire motor_dir,         // Motor Direction
    output wire motor_pwm          // Motor Speed (PWM)
);

    // Internal registers
    reg [7:0] speed_reg;         // 8-bit speed control
    reg dir_reg;                 // 1-bit direction control
    reg pwm_out;                 // Internal PWM
    reg [7:0] pwm_counter;

    // AXI signals
    reg [31:0] axi_rdata;
    reg axi_awready, axi_wready, axi_bvalid, axi_rvalid;
    reg [1:0] axi_bresp, axi_rresp;

    assign motor_dir = dir_reg;
    assign motor_pwm = pwm_out;

    assign s00_axi_awready = axi_awready;
    assign s00_axi_wready  = axi_wready;
    assign s00_axi_bresp   = axi_bresp;
    assign s00_axi_bvalid  = axi_bvalid;
    assign s00_axi_arready = axi_awready;
    assign s00_axi_rdata   = axi_rdata;
    assign s00_axi_rresp   = axi_rresp;
    assign s00_axi_rvalid  = axi_rvalid;

    // Clocked logic
    always @(posedge s00_axi_aclk) begin
        if (!s00_axi_aresetn) begin
            axi_awready <= 0;
            axi_wready <= 0;
            axi_bvalid <= 0;
            axi_rvalid <= 0;
            axi_bresp <= 0;
            axi_rresp <= 0;
            axi_rdata <= 0;
            speed_reg <= 0;
            dir_reg <= 0;
            pwm_counter <= 0;
        end else begin
            // Write operation
            axi_awready <= s00_axi_awvalid;
            axi_wready <= s00_axi_wvalid;

            if (s00_axi_awvalid && s00_axi_wvalid) begin
                axi_bvalid <= 1;
                case (s00_axi_awaddr)
                    4'h00: speed_reg <= s00_axi_wdata[7:0]; // Speed control
                    4'h04: dir_reg   <= s00_axi_wdata[0];   // Direction control
                endcase
            end else begin
                axi_bvalid <= 0;
            end

            // Read operation
            if (s00_axi_arvalid && !axi_rvalid) begin
                axi_rvalid <= 1;
                case (s00_axi_araddr)
                    4'h00: axi_rdata <= {24'b0, speed_reg};
                    4'h04: axi_rdata <= {31'b0, dir_reg};
                    default: axi_rdata <= 32'hDEADBEEF;
                endcase
            end else begin
                axi_rvalid <= 0;
            end

            // PWM Generator
            pwm_counter <= pwm_counter + 1;
            pwm_out <= (pwm_counter < speed_reg);
        end
    end

endmodule


module rle_axi #
(
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 6
)
(
    input wire s00_axi_aclk,
    input wire s00_axi_aresetn,

    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
    input wire [2 : 0] s00_axi_awprot,
    input wire s00_axi_awvalid,
    output wire s00_axi_awready,
    input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
    input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
    input wire s00_axi_wvalid,
    output wire s00_axi_wready,
    output wire [1 : 0] s00_axi_bresp,
    output wire s00_axi_bvalid,
    input wire s00_axi_bready,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
    input wire [2 : 0] s00_axi_arprot,
    input wire s00_axi_arvalid,
    output wire s00_axi_arready,
    output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
    output wire [1 : 0] s00_axi_rresp,
    output wire s00_axi_rvalid,
    input wire s00_axi_rready
);

    // AXI Internal Registers
    reg axi_awready, axi_wready, axi_bvalid, axi_rvalid;
    reg [1:0] axi_bresp = 2'b00, axi_rresp = 2'b00;
    reg [C_S00_AXI_DATA_WIDTH-1:0] axi_rdata = 0;
    assign s00_axi_awready = axi_awready;
    assign s00_axi_wready  = axi_wready;
    assign s00_axi_bresp   = axi_bresp;
    assign s00_axi_bvalid  = axi_bvalid;
    assign s00_axi_arready = axi_awready;
    assign s00_axi_rdata   = axi_rdata;
    assign s00_axi_rresp   = axi_rresp;
    assign s00_axi_rvalid  = axi_rvalid;

    // Internal RLE Storage
    reg [7:0] stream[0:63];               // Input stream (up to 64 bytes)
    reg [7:0] encoded_vals[0:31];         // Encoded output values
    reg [7:0] encoded_counts[0:31];       // Encoded output counts
    reg [5:0] output_idx = 0;             // Index for reading results
    reg [5:0] rle_length = 0;

    // Processing Logic
    integer i;

    always @(posedge s00_axi_aclk) begin
        if (!s00_axi_aresetn) begin
            axi_awready <= 0;
            axi_wready <= 0;
            axi_bvalid <= 0;
            axi_rvalid <= 0;
            axi_rdata <= 0;
            axi_rresp <= 2'b00;
            axi_bresp <= 2'b00;
            output_idx <= 0;
        end else begin
            // Write Channel
            axi_awready <= s00_axi_awvalid;
            axi_wready <= s00_axi_wvalid;

            if (s00_axi_awvalid && s00_axi_wvalid) begin
                axi_bvalid <= 1;
                case (s00_axi_awaddr)
                    6'd0  : stream[0]  <= s00_axi_wdata;
                    6'd1  : stream[1]  <= s00_axi_wdata;
                    6'd2  : stream[2]  <= s00_axi_wdata;
                    6'd3  : stream[3]  <= s00_axi_wdata;
                    6'd4  : stream[4]  <= s00_axi_wdata;
                    6'd5  : stream[5]  <= s00_axi_wdata;
                    6'd6  : stream[6]  <= s00_axi_wdata;
                    6'd7  : stream[7]  <= s00_axi_wdata;
                    6'd8  : stream[8]  <= s00_axi_wdata;
                    6'd9  : stream[9]  <= s00_axi_wdata;
                    6'd10 : stream[10] <= s00_axi_wdata;
                    6'd11 : stream[11] <= s00_axi_wdata;
                    6'd12 : stream[12] <= s00_axi_wdata;
                    6'd13 : stream[13] <= s00_axi_wdata;
                    6'd14 : stream[14] <= s00_axi_wdata;
                    6'd15 : stream[15] <= s00_axi_wdata;
                    6'd16 : stream[16] <= s00_axi_wdata;
                    6'd17 : stream[17] <= s00_axi_wdata;
                    6'd18 : stream[18] <= s00_axi_wdata;
                    6'd19 : stream[19] <= s00_axi_wdata;

                    6'd32: begin
                        // Synthesis-safe RLE Encoding
                        rle_length <= 0;
                        encoded_vals[0] <= stream[0];
                        encoded_counts[0] <= 1;
                        rle_length <= 1;

                        for (i = 1; i < 20; i = i + 1) begin
                            if (stream[i] == stream[i-1]) begin
                                encoded_counts[rle_length - 1] <= encoded_counts[rle_length - 1] + 1;
                            end else begin
                                encoded_vals[rle_length] <= stream[i];
                                encoded_counts[rle_length] <= 1;
                                rle_length <= rle_length + 1;
                            end
                        end
                    end

                    6'd36: output_idx <= s00_axi_wdata;  // Set output index
                endcase
            end else begin
                axi_bvalid <= 0;
            end

            // Read Channel
            if (s00_axi_arvalid && !axi_rvalid) begin
                axi_rvalid <= 1;
                case (s00_axi_araddr)
                    6'd40: axi_rdata <= encoded_vals[output_idx];   // Read value
                    6'd44: axi_rdata <= encoded_counts[output_idx]; // Read count
                    default: axi_rdata <= 32'hDEADBEEF;
                endcase
            end else begin
                axi_rvalid <= 0;
            end
        end
    end

endmodule