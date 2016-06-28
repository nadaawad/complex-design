
module main_alu(total,clk,reset,reset_vXv1,reset_mXv1,memA_output,Emap_mem_output_row,multiples_output,total_with_additional_A,you_can_read,memories_pre_preprocess,pKold_v2,memoryPP_output,memoryR_output,memoryRR_output,memoryR_read_address,memoryX_output,memoryP_input,memoryPP_input,memoryR_input,memoryRR_input,memoryX_input,finish,outsider_read_now,result_mem_we_4,memoryRprev_we,result_mem_we_5,result_mem_counter_5,read_again,start,read_again_2,result_mem_we_6,vXv1_finish ,finish_all,I_am_ready
	);

    parameter element_width = 64;
	parameter memories_address_width=32;	
	
	parameter no_of_elements_on_col_nos = 20 ;	 
	parameter no_of_row_by_vector_modules = 4;	
	parameter no_of_units = no_of_row_by_vector_modules*2;
	parameter no_of_elements_in_p_emap_output = 8;	  
	
	input wire clk;
    input wire reset;
	
    input wire reset_vXv1;
    input wire reset_mXv1; 
    
	input wire [element_width * no_of_units - 1 : 0] pKold_v2;	 
	input wire [element_width * no_of_units - 1 : 0] memoryPP_output;
    input wire [element_width * no_of_units - 1 : 0]memoryR_output;
	input wire [element_width * no_of_units - 1 : 0]memoryRR_output;
	input wire [memories_address_width-1:0]memoryR_read_address;
    input wire [element_width * no_of_units - 1 : 0] memoryX_output;
	input wire memoryRprev_we;
	input wire [31:0] total;
	
	
	output wire [no_of_units * element_width - 1 : 0]memoryP_input;
	output wire [no_of_units * element_width - 1 : 0]memoryPP_input;
    output wire [no_of_units * element_width - 1 : 0]memoryR_input;	 
	output wire [no_of_units * element_width - 1 : 0]memoryRR_input;
    output wire [no_of_units * element_width - 1 : 0]memoryX_input;
    output wire finish;
	output wire outsider_read_now ;
      
	
	
	output wire result_mem_we_4 ; 
	output wire read_again;
	
	output wire result_mem_we_5;
	output wire[31:0] result_mem_counter_5;
	
	
	output wire result_mem_we_6;
	output wire read_again_2;
	
	output wire start;	 
	output wire vXv1_finish; 
	output wire finish_all;
	
	
	
    
    
    wire [element_width*no_of_units-1:0] rKold_prev;
	 wire [element_width*no_of_units-1:0] rrKold_prev;
   
    wire[31:0]rkold_read_address;
	output wire [no_of_row_by_vector_modules-1:0] I_am_ready;
	
	
	input wire [no_of_row_by_vector_modules*element_width*no_of_units-1:0] memA_output;
	input wire [no_of_row_by_vector_modules*no_of_elements_in_p_emap_output*element_width-1:0] Emap_mem_output_row ;
	input wire [32*no_of_row_by_vector_modules-1:0] multiples_output ;	
	input wire [no_of_row_by_vector_modules-1:0] you_can_read;
	input wire [31:0]total_with_additional_A;
	
	output wire memories_pre_preprocess;
	
	
	//alu internal memories

    rKold_prev #(.no_of_units(no_of_units),.element_width (element_width ),.memories_address_width(memories_address_width)) 
	rk_prev(clk,memoryR_output,memoryR_read_address,rkold_read_address ,memoryRprev_we, rKold_prev);
   
	 rKold_prev #(.no_of_units(no_of_units),.element_width (element_width ),.memories_address_width(memories_address_width)) 
	rrk_prev(clk,memoryRR_output,memoryR_read_address,rkold_read_address ,memoryRprev_we, rrKold_prev);
        
	
	
	complex_Alu#(.element_width(element_width),.memories_address_width(memories_address_width),.no_of_elements_on_col_nos(no_of_elements_on_col_nos),.no_of_units(no_of_units),.no_of_elements_in_p_emap_output(no_of_elements_in_p_emap_output),.no_of_row_by_vector_modules(no_of_row_by_vector_modules))
	alu(total,clk,reset,reset_vXv1,reset_mXv1,memA_output,Emap_mem_output_row,multiples_output,total_with_additional_A,you_can_read,memories_pre_preprocess,pKold_v2,memoryPP_output,memoryR_output,memoryRR_output,memoryX_output,rKold_prev,rrKold_prev,memoryP_input,memoryPP_input,memoryR_input,memoryRR_input,memoryX_input,finish,outsider_read_now,result_mem_we_4,rkold_read_address,result_mem_we_5,result_mem_counter_5,read_again,start,read_again_2,result_mem_we_6,vXv1_finish,finish_all,I_am_ready);
	
endmodule