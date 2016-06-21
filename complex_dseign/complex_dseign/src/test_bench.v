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
	
	reg [31:0] A,B;
	reg clk,op,ce;
	wire[31:0] result;

	adder_subtractor add (A,B,result,op,clk,ce);
initial
	begin
	clk=0;
	op=0;
	ce=1;
	A=32'h40000000;
	B=32'h3f800000;
	end
	
	
	always 
		#5 clk=~clk;
 
endmodule
