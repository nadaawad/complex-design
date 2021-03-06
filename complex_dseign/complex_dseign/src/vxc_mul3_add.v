module vXc_mul3_add(clk,reset,first_row_fixed,constant,second_row_fixed,op,finish,result_mem_we,vXc_add_8_output,read_again); 

    parameter number_of_equations_per_cluster=19;
	parameter element_width_modified=34;
	parameter element_width=64;
	parameter no_of_units=8;
	parameter count=number_of_equations_per_cluster/no_of_units;
	parameter additional = no_of_units-(number_of_equations_per_cluster%no_of_units); 
	parameter total = number_of_equations_per_cluster+additional ;
	parameter number_of_clusters=1;
	
	
	
	integer counter2=0;
	integer counter3=0;
	integer counter5=0;
	integer i=0;
	
	
	input wire [element_width-1:0] constant;
	input wire clk;
	input wire reset;		
	input wire op;
	input wire [element_width*(no_of_units)-1:0] first_row_fixed;
	input wire [element_width*(no_of_units)-1:0] second_row_fixed;
	
	
	
	
	output wire [element_width*no_of_units-1:0]vXc_add_8_output;
	
	output reg finish;	
	output reg read_again;
	output reg  result_mem_we;		
	
	
	
	reg [no_of_units*element_width-1:0] first_row_input;
	reg [no_of_units*element_width-1:0] second_row_input;
	
	
	wire finish_out;
	
	
	
	
	
	complex_vXc_add_8_delay #(.NI(no_of_units)) vXv(clk,reset,first_row_input,constant,second_row_input,op, vXc_add_8_output,finish_out );

	initial
		begin  
			counter3<=0; 
			
			result_mem_we<=0; 
			read_again <=0;
			end
		
		
				
				
				always @ (posedge clk)
					begin
						if(reset)
							counter2<=0;
						else if(!reset)
							begin
								if(counter2 <total/no_of_units)
									begin  
	
										if(counter2==0)	begin
											first_row_input <= first_row_fixed;
											read_again<=1;
											end
										else
											begin 
										read_again<=0;
										@(posedge clk);	
										@(posedge clk);
										first_row_input <= first_row_fixed;
										read_again<=1;
										
										end
										counter2 <=counter2+1;
									end	
									else begin
										read_again<=0;
										end
								end
							end
							
							always @ (posedge clk)
								begin
									if(reset)
										counter5<=0;
									if(!reset)
										begin
											if(counter5 <total/no_of_units)
												begin  
													if(counter5==0)
														begin
															
															second_row_input <= second_row_fixed;
														end
													else
														begin
															 @(posedge clk);
															@(posedge clk);
															second_row_input <= second_row_fixed;
														end
														counter5 <=counter5+1;
													end
													end
												end
												
												always@(posedge clk)
													begin
														if(reset)
															begin
															counter3<=0;
															finish<=0;
															end
														if(finish_out)
															begin	
																
																if(counter3<total/no_of_units)
																	begin 	 
																		
																		@(posedge clk);
																		result_mem_we<=1;
																		@(posedge clk);	
																		result_mem_we<=0;
																		
																		
												
																		counter3<=counter3+1;
																	end
																else 
																	finish<=1;
																end
																end
										
									 
							endmodule