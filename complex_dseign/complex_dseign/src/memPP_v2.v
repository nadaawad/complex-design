//-----------------------------------------------------------------------------
//
// Title       : \\_memPP_v2
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : memPP_v2.v
// Generated   : Sun Jun 19 17:25:36 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module memPP_v2 (clk, input_data, write_enable, input_read_address, input_write_address, memory_output,finish);
	
	parameter element_width = 64;
	parameter memories_address_width=20; 
	parameter no_of_units = 8 ;
	
	input wire clk;
	input wire write_enable;
	input wire [no_of_units * element_width - 1 : 0] input_data;
	input wire [memories_address_width - 1 : 0] input_write_address;
	input wire [memories_address_width - 1 : 0] input_read_address;
	
	output reg finish;
	output wire [no_of_units * element_width - 1 : 0] memory_output;
	
	
	reg [no_of_units * element_width - 1 : 0] mem [0 : 1000];
	// pragma attribute mem ram_block 1
	
	assign memory_output=mem[input_read_address];
	
	initial 
		begin
			$readmemh("pp_v2.txt", mem);
			//$readmemh("p_test.txt", mem);
			finish<=0;
		end
	
	always @(posedge clk) 
		begin
			if( write_enable == 1'b1 ) 
				begin
					mem[input_write_address] <= input_data; 
				end
			end
			
	
endmodule
