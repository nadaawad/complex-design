//-----------------------------------------------------------------------------
//
// Title       : \\complex_N_to_2N_demux_
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_N_to_2N_demux.v
// Generated   : Wed Jun 15 18:18:10 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps



  module complex_N_to_2N_demux (in ,sel,out);
	parameter NI=8;
	parameter element_width =64;
	input in;
	wire[element_width*(NI/2)-1:0] in;
	input sel;
	output out;
	reg[2*element_width*(NI/2)-1:0] out;
	
	always @(in or sel)
		begin
			if(!sel)
				out[element_width*(NI/2)-1:0]<=in;
			else
				out[2*element_width*(NI/2)-1:element_width*(NI/2)] <=in;
				
			end
endmodule
