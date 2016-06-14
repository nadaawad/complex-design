//-----------------------------------------------------------------------------
//
// Title       : delay
// Design      : 8_input_design_beta
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : delay.v
// Generated   : Fri Jun 10 18:44:12 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {delay}}

	  
	module delay (clk,in,out); 
		
		parameter element_width=64; 
		
		
     input clk;
	 input in;
     wire clk;
     wire[element_width-1:0]in;
    output out;
    reg [element_width-1:0]out;
	
 // test test test
	
 always @(in)
   	begin 
       
		@(posedge clk);	
		@(posedge clk);	
		
	     out<=in; 
 
	end
	


endmodule
