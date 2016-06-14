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


module complex_conjugate (A,clk,result); 
	
	input wire[63:0] A;
	input wire clk;
	
	output[63:0]result;
	
	
	wire[31:0]result_imj;
	
	assign result={A[63:32],result_imj};
	
	adder_subtractor sub (32'h0,A[31:0],result_imj,1'b1,clk,1'b1);

endmodule
