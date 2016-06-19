//-----------------------------------------------------------------------------
//
// Title       : complex_adder_subtractor_with_control
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_adder_subtractor_with_control.v
// Generated   : Wed Jun 15 18:46:34 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module complex_adder_subtractor_with_control (A,B,result,op,clk,ce,outsider15,controlled_adder_output,start);

	input wire[63:0] A,B;
	input wire clk,op,ce; 
	input start;
	
	output wire[63:0] result;
//	
//	wire[31:0] A_real,A_imj,B_real,B_imj;
//	wire[31:0]result_real,result_imj;  
//	
	input wire outsider15;

	output wire [63:0] controlled_adder_output;	

	reg [63:0] previous_value;

	
	
	//assign A_real=A[63:32];
//	assign A_imj=A[31:0];
//	assign B_real=B[63:32];
//	assign B_imj=B[31:0];
//	assign result={result_real,result_imj};
//	
//	adder_subtractor real_part(A_real,B_real,result_real,op,clk,ce);
//	adder_subtractor imj_part(A_imj,B_imj,result_imj,op,clk,ce); 


   complex_adder_subtractor CA (A,B,result,op,clk,ce);
	
	
	assign controlled_adder_output = outsider15?result:previous_value;
    
	always@(posedge clk)
	
		begin 
		if(outsider15==1)
			previous_value <= result;
		else if(!start)	
			previous_value<=64'b0;
	end	


endmodule
