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


module complex_EightxEight_Adder (clk,inputs,summation);
input wire clk;
parameter NI = 8;
input wire [NI*64-1:0] inputs ;
output wire[63:0] summation;


wire[63:0] zero_one_sum ;
wire [63:0] two_three_sum;
wire [63:0] four_five_sum;
wire[63:0] six_seven_sum;
wire[63:0] zero_to_three_sum;
wire [63:0] four_to_seven_sum;
////assign z_o_s=(inputs[63:0][63]==inputs[127:64][127]&&inputs[63:0][31]==inputs[127:64][95])? zero_one_sum:pip02;
////assign t_t_s=()

//stage
 														   
complex_adder_subtractor zero_one_adder  (inputs[63:0],inputs[127:64], zero_one_sum, 1'b0,clk,1'b1);
												 		
complex_adder_subtractor two_three_adder (inputs[191:128], inputs[255:192], two_three_sum, 1'b0,clk,1'b1);
												 		 
complex_adder_subtractor four_five_adder (inputs[319:256],inputs[383:320], four_five_sum, 1'b0,clk,1'b1);
												 		 
complex_adder_subtractor six_seven_adder (inputs[447:384],inputs[511:448], six_seven_sum, 1'b0,clk,1'b1);

// stage
complex_adder_subtractor zero_to_three_adder (zero_one_sum, two_three_sum, zero_to_three_sum, 1'b0,clk,1'b1);
complex_adder_subtractor four_to_seven_adder (four_five_sum,six_seven_sum , four_to_seven_sum, 1'b0,clk,1'b1);


//stage
complex_adder_subtractor zero_to_six_adder (zero_to_three_sum, four_to_seven_sum, summation, 1'b0,clk,1'b1);


endmodule
