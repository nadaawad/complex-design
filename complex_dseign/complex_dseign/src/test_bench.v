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
reg clk,reset,op;
//reg[64*8-1:0]first_row_input,second_row_input;
reg[63:0]constant;
wire finish;  
//wire[64*8-1:0]result; 
wire[31:0]counter3,counter2,counter5;	
wire result_mem_we;	 
wire[64*8-1:0]vXc_add_8_output;	 
wire[64*8-1:0]first_row_plus_additional,second_row_plus_additional;


memR R(clk, input_data, write_enable,counter2, input_write_address, first_row_plus_additional,finish1);
memP_v2 P(clk, input_data, write_enable,counter5, input_write_address,second_row_plus_additional,finish2);
vXc_mul3_sub c(clk,reset,first_row_plus_additional,constant,second_row_plus_additional,op,finish,counter2,counter5,result_mem_we,counter3,vXc_add_8_output); 


initial
	
	begin
	clk=0;
	reset=1;
	op=1'b1;
	///ce=1;
	//first_row_input=512'h3f8000003f80000040000000400000004040000040400000408000004080000040a0000040a0000040c0000040c0000040e0000040e000004100000041000000;
	//second_row_input=512'h3f8000003f80000040000000400000004040000040400000408000004080000040a0000040a0000040c0000040c0000040e0000040e000004100000041000000;
	constant=64'h4000000040000000;
	#15 reset=0;
	//#50 op=1;
	#1000 $finish();
	end
	
	
	
	
	always 
		#5 clk=~clk;
 
endmodule
