
module eight_Dot_Product_Multiply(clk,reset ,first_row_input,second_row_input, dot_product_output,finish );
parameter element_width=32;
parameter NOE = 8;
parameter NI = 8;
integer repetition_times = (NI==8)?6:(NI==16)?6:0;
parameter additional = NI-(NOE%NI); 
parameter total = NOE+additional ;
integer counter = 0;
integer ii=0;
integer package_by_package_counter = 0;
output reg finish ;

input wire reset ;
input wire[element_width*NI-1:0] first_row_input;
input wire[element_width*NI-1:0] second_row_input;
reg save = 0;
reg adder_tree_start;
input clk ;
reg[element_width*NI-1:0] package_by_package;
wire [element_width*NI-1:0] multipliers_output_vector;
wire [element_width-1:0] adder_output;
output reg [element_width-1:0] dot_product_output;



wire[element_width*(NI/2)-1:0] demux_four_inputs;
reg demux_select;
reg flip;

//four_to_eight_demux demux_1(demux_four_inputs,demux_select,multipliers_output_vector);
N_to_2N_demux  #(.NI(NI))demux(demux_four_inputs,demux_select,multipliers_output_vector);


reg [element_width*(NI/2)-1:0] first_row_four_elements_subset;
reg [element_width*(NI/2)-1:0] second_row_four_elements_subset;

genvar j ;
generate
for(j=0;j<NI/2;j=j+1) begin : instantiate_Multiplier

multiply m (first_row_four_elements_subset[element_width*(NI/2-j)-1-:element_width], second_row_four_elements_subset[element_width*(NI/2-j)-1-:element_width], clk, 1, demux_four_inputs[element_width*(NI/2-j)-1-:element_width]);
end
endgenerate


Eight_Organizer #(.NI(NI)) E_O (clk,package_by_package,adder_tree_start , adder_output);





always @ (posedge clk)
begin
	if(reset)
		begin
			
			finish <= 0;
			//counter <= 0;
			ii <=0;
			save <= 0;

			package_by_package_counter <=0;   //ana l mzwdah
		end
	else if(!reset) 
		begin
			if(save) 
				begin 
					dot_product_output <= adder_output;
					save <= 0;
					finish<=1;
				end
			if(package_by_package_counter ==0)
				begin
					package_by_package_counter <=1;
				end
			if(ii < total/NI+3)
				begin
					package_by_package <= multipliers_output_vector;
					@(posedge clk);
					ii <=ii+1;
				end
			else if(ii == total/NI+3)
				begin
					package_by_package <= 0;
					
					@(posedge clk);
					@(posedge clk);
					@(posedge clk);
					@(posedge clk);
					@(posedge clk);
					@(posedge clk);
					save <= 1;
					ii <= ii+1;
				end
		end
end




always @(posedge clk)
begin
if(reset) begin counter <= 0;
adder_tree_start <= 0;
end
else if(!reset)
begin
if(counter>2) begin adder_tree_start <=1; end
counter <= counter+1;
end
end



always @(posedge clk)
	begin
		if(reset)
			begin
				demux_select <= 0;
				flip <= 1;
			end
		else if(!reset)
			begin
				if(flip)
					begin
						demux_select <= 1;
						first_row_four_elements_subset <= first_row_input[NI*element_width-1-:(NI/2)*element_width];
						second_row_four_elements_subset <= second_row_input[NI*element_width-1-:(NI/2)*element_width];
						flip <= 0;
					end
				else if(!flip)
					begin
						demux_select <=0;
						first_row_four_elements_subset <= first_row_input[(NI/2)*element_width-1-:(NI/2)*element_width];
						second_row_four_elements_subset <= second_row_input[(NI/2)*element_width-1-:(NI/2)*element_width];
						flip	<= 1;
					end
			end
	end


endmodule