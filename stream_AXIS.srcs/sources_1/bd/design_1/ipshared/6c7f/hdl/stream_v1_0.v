`timescale 1 ns / 1 ps

module SobelX(
    input clk,
    input en,
    input [31:0] stream_input,   
    output[31:0] stream_output
    );
    
parameter WIDTH = 695; 
reg signed [31:0] x [2*WIDTH+2:0];  // shift-register sliding buffer
reg signed [31:0] acc;
reg signed [31:0] y;  // 32-bit output pixel
integer i;

initial 
    begin
    for (i = 0; i < (2*WIDTH+2); i=i+1)
        x[i] = 0; // initialize all buffer pixels to 0
    end

always @(posedge clk) begin
    if (en) begin
        // Move the stream_input pixel into the line buffer
        x[0] <= $signed(stream_input);
         
        // Apply the sobel filter (x-dir)
        acc <= x[0]-x[2]+(x[695]-x[695+2])*2+x[2*695]-x[2*695+2];
        
        // Get a grayscale average
        y <= acc / 8 + 128;   

        // Shift each pixel value in the buffer 1 index to the left
        for(i = (2*WIDTH+2); i > 0; i=i-1)
            begin
            x[i] = x[i - 1];            
            end
        end 
    end

assign stream_output = y; 

endmodule 

module stream_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Parameters of Axi Slave Bus Interface S00_AXIS
		parameter integer C_S00_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Master Bus Interface M00_AXIS
		parameter integer C_M00_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M00_AXIS_START_COUNT	= 32
	)
	(
		// Users to add ports here
		
		// User ports ends
		// Do not modify the ports beyond this line

		// Ports of Axi Slave Bus Interface S00_AXIS
		input wire  s00_axis_aclk,
		input wire  s00_axis_aresetn,
		output wire  s00_axis_tready,
		input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
		input wire  s00_axis_tlast,
		input wire  s00_axis_tvalid,

		// Ports of Axi Master Bus Interface M00_AXIS
		input wire  m00_axis_aclk,
		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
		output wire  m00_axis_tlast,
		input wire  m00_axis_tready
	);
	
	wire [31:0]stream_output;
	
	//Declare reg for enable
	reg en = 1'b1; 
	//Instantiate SobelX filter
    	SobelX inst_1(.clk(m00_axis_aclk),.en(en),.stream_input(s00_axis_tdata),.stream_output(stream_output));
	
	//Declare reg for stream input 
	reg stream_input_reg;
	
	reg m00_axis_tvalid_reg;
	reg m00_axis_tlast_reg;
	reg [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata_reg;
	
    reg s00_axis_tready_reg;
    
    assign m00_axis_tvalid = m00_axis_tvalid_reg;
    assign m00_axis_tlast = m00_axis_tlast_reg;
    assign m00_axis_tdata = m00_axis_tdata_reg;
    assign s00_axis_tready = s00_axis_tready_reg;
	
    //assign stream input to its register
    // assign stream_input = stream_input_reg;
    //assign enable = enable_reg;   
    
    always @(posedge s00_axis_aclk)begin
        if (s00_axis_aresetn==0)begin
            s00_axis_tready_reg <= 0;
        end else begin
            s00_axis_tready_reg <= m00_axis_tready;
        end
    end
	
	always @(posedge m00_axis_aclk)begin
        if (m00_axis_aresetn==0)begin
            m00_axis_tvalid_reg <= 0;
            m00_axis_tlast_reg <= 0;
            m00_axis_tdata_reg <= 0;
        end else begin
            m00_axis_tvalid_reg <= s00_axis_tvalid;
            m00_axis_tlast_reg <= s00_axis_tlast;
            stream_input_reg <= s00_axis_tdata;
	    m00_axis_tdata_reg <= stream_output;
        end
    end

endmodule