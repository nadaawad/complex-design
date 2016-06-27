
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


module adder_subtractor (A, B,result,op,clk,ce);

input A,B;

wire[31:0] A,B;	 



input clk ,op,ce;
output result;

wire [31:0] result;

fpadd add_sub(A,B,result,op,clk,ce);

endmodule
