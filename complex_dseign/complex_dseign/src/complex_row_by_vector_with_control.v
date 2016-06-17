//-----------------------------------------------------------------------------
//
// Title       : complex_row_by_vector_with_control
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_row_by_vector_with_control.v
// Generated   : Thu Jun 16 14:09:21 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module complex_row_by_vector_with_control (clk,a,p,result,give_us_all,number_of_multiples,start_row_by_vector,decoder_read_now,reset);
	


input clk;
wire clk;
input a,p;
wire[191:0] a,p;	
output result;
wire [63:0] result;	  


input wire  number_of_multiples;
integer number_of_multiples_counter = 0;
reg counter_for_deasserting;

wire[63:0] m1_result,m2_result,m3_result,adder_1st_result,adder_2nd_result;	 

	
output reg give_us_all;  // this rises to one when ALL multiples have been calculated
// for example if we have 8 multipliers and the row has 24 entries , this rises after all the three multiples are done
output reg decoder_read_now;		
input wire start_row_by_vector;
reg pipeline0=0;
reg pipeline1=0;
reg pipeline2=0;
reg pipeline3=0;
reg pipeline4=0;
reg pipeline5=0;
reg pipeline6=0;
reg pipeline7=0;
reg pipeline8=0;
input wire reset;
integer i = 0;
parameter total=3; 
parameter no_of_units=4;



	  

complex_multiply m1(a[191:128], p[191:128], clk, 1'b1,m1_result);
complex_multiply m2 (a[127:64], p[127:64], clk, 1'b1, m2_result);
complex_multiply m3 (a[63:0], p[63:0], clk, 1'b1, m3_result); 
complex_adder_subtractor adder1 (m1_result,m2_result,adder_1st_result,1'b0,clk,1'b1); 
complex_adder_subtractor adder2 (m3_result,64'b0,adder_2nd_result,1'b0,clk,1'b1);
complex_adder_subtractor adder3 (adder_1st_result,adder_2nd_result,result,1'b0,clk,1'b1);

// note if you don't need to accelerate the special case where #of multiples =1 , you don't need the reset signal
	// nor the total and no_of_units parameters. 
	
// note , both the special and slower case seem to work well now , although I am more relieved with the non-special case
	// also for the non special case , decoder_read_now<=pipeline5 will work right , but won't work for the special case
// overall it seems logical , and i didn't do any fabraka , i guess .		

always @(posedge clk) 
	begin 
	if (reset) begin  i<=0 ;end
	else 
		begin  
			if(  i >=(total/no_of_units ))  // a failed trial for the case of number of multiples ==1 
				// need to get back to this if needed
				begin  give_us_all <= 0; end
			else if(~ counter_for_deasserting && (number_of_multiples - number_of_multiples_counter -1 > 0))
				begin 
					give_us_all <=0;    
					number_of_multiples_counter <= number_of_multiples_counter +1 ;
				end   
			else if( ~ counter_for_deasserting && (number_of_multiples - number_of_multiples_counter -1 == 0))
				begin 
					counter_for_deasserting <=1; 
					number_of_multiples_counter <=0;   

					give_us_all <=1;
				end	
			else 
				begin
				counter_for_deasserting <=0; 
				if(number_of_multiples >1 /*||1*/ ) // to accelerate the special case of number of multiples = 1 
					// which will most probably be the one we use . I will disable it for now for debugging reasons.
				begin give_us_all <=0; end 
				end	
				
				if(start_row_by_vector) i <= i+1;
				
		end		
		
	end	  
	
	always @(posedge clk)
		begin
			if (start_row_by_vector && (number_of_multiples - number_of_multiples_counter -1) == 0)	   
			begin  pipeline0 <=1 ;end 
			else 
			begin 
			pipeline0 <= 0 	 ;
			end	
			
			pipeline1 <= pipeline0;
			pipeline2 <= pipeline1;
			pipeline3 <= pipeline2;
			pipeline4 <= pipeline3;
			pipeline5 <= pipeline4;	
			pipeline6 <= pipeline5;
			pipeline7 <= pipeline6;
			pipeline8 <= pipeline7;
			
			//decoder_read_now <= pipeline5;
			decoder_read_now <= pipeline8;
			
		end	
	
endmodule
