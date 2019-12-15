module fifo_controller(clk, din, wclk, fifo_rclk, rst, fifo_rst, fullflag, fullflag_alarm);
	input clk;
	input [31:0] din;
	input wclk;
	input rst;
	output fifo_rclk;
	output fifo_rst;
	input fullflag;
	output fullflag_alarm;
	
//	reg reg_fifo_rclk, reg_fifo_rclk_q, reg_fifo_rclk_oneshot_end;
	reg reg1, reg2, reg3;
	wire d31AndWrclk;
	reg fullflag_q;
	assign fullflag_alarm = fullflag_q;
	
	assign d31AndWrclk = din[31] & wclk;
	assign fifo_rst = din[16] & wclk;
//	assign fifo_rclk = reg_fifo_rclk_q;
	assign fifo_rclk = reg2 & ~reg3;
	
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			reg1 <= 1'b0;
//			reg_fifo_rclk <= 1'b0;
//			reg_fifo_rclk_oneshot_end <= 1'b0;
//			reg_fifo_rclk_q <= 1'b0;
		end
		if(wclk) begin
//			reg_fifo_rclk <= din[0];
			reg1 <= din[0];
		end
		if(~wclk) begin
//			reg_fifo_rclk <= 1'b0;
//			reg_fifo_rclk_oneshot_end <= 1'b0;
			reg1 <= 1'b0;
		end
	end
	
	always @(negedge clk or posedge rst) begin
		if(rst) begin
			reg2 <= 1'b0;
			reg3 <= 1'b0;
		end
		else begin
			reg2 <= reg1;
			reg3 <= reg2;
		end
//		if(reg_fifo_rclk & ~reg_fifo_rclk_oneshot_end) begin
//			reg_fifo_rclk_q <= 1'b1;
//		end
//		if(reg_fifo_rclk_q) begin
//			reg_fifo_rclk_q <= 1'b0;
//			reg_fifo_rclk_oneshot_end <= 1'b1;
//		end
	end
		
		

//	always@(posedge wclk or posedge rst or negedge clk) begin
//		if(rst) begin
//			reg_fifo_rclk <= 1'b0;
//		end
//		else if(wclk) begin
//			reg_fifo_rclk <= din[0];
//		end
//		else begin
//			if(reg_fifo_rclk == 1'b1) begin
//				
//	end
	
	always@(posedge clk or posedge fifo_rst or posedge rst) begin
		if(fifo_rst) begin
			fullflag_q <= 1'b0;
		end
		else if(rst) begin
			fullflag_q <= 1'b0;
		end
		else begin
			if(fullflag) begin
				fullflag_q <= 1'b1;
			end
		end
	end
			

endmodule
		