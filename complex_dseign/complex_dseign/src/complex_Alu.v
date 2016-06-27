//-----------------------------------------------------------------------------
//
// Title       : complex_Alu
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_Alu.v
// Generated   : Thu Jun 16 17:49:30 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

 `define tolerance 32'h283424DC
module complex_Alu (clk,reset,reset_vXv1,reset_mXv1,matA,pKold,pKold_v2,ppKold_v2,rKold,rrKold,xKold,rKold_prev,rrKold_prev,memoryP_input,memoryPP_input,memoryR_input,memoryRR_input,memoryX_input,mul_add3_finish,outsider_read_now,result_mem_we_4,rkold_read_address,result_mem_we_5,result_mem_counter_5,read_again,start,read_again_2,result_mem_we_6,vXv1_finish,finish_all);
	
	parameter number_of_equations_per_cluster=10;
	parameter element_width_modified=34;
	parameter element_width=64;
	parameter no_of_units= 8;
	parameter number_of_clusters=1;
	parameter additional = no_of_units-(number_of_equations_per_cluster%no_of_units); 
	parameter total = number_of_equations_per_cluster+additional ; 
	parameter bnorm =  64'h388288bb00000000;
	
	
	input wire clk,reset;
	
 
    input [element_width*(3* number_of_equations_per_cluster-2*2+2)-1:0] matA; 
	input [element_width*number_of_equations_per_cluster-1:0] pKold;
	input [element_width*no_of_units-1:0] rKold; 
	input [element_width*no_of_units-1:0] rrKold;
	input [element_width*no_of_units-1:0] pKold_v2;
	input [element_width*no_of_units-1:0] ppKold_v2;
	
	input [element_width*no_of_units-1:0] xKold;
	
	
	
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
	wire [element_width-1:0]vXv2_result;
	wire [element_width-1:0]vXv3_result; 
	wire [element_width-1:0]vXv33_result;
	wire [element_width*no_of_units-1:0]mXv1_result;
	

    wire[element_width-1:0]div1_result;
	wire[element_width-1:0]div2_result;	
	wire[element_width-1:0]div_tol_result;	
	wire[element_width-1:0]beta;
	
	wire vXv3_finish; 
	wire vXv33_finish;
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
	 
	 
	 
	reg [element_width-1:0] rnew;
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
	
	
	
	
	
	
	
	//vector by vector (r*r)
	
	
	
	conjugate_complex_vectorXvector#(.no_of_units(no_of_units),.number_of_clusters(number_of_clusters),.number_of_equations_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	vXv1 (clk,reset_vXv1,rrKold,rKold,vXv1_result,vXv1_finish,outsider_read);	///edit outsider
	
	
	
	
	//mat by vector (A*p)
	
	
	complex_matrix_by_vector_v3_with_control #(.no_of_units(no_of_units/2),.NI(no_of_units),.number_of_clusters(number_of_clusters),.no_of_eqn_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	mXv1(clk,reset,reset_mXv1,matA,pKold,mXv1_result,mXv1_finish,outsider_read_now);
	
	
	//vect by vect p*(A*p)
	
 
	AP_total#(.no_of_units(no_of_units),.number_of_clusters(number_of_clusters),.number_of_equations_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	AP_total_mem(clk,mXv1_result,counter,read_address,outsider_read_now/*AP_total_we*/,AP_total);

	
	complex_vectorXvector_mXv_with_control #(.no_of_units(no_of_units),.number_of_clusters(number_of_clusters),.number_of_equations_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	vXv2(clk,!mXv1_finish,ppKold_v2,mXv1_result,vXv2_result,vXv2_finish,AP_total_we,counter,outsider_read_now);
	
	
	
	//calc alpha
	complex_division div1( clk ,vXv2_finish,vXv1_result ,vXv2_result ,div1_result ,div1_finish );
	
	
	
	
	//x+p*alpha	
	vXc_mul3_add #(.no_of_units(no_of_units),.number_of_clusters(number_of_clusters),.number_of_equations_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	mul_add1(clk,!start_mul_add,pKold_v2,div1_result,xKold,1'b0,mul_add1_finish,result_mem_we_4,memoryX_input,read_again);  
	
	
		
		
		
		//r-alpha*A*p  
	vXc_mul3_sub #(.no_of_units(no_of_units),.number_of_clusters(number_of_clusters),.number_of_equations_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	mul_add2(clk,!start_mul_add,AP_total,div1_result,rKold_prev,1'b1,mul_add2_finish,AP_read_address,rkold_read_address,result_mem_we_5,result_mem_counter_5,memoryR_input);
	
	
	
	vXc_mul3_sub #(.no_of_units(no_of_units),.number_of_clusters(number_of_clusters),.number_of_equations_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	mul_add22(clk,!start_mul_add,AP_total,div1_result,rrKold_prev,1'b1,mul_add2_finish,AP_read_address,rkold_read_address,result_mem_we_5,result_mem_counter_5,memoryRR_input);
	
	
	//<rk+1.AP>	, third stage 
	
	complex_vectorXvector#(.no_of_units(no_of_units),.number_of_clusters(number_of_clusters),.number_of_equations_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	vXv3 (clk,!start,rKold,rKold,vXv3_result,vXv3_finish,outsider_read2);
	
	complex_vectorXvector#(.no_of_units(no_of_units),.number_of_clusters(number_of_clusters),.number_of_equations_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	vXv33 (clk,!start,AP_total,rKold,vXv33_result,vXv33_finish,outsider_read2); 
	
	complex_division div_tol (clk ,(start_div2),vXv3_result,bnorm ,div_tol_result ,div_tol_finish);
	
	//Beta
	complex_division div2( clk ,(start_div2),vXv3_result,vXv2_result ,div2_result ,div2_finish );
	 assign beta=div2_result^64'h10000000;
	
	//r+beta.p
	//r+beta*.PP
	
	vXc_mul3_add #(.no_of_units(no_of_units),.number_of_clusters(number_of_clusters),.number_of_equations_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	mul_add3(clk,!mul_add3_start,pKold_v2,beta,rKold,1'b0,mul_add3_finish,result_mem_we_6,memoryP_input,read_again_2); //module da m7tag tzbeet l finish
	
	conjugate_vXc_mul3_add #(.no_of_units(no_of_units),.number_of_clusters(number_of_clusters),.number_of_equations_per_cluster(number_of_equations_per_cluster),.element_width (element_width ))
	mul_add33(clk,!mul_add3_start,ppKold_v2,beta,rrKold,1'b0,mul_add3_finish,result_mem_we_6,memoryPP_input,read_again_2); //module da m7tag tzbeet l finish
	
		 
		
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
				end
			
			
			else if(!reset_vXv1&&outsider_counter < total/no_of_units)
				begin
				outsider_read<=1;
				outsider_counter<=outsider_counter+1;
				@(posedge clk);
				outsider_read<=0;
				
				
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
		
		
		always@(posedge clk)
		begin 
			if(reset)
				mul_add3_start<=0; 
			
			else if(!reset&&div_tol_result<=`tolerance)
				begin
					mul_add3_start<=0; 
					finish_all<=1;
					//mul_add3_start<=div2_finish;
					
				end
			
			else if(!reset&&div_tol_finish)
	
				mul_add3_start<=div_tol_finish;
			
			
			else
				mul_add3_start<=0;
	
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
			 





endmodule
