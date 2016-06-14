module vXc_add_8(clk,reset,first_row_input,constant,second_row_input,op,result,finish );
	
	parameter NOE = 16;
	parameter NI = 8;
	parameter additional = NI-(NOE%NI); 
	parameter total = NOE+additional ;
	parameter element_width=32;
	integer counter=0 ;
	integer ii=0;
	
	output reg finish ;
	output wire [element_width*NI-1:0] result;
	
	input clk ;
	input wire reset ;
	input wire[element_width*NI-1:0] first_row_input;
	input wire[element_width*NI-1:0] second_row_input;
	input wire [element_width-1:0]constant;
	input op;
	
	
	
	
	
	
	wire [element_width*NI-1:0] mul_result;
	
	wire [31:0] adder_output;
	
	genvar j ;
	generate
	
	for(j=0;j<NI;j=j+1) 
		begin : instantiate_Multiplier
			multiply m (first_row_input[element_width*(NI-j)-1-:element_width],constant, clk, 1, mul_result[element_width*(NI-j)-1-:element_width]);
			adder_subtractor adder (second_row_input[element_width*(NI-j)-1:element_width*(NI-j)-element_width],mul_result[element_width*(NI-j)-1:element_width*(NI-j)-element_width] ,result[element_width*(NI-j)-1:element_width*(NI-j)-element_width],op,clk,1'b1);
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
												if(counter==4)
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
														if(counter==4)
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


