//-----------------------------------------------------------------------------
//
// Title       : complex_Eight_Organizer_with_control
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_Eight_Organizer_with_control.v
// Generated   : Wed Jun 15 18:21:54 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module complex_Eight_Organizer_with_control (clk,adder_row_input,start,adder_output,outsider4,outsider15);

parameter element_width=64;	
parameter NI = 8;
input clk ;


input wire [NI*element_width-1:0] adder_row_input;
input wire start;

reg mux_select;
reg [element_width-1:0] mux_one = 64'b0;
wire [element_width-1:0] mux_output;
wire[element_width-1:0] pre_last_output;	 
output wire [element_width-1:0] adder_output ;

integer other_counter ;

input wire outsider4;
reg outsider5=0;
reg outsider6=0;
reg outsider7=0;
reg outsider8=0;
reg outsider9=0; 
reg outsider10=0; 
reg outsider11=0; 
reg outsider12=0; 
reg outsider13=0; 
reg outsider14=0;
output reg outsider15; 

reg first_time = 1;

reg [element_width-1:0] previous_adder_output = 64'b0; 
reg [element_width-1:0] second_pre_last_output;
wire [element_width-1:0] controlled_adder_output;

complex_TwoxOne_mux m1 (controlled_adder_output,mux_one,mux_output,mux_select);
complex_EightxEight_Adder A1 (clk,adder_row_input,pre_last_output);
complex_adder_subtractor_with_control final_adder (mux_output,second_pre_last_output , adder_output, 0,clk,1,outsider15,controlled_adder_output,start);


always @(posedge clk)
begin
	if(!start)
		begin
			other_counter<=0;	
			mux_select <= 1; 
			previous_adder_output = 64'b0;
		end
	else 
		begin
			if( outsider12 ==1 && !first_time)
				begin
					mux_select <= 0;  
				end	
			else if (outsider12 ==1)
				begin	
					first_time<=0;
				end	
			else begin mux_select<=1; end	
		end
	
end	 


always @(posedge clk)
	begin 
	outsider5<=outsider4;
	outsider6<=outsider5;
	outsider7<=outsider6;
	outsider8<=outsider7;
	outsider9<=outsider8; 
	outsider10<=outsider9;
	outsider11<=outsider10;
	outsider12<=outsider11;
	outsider13<=outsider12;
	outsider14<=outsider13;	   
	outsider15<=outsider14;
	end		 
	
	always @(posedge clk)
		begin
			second_pre_last_output<= pre_last_output;	
		end	


endmodule
