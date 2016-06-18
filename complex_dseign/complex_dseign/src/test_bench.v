//-----------------------------------------------------------------------------
//
// Title       : test_bench
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : test_bench.v
// Generated   : Tue Jun 14 13:57:47 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module test_bench ();
reg clk ,start,ce;
reg[63:0]A,B;
wire[63:0] result;
wire finish_flag;
	
	
complex_division d(clk,start,A,B,result,finish_flag);
//complex_multiply m(A,B,clk,ce,result); 
initial
	begin
	clk=0;
	start=1;
	ce=1;
	A=63'h4080000040800000;
	B=63'h3f8000003f800000;
	end
	
	
	always 
		#5 clk=~clk;
 
endmodule
