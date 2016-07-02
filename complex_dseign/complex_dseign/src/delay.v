
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
		
		
     input wire clk;
	 input wire[element_width-1:0] in;
      
    
    output reg [element_width-1:0]out;
	
	reg [element_width-1:0] pip1; 
	reg [element_width-1:0] pip2;
	reg [element_width-1:0] pip3;
	
    
	
 // test test test
	
 always @(posedge clk)
	 begin 
       
		pip1<=in;
		pip2<=pip1;
		pip3<=pip2;
		//pip4<=pip3;
		//pip5<=pip4;
		out<=pip3;
		 
	 end
	


endmodule
