// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"
// CREATED		"Sun Jan 21 13:56:06 2018"

module spi_block(
	clk,
	rst,
	ss,
	mosi,
	sclk,
	wr,
	data_in,
	data_out,
	full_alarm_led,
	empty_alarm_led
);


input wire	clk;
input wire	rst;
input wire	ss;
input wire	mosi;
input wire	sclk;
input wire	wr;
input wire	[31:0] data_in;
output wire	[31:0] data_out;
output full_alarm_led;
output empty_alarm_led;

wire	[31:0] dout;
wire	nrst;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire    fifo_rst_from_fifo_controller;




assign	nrst =  ~rst & ~fifo_rst_from_fifo_controller;
assign  dout[29] = full_alarm_led;
assign  empty_alarm_led = dout[31];


spi_slave3	b2v_inst1(
	.clk(clk),
	.rst(rst),
	.ss(ss),
	.mosi(mosi),
	.sck(sclk),
//	.data_ready(SYNTHESIZED_WIRE_0),
	.done(SYNTHESIZED_WIRE_0),
	.dout(dout[15:8]));


fifo_controller	b2v_inst7(
	.clk(clk),
	.wclk(wr),
	.rst(rst),
	.din(data_in),
	.fifo_rst(fifo_rst_from_fifo_controller),
	.fifo_rclk(SYNTHESIZED_WIRE_1),
	.fullflag(dout[30]),
	.fullflag_alarm(full_alarm_led));


sfifo	b2v_U0(
	.CLK(clk),
	.nRST(nrst),
	.WR(SYNTHESIZED_WIRE_0),
	.RD(SYNTHESIZED_WIRE_1),
	.D(dout[15:8]),
	.FULL(dout[30]),
	.EMPTY(dout[31]),
	.Q(dout[7:0]));
	defparam	b2v_U0.numwords = 1024;
	defparam	b2v_U0.width = 8;
	defparam	b2v_U0.widthad = 10;

assign	data_out = dout;

endmodule
