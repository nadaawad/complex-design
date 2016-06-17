//-----------------------------------------------------------------------------
//
// Title       : test_bench2
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : test_bench2.v
// Generated   : Wed Jun 15 14:33:40 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module test_bench2 ();

	 // parameter ew=64 ;
//     reg[ew*8-1:0] first_row_input,second_row_input;
//	 reg clk,reset,outsider_read_now;
//	
//	 wire [ew:0]dot_product_output;	
//	 wire finish;
	 
	//complex_eight_Dot_Product_Multiply_with_control m(clk,reset,first_row_input,second_row_input,dot_product_output,finish,outsider_read_now );
	
	//reg[191:0]a,p;
//	reg	number_of_multiples,clk,start_row_by_vector,reset;
//	wire [63:0] result;
//	wire decoder_read_now;
	
	
	
//	complex_row_by_vector_with_control m (clk,a,p,result,give_us_all,number_of_multiples,start_row_by_vector,decoder_read_now,reset);

reg clk,reset,start;
reg[447:0] mat;
reg[191:0] vector;
wire[511:0] out;
wire finish;
wire outsider_read_now;

   complex_matrix_by_vector_v3_with_control m (clk,reset,start,mat,vector,out,finish,outsider_read_now);  
	initial
	
	begin
	clk=0;
	reset=1; 
	start=0;
	//number_of_multiples<=1;
//	a=192'h3f8000000000000040000000000000004040000000000000;
//	p=192'h3f8000000000000040000000000000004040000000000000;
	//outsider_read_now=0;
	
     //first_row_input=512'h3f800000000000003f80000000000000400000000000000040000000000000004040000000000000404000000000000040800000000000004080000000000000;//40a0000040a0000040c0000040c0000040e0000040e000004100000041000000;
	//second_row_input=512'h3f800000000000003f80000000000000400000000000000040000000000000004040000000000000404000000000000040800000000000004080000000000000;//40a0000040a0000040c0000040c0000040e0000040e000004100000041000000;
	
	mat=448'h3f800000000000003f800000000000003f800000000000003f800000000000003f800000000000003f800000000000003f80000000000000;
	vector=192'h3f800000000000003f800000000000003f80000000000000;
	
	#15 reset=0;
	start=1;
	//start_row_by_vector<=1;
	//outsider_read_now=1;
	#1000 $finish();
	end
	
	
	
	
	always 
		#5 clk=~clk;
endmodule
