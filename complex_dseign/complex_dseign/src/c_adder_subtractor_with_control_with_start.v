
`timescale 1 ns / 1 ps


module complex_adder_subtractor_with_control_with_start (start,A, B,result,op,clk,ce,controlled_adder_output,iteration_reinitialization,finish,finish_dash);

input A,B;	
input iteration_reinitialization;

wire[63:0] A,B;	  


input clk ,op,ce,start;
output reg finish=0;   
output reg finish_dash=0;
output result;	 


output wire [63:0] controlled_adder_output;	
reg [63:0] previous_value;

wire [63:0] result;
wire[31:0] A_real,A_imj,B_real,B_imj;
wire[31:0]result_real,result_imj;  

assign A_real=A[63:32];
assign A_imj=A[31:0];
assign B_real=B[63:32];
assign B_imj=B[31:0];
assign result={result_real,result_imj};	

	
fpadd Adder1 (A_real, B_real,result_real,op,clk,1'b1);
fpadd Adder2 (A_imj, B_imj,result_imj,op,clk,1'b1);

assign controlled_adder_output = finish_dash?result:previous_value;
always@(posedge clk)
	begin 
		if(finish_dash==1)
			previous_value <= result;
		else if (!iteration_reinitialization )
			previous_value <= 64'b0;		
	end	
	
	
	
	always @(posedge clk)
	begin

			finish<=start;
	end	
	
	always @(posedge clk)
		begin 
			finish_dash<=finish;
		end	

endmodule
