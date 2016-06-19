//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Mon Apr 21 2014 01:17:53
//
//      Input file      : 
//      Component name  : fpaddsub_8_23_uid2_rightshifter
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------

module FPAddSub_8_23_uid2_RightShifter(clk, rst, X, S, R);
   input         clk;
   input         rst;
   input [23:0]  X;
   input [4:0]   S;
   output [49:0] R;
   wire [23:0]   level0;
   wire [4:0]    ps;
   wire [24:0]   level1;
   wire [26:0]   level2;
   wire [30:0]   level3;
   wire [38:0]   level4;
   wire [54:0]   level5;
   /*
   always @(posedge clk)
      
         ;
   */
	assign level0 = X;
   assign ps = S;
   assign level1 = (ps[0] == 1'b1) ? {1'b0, level0} : 
                   {level0, 1'b0};
   assign level2 = (ps[1] == 1'b1) ? {2'b00, level1} : 
                   {level1, 2'b00};
   assign level3 = (ps[2] == 1'b1) ? {4'b0000, level2} : 
                   {level2, 4'b0000};
   assign level4 = (ps[3] == 1'b1) ? {8'b00000000, level3} : 
                   {level3, 8'b00000000};
   assign level5 = (ps[4] == 1'b1) ? {16'b0000000000000000, level4} : 
                   {level4, 16'b0000000000000000};
   assign R = level5[54:5];
   
endmodule