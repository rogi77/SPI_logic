`timescale 1ns/ 1ns

module TestBench;
	reg clk_in;
	reg reset;
	reg ss;
	reg mosi;
	reg sclk;
	wire [31:0] data_out;
	reg [31:0] data_in;
	reg wr;
	wire full_led;
	wire empty_led;
	
	integer i;
	
	spi_block U0(
		.clk(clk_in),
		.rst(reset),
		.ss(ss),
		.sclk(sclk),
		.mosi(mosi),
		.wr(wr),
		.data_in(data_in),
		.data_out(data_out),
		.full_alarm_led(full_led),
		.empty_alarm_led(empty_led)
	);
	
	initial begin
		clk_in <= 0;
		reset <= 0;
		sclk <= 0;
		ss <= 1;
		mosi <= 0;
		data_in <= 0;
		wr <= 0;
	end

	always #2 begin
		clk_in <= ~clk_in;
	end

	initial begin
		#110
		reset <= 1;
		#110
		reset <= 0;
		#50
		ss <= 0;
		#90
		sclk <= 1;
		#50
		sclk <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#10
		mosi <= 1;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#90
//		ss <= 1;
		ss <= 0;

		#50
		ss <= 0;
		#90
		sclk <= 1;
		#50
		sclk <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#10
		mosi <= 1;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#10
		mosi <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#10
		mosi <= 1;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#50
		sclk <= 1; 
		#50
		sclk <= 0;
		#90
		ss <= 0;

		#50
		data_in <= 32'h1;
		#20
		wr <= 1;
		#50
		wr <= 0;
		#50
		data_in <= 32'h1;
		#20
		wr <= 1;
		#50
		wr <= 0;



		for (i = 0; i < 520; i = i + 1) begin
			#50
			ss <= 0;
			#90
			sclk <= 1;
			#50
			sclk <= 0;
			#50
			sclk <= 1; 
			#50
			sclk <= 0;
			#50
			sclk <= 1; 
			#50
			sclk <= 0;
			#10
			mosi <= 1;
			#50
			sclk <= 1; 
			#50
			sclk <= 0;
			#10
			mosi <= 0;
			#50
			sclk <= 1; 
			#50
			sclk <= 0;
			#50
			sclk <= 1; 
			#50
			sclk <= 0;
			#10
			mosi <= 1;
			#50
			sclk <= 1; 
			#50
			sclk <= 0;
			#50
			sclk <= 1; 
			#50
			sclk <= 0;
			#90
			ss <= 0;
		end


		
		#70
		data_in <= 32'h0;
		#22
		wr <= 1;
		#4
		wr <= 0;
		#20
		data_in <= 32'h80000000;
		#20
		wr <= 1;
		#4
		wr <= 0;
		#20
		wr <= 1;
		#4
		wr <= 0;
		
		
	end
	
endmodule		
