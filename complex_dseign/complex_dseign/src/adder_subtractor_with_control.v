
//-----------------------------------------------------------------------------
//
// Title       : adder_subtractor
// Design      : cluster jacoubi
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : adder subtractor.v
// Generated   : Fri Sep 18 15:00:44 2015
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module adder_subtractor_with_control (A, B,result,op,clk,ce,outsider15,controlled_adder_output,start);

input A,B;	
input start;

wire[31:0] A,B;	  

input clk ,op,ce;
output result;	 

input wire outsider15;
output wire [31:0] controlled_adder_output;	
reg [31:0] previous_value;

wire [31:0] result;

fpadd add_sub (A,B,result, op,clk,ce);



assign controlled_adder_output = outsider15?result:previous_value;
always@(posedge clk)
	begin 
		if(outsider15==1)
			previous_value <= result;
		else if (!start )
			previous_value <= 32'b0;		
	end	

endmodule
