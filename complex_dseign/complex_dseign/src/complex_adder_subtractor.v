//-----------------------------------------------------------------------------
//
// Title       : complex_adder_subtractor
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_adder_subtractor.v
// Generated   : Tue Jun 14 13:33:52 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module complex_adder_subtractor (A,B,result,op,clk,ce);

	input wire[63:0] A,B;
	input wire clk,op,ce;
	
	output wire[63:0] result;
	
	wire[31:0] A_real,A_imj,B_real,B_imj;
	wire[31:0]result_real,result_imj; 
	
	reg[63:0] pip1;
	reg[63:0] pip2;
	
	
	assign A_real=A[63:32];
	assign A_imj=A[31:0];
	assign B_real=B[63:32];
	assign B_imj=B[31:0];
	assign result=(op==1||(A_real[31]==B_real[31]&&A_imj[31]==B_imj[31])||(A_real[31]!=B_real[31]&&A_imj[31]!=B_imj[31]))?{result_real,result_imj}:
	(A_real[31]==B_real[31]&&A_imj[31]!=B_imj[31])?{pip2,result_imj}:{result_real,pip2};
	
	adder_subtractor real_part(A_real,B_real,result_real,op,clk,ce);
	adder_subtractor imj_part(A_imj,B_imj,result_imj,op,clk,ce); 
	
	always @(posedge clk)
		begin
		if(A_real[31]==B_real[31]&&A_imj[31]!=B_imj[31])
			begin
			pip1<=result_real;
			pip2<=pip1;
			end	
		else if(A_real[31]!=B_real[31]&&A_imj[31]==B_imj[31])
			begin
			pip1<=result_imj;
			pip2<=pip1;	
			end
		end
	

endmodule
