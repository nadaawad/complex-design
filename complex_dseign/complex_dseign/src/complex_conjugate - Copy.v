//-----------------------------------------------------------------------------
//
// Title       : complex_conjugate
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_conjugate.v
// Generated   : Tue Jun 14 15:07:39 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module complex_conjugate (A,result); 
	
	input wire[63:0] A;
	//input wire clk;
	
	output[63:0]result;
	  assign result=A^63'h0000000080000000;
	
	//wire[31:0]result_imj;
	
	//reg[31:0] pip1,pip2,pip3,pip4;
	
	//assign result={pip4,result_imj};
	
	//adder_subtractor sub (32'h0,A[31:0],result_imj,1'b1,clk,1'b1);
	
	
	/*always @(posedge clk)
		begin
		pip1<=A[63:32];
		pip2<=pip1;
		pip3<=pip2;
		pip4<=pip3;
		
		end*/

endmodule
