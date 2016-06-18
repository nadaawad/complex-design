//-----------------------------------------------------------------------------
//
// Title       : complex_multiply
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_multiply.v
// Generated   : Tue Jun 14 14:25:05 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module complex_multiply (A,B,clk,ce,result);   
	
	
	input wire [63:0] A,B;
	input wire clk,ce;
	
	output wire[63:0] result;
	
	wire[31:0] A_real,A_imj,B_real,B_imj;
	wire[31:0]result_real,result_imj;
	
	wire[31:0] r1Xr2,imj1ximj2,r1ximj2,r2ximj1;	
	
	reg [31:0] pip1,pip2; 
	
	
	assign A_real=A[63:32];
	assign A_imj=A[31:0];
	assign B_real=B[63:32];
	assign B_imj=B[31:0];
	assign result=(r1ximj2[31]==r2ximj1[31])?{result_real,pip2}:{result_real,result_imj};	   
	
	multiply m1(A_real,B_real,clk,ce,r1Xr2);
	multiply m2(A_imj,B_imj, clk, ce,imj1ximj2);
	multiply m3(A_real,B_imj, clk, ce, r1ximj2);
	multiply m4(A_imj, B_real, clk, ce,r2ximj1);
	
	adder_subtractor sub (r1Xr2,imj1ximj2,result_real,1'b1,clk,ce); 
	adder_subtractor add (r1ximj2,r2ximj1,result_imj,1'b0,clk,ce);	
	
	always @(posedge clk)
		begin
			pip1<=result_imj;	 // elmafrod a7ot condition hena law l most siginifigant btA3 1 r1ximj2,r2ximj1 zay ba3d yd5ol hena bs
			pip2<=pip1;
			
		end


endmodule
