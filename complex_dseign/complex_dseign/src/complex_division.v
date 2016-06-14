//-----------------------------------------------------------------------------
//
// Title       : complex_division
// Design      : complex_dseign
// Author      : Windows User
// Company     : nada
//
//-----------------------------------------------------------------------------
//
// File        : complex_division.v
// Generated   : Tue Jun 14 15:25:30 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps


module complex_division(clk,start,A,B,result,finish_flag);	
	
	input wire [63:0] A,B;
	input wire clk,start;
	
	output wire[63:0] result;
	output reg finish_flag;
	
	wire[63:0]den_conj,new_num,new_den;
	wire[31:0] num_real,num_imj;
	wire[31:0]result_real,result_imj;
	
	
	integer count;
	
	
	assign num_real=new_num[63:32];
	assign num_imj=new_num[31:0];
	
	assign result={result_real,result_imj};	 
	
	complex_conjugate cc (B,clk,den_conj); 
	
	complex_multiply cm1 (A,den_conj,clk,'b1,new_num); 
	complex_multiply cm2 (B,den_conj,clk,1'b1,new_den);
	
	FP_div D1 (num_real,new_den[63:32],clk,start,result_real);
	FP_div D2 (num_imj ,new_den[63:32],clk,start,result_imj);	 
	
	
	initial
	begin
		count=0;
		finish_flag=0;
		
	end	
	
	always@(posedge clk)
		begin 
			if(start==0)
				begin
					count<=0;
	                finish_flag<=0;
		         end
		
				
			else if(start&&count<11) 
				begin
					count<= count+1;
					
				end
				
			else if(start&&count==11)
				begin
					finish_flag <= 1; 
				
				end
				
				
			end	


endmodule
