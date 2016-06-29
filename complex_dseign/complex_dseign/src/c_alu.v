

 `define tolerance 32'h283424DC
module complex_Alu (total,clk,reset,reset_vXv1,reset_mXv1,memA_output,Emap_mem_output_row,multiples_output,total_with_additional_A,you_can_read,memories_pre_preprocess,pKold_v2,ppKold_v2,rKold,rrKold,xKold,rKold_prev,rrKold_prev,memoryP_input,memoryPP_input,memoryR_input,memoryRR_input,memoryX_input,mul_add3_finish,outsider_read_now,result_mem_we_4,rkold_read_address,result_mem_we_5,result_mem_counter_5,read_again,start,read_again_2,result_mem_we_6,vXv1_finish,finish_all,I_am_ready);
	
	
	parameter element_width=64;
	parameter memories_address_width=32;	
	
	parameter no_of_elements_on_col_nos = 20 ;	 
	parameter no_of_row_by_vector_modules = 4;	
	parameter no_of_units = no_of_row_by_vector_modules*2;
	parameter no_of_elements_in_p_emap_output = 8;	  
	
	 
	reg [element_width-1:0] bnorm ;
	reg	 only_first_time;
	
	
	input wire clk,reset;
	
	integer display_counter = 0;
	reg display_vxv_finish = 0;
	
 
    input wire [no_of_row_by_vector_modules*element_width*no_of_units-1:0] memA_output;
	input wire [no_of_row_by_vector_modules*no_of_elements_in_p_emap_output*element_width-1:0] Emap_mem_output_row ;
	input wire [32*no_of_row_by_vector_modules-1:0] multiples_output ;	
	input wire [no_of_row_by_vector_modules-1:0] you_can_read;
	input wire [31:0]total_with_additional_A;
	input wire [31:0]total;
	
	output wire memories_pre_preprocess;
	
	input [element_width*no_of_units-1:0] rKold; 
	input [element_width*no_of_units-1:0] rrKold;
	input [element_width*no_of_units-1:0] pKold_v2;
	input [element_width*no_of_units-1:0] ppKold_v2;
	
	input [element_width*no_of_units-1:0] xKold;
	
	
	reg vxv1_first_time = 1;
    input wire reset_vXv1;
	input wire reset_mXv1;	  
	input wire[element_width*no_of_units-1:0] rKold_prev; 
	input wire[element_width*no_of_units-1:0] rrKold_prev;
	
	
	
	
	
	output reg finish_all; 
	output reg start;
      
	
	

    output wire [element_width*no_of_units-1:0]memoryR_input; 
	output wire [element_width*no_of_units-1:0]memoryRR_input;
	
	output wire [element_width*no_of_units-1:0] memoryX_input;	
	
	output wire [element_width*no_of_units-1:0] memoryP_input;
	output wire [element_width*no_of_units-1:0] memoryPP_input;
	
	output wire [no_of_row_by_vector_modules-1:0] I_am_ready;
	
	output wire result_mem_we_4; 
	output wire read_again; 
	output wire result_mem_we_6;
	output wire read_again_2; 
    output wire[31:0] rkold_read_address; 
	output wire result_mem_we_5;
    output wire[31:0] result_mem_counter_5;
	output wire mul_add3_finish;
	output wire vXv1_finish; 
	output wire outsider_read_now;
	
	
	wire [element_width-1:0]vXv1_result;
	wire vxv1_I_am_ready;
	wire [element_width-1:0]vXv2_result;
	
	wire [element_width-1:0]vXv3_result; 
	wire [element_width-1:0]vXv33_result;
	
	wire [element_width*no_of_units-1:0]mXv1_result;
	

    wire[element_width-1:0]div1_result;
	wire[element_width-1:0]div2_result;	
	wire[element_width-1:0]div_tol_result;	
	wire[element_width-1:0]beta;
	
	wire vXv3_finish;
    wire vxv3_I_am_ready;	
	wire vXv33_finish;
	wire vxv33_I_am_ready;
	
	wire vXv2_finish;
	wire div1_finish;  
	wire div2_finish;
	wire div_tol_finish;
	wire mul_add1_finish;
	wire mul_add2_finish;
	
	
	
	wire AP_total_we;
	wire [element_width*no_of_units-1:0] AP_total;  
	wire[31:0]counter;
	wire[31:0] AP_read_address ; 
	wire [31:0] read_address;
	 
	 
	 
	reg [element_width-1:0] rnew;  /* 3'alban hamsa7hom*/
	reg [element_width-1:0] rold;  
	reg rnew_finish_flag;
	reg rold_finish_flag;
	
	reg mul_add3_start;
	reg start_div2;
	reg start_mul_add; 
	reg outsider_read;
	reg outsider_read2;	
	reg flag;
	reg [31:0] AP_counter; 
	
	integer outsider_counter=0;
	integer outsider_counter2=0;
	

	assign read_address=(!mul_add2_finish)? AP_read_address:
	                     (AP_counter)    ? AP_counter:32'b0;             
	
	
	
	
	
	
	
	//vector by vector <rr.r>
	
	
	
	conjugate_complex_vectorXvector_with_control#(.no_of_units(no_of_units),.element_width (element_width ))
	vXv1 (total,clk,reset_vXv1,rrKold,rKold,vXv1_result,vXv1_finish,outsider_read,vxv1_I_am_ready);	///edit outsider
	
	
	
	
	//mat by vector (AP)
	
	
	complex_matrix_by_vector_v3_with_control#(.no_of_row_by_vector_modules(no_of_units/2),.NI(no_of_units),.element_width (element_width ))
	mXv1(clk,reset,reset_mXv1,memA_output,Emap_mem_output_row,mXv1_result,mXv1_finish,outsider_read_now,multiples_output,total_with_additional_A,memories_pre_preprocess,you_can_read,I_am_ready);
	
	
	//vect by vect PP(AP)
	
 
	AP_total#(.no_of_units(no_of_units),.element_width (element_width ),.memories_address_width(memories_address_width))
	AP_total_mem(clk,mXv1_result,counter,read_address,outsider_read_now/*AP_total_we*/,AP_total);

	
	conjugate_complex_vectorXvector_mXv_with_control #(.no_of_units(no_of_units),.element_width (element_width ))
	vXv2(total,clk,!mXv1_finish,ppKold_v2,mXv1_result,vXv2_result,vXv2_finish,AP_total_we,counter,outsider_read_now);
	
	
	
	//calc alpha
	complex_division div1( clk ,vXv2_finish,vXv1_result ,vXv2_result ,div1_result ,div1_finish );
	
	
	
	
	//x=x+p.alpha	
	vXc_mul3_add #(.no_of_units(no_of_units),.element_width (element_width ))
	mul_add1(total,clk,!start_mul_add,pKold_v2,div1_result,xKold,1'b0,mul_add1_finish,result_mem_we_4,memoryX_input,read_again);  
	
	
		
		
		
	//r=r-alpha.Ap  
	vXc_mul3_sub #(.no_of_units(no_of_units),.element_width (element_width ))
	mul_add2(total,clk,!start_mul_add,AP_total,div1_result,rKold_prev,1'b1,mul_add2_finish,AP_read_address,rkold_read_address,result_mem_we_5,result_mem_counter_5,memoryR_input);
	
	
	//rr=rr-alpha*.AP*
	conjugate_conjugate_vXc_mul3_sub #(.no_of_units(no_of_units),.element_width (element_width ))
	mul_add22(total,clk,!start_mul_add,AP_total,div1_result,rrKold_prev,1'b1,mul_add2_finish,AP_read_address,rkold_read_address,result_mem_we_5,result_mem_counter_5,memoryRR_input);
	
	
	
	//||r||2 = <rk+1.rk+1> (the norm yb2a conjugate inner product 3lshan ytl3 rakam real)
	conjugate_complex_vectorXvector_with_control#(.no_of_units(no_of_units),.element_width (element_width ))
	vXv3 (total,clk,!start,rKold,rKold,vXv3_result,vXv3_finish,outsider_read2,vxv3_I_am_ready);
	
	
	//<rk+1.AP>	(el3ady 3shan l mafrod yb2a conjugate of AP)
	complex_vectorXvector_with_control#(.no_of_units(no_of_units),.element_width (element_width ))
	vXv33 (total,clk,!start,AP_total,rKold,vXv33_result,vXv33_finish,outsider_read2,vxv33_I_am_ready); 
	
	// tol=<rk+1.rk+1>/<b.b>
	
	complex_division div_tol (clk ,(start_div2),vXv3_result,bnorm ,div_tol_result ,div_tol_finish);
	
	//Beta= -(<rk+1.AP>/<PP.AP>)
	complex_division div2( clk ,(start_div2),vXv33_result,vXv2_result ,div2_result ,div2_finish );
	 assign beta=div2_result^64'h8000000080000000;
	
	//r+beta.p
	
	
	vXc_mul3_add #(.no_of_units(no_of_units),.element_width (element_width ))
	mul_add3(total,clk,!mul_add3_start,pKold_v2,beta,rKold,1'b0,mul_add3_finish,result_mem_we_6,memoryP_input,read_again_2); 
	
	
	//r+beta*.PP
	conjugate_vXc_mul3_add #(.no_of_units(no_of_units),.element_width (element_width ))
	mul_add33(total,clk,!mul_add3_start,ppKold_v2,beta,rrKold,1'b0,mul_add3_finish,result_mem_we_6,memoryPP_input,read_again_2); 
	
		 
	always @(posedge clk)
		begin
		if(reset)
				only_first_time<=1;
		if(vXv1_finish&&only_first_time)
			begin
				bnorm <= vXv1_result;
				only_first_time<=0;
				
			end
			
			
			
		end
	
	
	
	
	
	
		always @(posedge clk)
			begin 
				
			if(reset||mul_add3_finish)
				begin
				AP_counter<=0;
				//read_address<=0;
				end
			
			
			
			else if(outsider_read2)
				begin
					//read_address<=AP_counter;
					 AP_counter<=AP_counter+1;
				end
				
			end
		
		
	
		always @(posedge clk)
			begin
			if(reset||mul_add3_finish)
				begin
				outsider_read<=0;
				outsider_counter<=0;
				vxv1_first_time <=1;
				end
			
			
			else if(!reset_vXv1&&outsider_counter < total/no_of_units)
				begin
						if(!vxv1_first_time)
							begin
									//@(vxv1_I_am_ready);
									outsider_read<=1;
									outsider_counter<=outsider_counter+1;
									@(posedge clk);
									outsider_read<=0;
							end
						else 
							begin
								vxv1_first_time<=0;
								outsider_read<=1;
								outsider_counter<=outsider_counter+1;
								@(posedge clk);
								outsider_read<=0;
							end
				
			end	 
			
						end
			
		
		
		always@(posedge clk)
		begin
			if(reset||mul_add3_finish)
				start_mul_add<=0;
				
			else if(div1_finish)
	
				start_mul_add<=1;
	
		end		 
		
		
		
		
		always@(posedge clk)
		begin
			if(reset||mul_add3_finish)
				start<=0;
				
			else if(mul_add2_finish)
	
				start<=1;
	
		end
		
		
		
		always @(posedge clk)
			begin
			if(reset||mul_add3_finish)
				begin
				outsider_read2<=0;
				outsider_counter2<=0;
				
				end
			
			
			else if(start&&outsider_counter2 < total/no_of_units)
				begin
					
				
							outsider_read2<=1;
				
							outsider_counter2<=outsider_counter2+1;
				
							@(posedge clk);
				
							outsider_read2<=0;
				
				end
				
			end
			
	
		
		//always@(posedge clk)
//		begin
//			if(!reset&&div2_finish)
//	
//				mul_add3_start<=div2_finish;
//			else
//				mul_add3_start<=0;
//	
//		end	
		reg pip1=1,pip2=1;
		
		always@(posedge clk)
		begin 
			if(reset)
			
				begin
				
				finish_all<=0;
				mul_add3_start=0;
				end  
				else if (mul_add3_finish)
					begin  
					pip1<=0;
					pip2<= pip1;
					mul_add3_start<=pip2;
					end
				
			else if(!reset&&div_tol_result[63:32]<=`tolerance)
				begin
					mul_add3_start<=0; 
					finish_all<=1;
					//mul_add3_start<=div2_finish;
					
				end
			
			else if(!reset&&div_tol_finish)
	
				mul_add3_start<=div_tol_finish;
				
				
			else 
				begin
				pip1<=1;
				pip2<=1;
				end
				
			
			
		end
	
		
		
		
		
	
	//always@(posedge clk)
//		begin 
//			if(reset||mul_add3_finish)
//				begin
//					finish_all<=0;
//					rnew_finish_flag<=0;   
//					rold_finish_flag<=0; 
//					start_div2<=0;
//				end
//			else if(!reset&&!rold_finish_flag&&vXv1_finish)
//			begin
//				rold_finish_flag<=1;     need to be zero lma abda2 iteration gdeda
//				rold<= vXv1_result;
//			end
//			
//			else if(!reset&&!rnew_finish_flag&&vXv3_finish)
//				begin
//					if(vXv3_result<=`tolerance)  tolerance 
//						begin
//						finish_all<=1;	
//						end
//					
//				else
//					begin
//					rnew<=vXv3_result;
//					rnew_finish_flag<=1;   need to be zero lma abda2 iteration gdeda
//					
//					@(posedge clk);
//					start_div2<=1;
//					
//					end
//					
//				end	
//				end	




always@(posedge clk)
		begin 
			if(reset||mul_add3_finish)
				begin
					
					start_div2<=0;
				end

			
			else if(!reset&&vXv3_finish)
				begin
					
					@(posedge clk);
					start_div2<=1;
					
					end
					
				end	
				
				
				
				
				
				
				
		always @(posedge clk)
		begin
		 if(outsider_read_now)
		 begin
		 display_counter <= display_counter +1 ;

		$display("%d :: %h %h %h %h ",display_counter,mXv1_result[8*64-1-:64], 
		mXv1_result[7*64-1-:64],
		mXv1_result[6*64-1-:64],
		mXv1_result[5*64-1-:64]);
			$display("%d :: %h %h %h %h ",display_counter,mXv1_result[4*64-1-:64], 
		mXv1_result[3*64-1-:64],
		mXv1_result[2*64-1-:64],
		mXv1_result[1*64-1-:64]);
		 end
		 else if(display_counter==32'd932)
			display_counter<=0; 
		 end	
				
			 





endmodule
