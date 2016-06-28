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
	
	output[63:0]result;
	  assign result=A^63'h0000000080000000;
	
	

endmodule
