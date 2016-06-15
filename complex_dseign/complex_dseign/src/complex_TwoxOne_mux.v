//-----------------------------------------------------------------------------
//
// Title       : complex_TwoxOne_mux
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_TwoxOne_mux.v
// Generated   : Wed Jun 15 18:20:15 2016
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
//{module {complex_TwoxOne_mux}}
module complex_TwoxOne_mux (mux_zero,mux_one,mux_output,mux_sel);

input wire [63:0] mux_zero;
input wire [63:0] mux_one;
input wire mux_sel;
output wire [63:0] mux_output;

assign mux_output = (mux_sel)?mux_one:mux_zero;

endmodule
