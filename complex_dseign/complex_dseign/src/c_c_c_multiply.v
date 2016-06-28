//-----------------------------------------------------------------------------
//
// Title       : conjugate_conjugate_complex_multiply
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : conjugate_conjugate_complex_multiply.v
// Generated   : Sun Jun 19 16:53:52 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module conjugate_conjugate_complex_multiply (A,B,clk,ce,result);   
	
	
	input wire [63:0] A,B;
	input wire clk,ce;
	
	output wire[63:0] result;
	
	wire[31:0] A_real,A_imj,B_real,B_imj;
	wire[31:0]result_real,result_imj;
	
	wire[31:0] r1Xr2,imj1ximj2,r1ximj2,r2ximj1;	
	
	
	
	wire[63:0]A_conj,B_conj;
	complex_conjugate cA (A,A_conj);
	complex_conjugate cB (B,B_conj);
	
	assign A_real=A_conj[63:32];
	assign A_imj=A_conj[31:0];
	assign B_real=B_conj[63:32];
	assign B_imj=B_conj[31:0];
	assign result={result_real,result_imj};	   
	
	multiply m1(A_real,B_real,clk,ce,r1Xr2);
	multiply m2(A_imj,B_imj, clk, ce,imj1ximj2);
	multiply m3(A_real,B_imj, clk, ce, r1ximj2);
	multiply m4(A_imj, B_real, clk, ce,r2ximj1);
	
	adder_subtractor sub (r1Xr2,imj1ximj2,result_real,1'b1,clk,ce); 
	adder_subtractor add (r1ximj2,r2ximj1,result_imj,1'b0,clk,ce);	
	
	


endmodule
