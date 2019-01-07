`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2018 01:52:14 AM
// Design Name: 
// Module Name: VGAtb
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

module VGAtb();

	//globals
	logic			 clk = 0;
	logic 		 reset = 1;
	//vga interface
	logic			 hsync;
	logic			 vsync;
	//bram interface
	logic [31:0] bram_addr;
	logic        bram_en;

	VGA #(.CLK_DIV_VAL(4))
	VGA_ip(.clk(clk),
			.reset(reset),
			.hsync(hsync),
			.vsync(vsync),
			.bram_addr(bram_addr),
			.bram_en(bram_en));

	initial 
	begin
		reset = 0;
		#100ns reset = 1;
	end

	always #50ns clk <= ~clk;

endmodule
