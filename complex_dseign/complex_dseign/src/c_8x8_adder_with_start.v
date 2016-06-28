//-----------------------------------------------------------------------------
//
// Title       : complex_EightxEight_Adder
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_EightxEight_Adder.v
// Generated   : Wed Jun 15 18:16:50 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module complex_EightxEight_Adder_with_start (ExE_start,clk,inputs,summation,ExE_finish,ExE_finish_dash);
input wire clk;
parameter NI = 8;
input wire [NI*64-1:0] inputs ;
output wire[63:0] summation;

input wire ExE_start;
reg ExE_start_dash=0;
reg ExE_start_dash_dash=0;


wire[63:0] zero_one_sum ;
wire [63:0] two_three_sum;
wire [63:0] four_five_sum;
wire[63:0] six_seven_sum;
wire[63:0] zero_to_three_sum;
wire [63:0] four_to_seven_sum;

wire[1:0] finish_first_two;
reg [1:0] finish_first_two_dash=0;
wire[1:0] finish_second_two;  
reg [1:0] finish_second_two_dash=0; 
wire[1:0] finish_third_two;  
reg [1:0] finish_third_two_dash=0;
output wire ExE_finish;	
output reg ExE_finish_dash;

//stage
 														   
complex_adder_subtractor_with_start  zero_one_adder  (ExE_start_dash_dash,inputs[63:0],inputs[127:64], zero_one_sum, 1'b0,clk,1'b1,finish_first_two[1]);
												 		
complex_adder_subtractor_with_start  two_three_adder (ExE_start_dash_dash,inputs[191:128], inputs[255:192], two_three_sum, 1'b0,clk,1'b1,finish_first_two[0]);
												 		 
complex_adder_subtractor_with_start  four_five_adder (ExE_start_dash_dash,inputs[319:256],inputs[383:320], four_five_sum, 1'b0,clk,1'b1,finish_second_two[1]);
												 		 
complex_adder_subtractor_with_start  six_seven_adder (ExE_start_dash_dash,inputs[447:384],inputs[511:448], six_seven_sum, 1'b0,clk,1'b1,finish_second_two[0]);

// stage
complex_adder_subtractor_with_start  zero_to_three_adder (&finish_first_two_dash, zero_one_sum, two_three_sum, zero_to_three_sum, 1'b0,clk,1'b1,finish_third_two[1]);
complex_adder_subtractor_with_start  four_to_seven_adder (&finish_second_two_dash,four_five_sum,six_seven_sum , four_to_seven_sum, 1'b0,clk,1'b1,finish_third_two[0]);


//stage
complex_adder_subtractor_with_start  zero_to_six_adder (&finish_third_two_dash,zero_to_three_sum, four_to_seven_sum, summation, 1'b0,clk,1'b1,ExE_finish);


always@(posedge clk)
	begin
		if(finish_first_two!=0 && ! (&finish_first_two_dash))
			begin
				finish_first_two_dash <= finish_first_two_dash | finish_first_two;	
			end	
		else if(&finish_first_two_dash && !(&finish_first_two))	
			begin 
				finish_first_two_dash<=0;
			end	
	end
	
always@(posedge clk)
	begin
		if(finish_second_two!=0 && ! (&finish_second_two_dash))
			begin
				finish_second_two_dash <= finish_second_two_dash | finish_second_two;	
			end	
		else if(&finish_second_two_dash && !(&finish_second_two))	
			begin 
				finish_second_two_dash<=0;
			end	
	end	
	
always@(posedge clk)
	begin
		if(finish_third_two!=0 && ! (&finish_third_two_dash))
			begin
				finish_third_two_dash <= finish_third_two_dash | finish_third_two;	
			end	
		else if(&finish_third_two_dash && !(&finish_third_two))	
			begin 
				finish_third_two_dash<=0;
			end	
	end
	
always @(posedge clk)
	begin
		ExE_finish_dash<=ExE_finish;
		
		ExE_start_dash<=ExE_start;
		ExE_start_dash_dash <=ExE_start_dash;
	end	



endmodule
