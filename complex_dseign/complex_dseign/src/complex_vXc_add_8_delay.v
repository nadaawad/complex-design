//-----------------------------------------------------------------------------
//
// Title       : complex_vXc_add_8_delay
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_vXc_add_8_delay.v
// Generated   : Wed Jun 15 00:26:08 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module complex_vXc_add_8_delay(clk,reset ,first_row_input,constant,second_row_input,op, result,finish );
parameter NOE = 19;
	parameter NI = 8;
	parameter additional = NI-(NOE%NI); 
	parameter total = NOE+additional ;
	parameter element_width=64;
	integer counter ;
	integer ii=0;
	
	output reg finish ;
	
	input wire reset ;
	input wire[element_width*NI-1:0] first_row_input;
	input wire[element_width*NI-1:0] second_row_input;
	input wire [element_width-1:0]constant;
	input op;
	
	reg save = 0;
	reg adder_tree_start;
	
	input clk ;
	reg[element_width*NI-1:0] inputs_by_inputs;
	wire [element_width*NI-1:0] mul_result;
	output wire [element_width*NI-1:0] result;
	wire [element_width-1:0] adder_input[0:NI-1];
	
	genvar j ;
	generate
	
	for(j=0;j<NI;j=j+1) 
		begin : instantiate_Multiplier
			complex_multiply m (first_row_input[element_width*(NI-j)-1-:element_width],constant, clk, 1, mul_result[element_width*(NI-j)-1-:element_width]);
			//complex_multiply m2 (second_row_input[element_width*(NI-j)-1:element_width*(NI-j)-element_width],64'h3f80000000000000,clk,1,adder_input[j]);
			delay d(clk,second_row_input[element_width*(NI-j)-1:element_width*(NI-j)-element_width],adder_input[j]);
			complex_adder_subtractor adder(adder_input[j],mul_result[element_width*(NI-j)-1:element_width*(NI-j)-element_width] ,result[element_width*(NI-j)-1:element_width*(NI-j)-element_width],op,clk,1'b1);
		end	
		endgenerate

		
		
						always@(posedge clk)
							begin
								if(reset)
									begin
										finish<=0;
										counter<=0;
										end
								
								else if(!reset)
									begin
										if(op==0)
											begin
												if(counter==8)
													begin
														finish<=1;
														counter<=0;
													end
												else
													begin
														counter<=counter+1;
													end
												end
												
												else if(op==1)
													begin
														if(counter==8)
															begin
																finish<=1;
																counter<=0;
															end
														else
															begin
																counter<=counter+1;
																
															end
														end
													end
													end	 


endmodule
