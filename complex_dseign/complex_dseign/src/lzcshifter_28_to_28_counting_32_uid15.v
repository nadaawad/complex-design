//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Mon Apr 21 2014 01:17:53
//
//      Input file      : 
//      Component name  : lzcshifter_28_to_28_counting_32_uid15
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------

module LZCShifter_28_to_28_counting_32_uid15(clk, rst, I, Count, O);
   input         clk;
   input         rst;
   input [27:0]  I;
   output [4:0]  Count;
   output [27:0] O;
   wire [27:0]   level5;
   wire          count4;
   reg           count4_d1;
   wire [27:0]   level4;
   wire          count3;
   reg           count3_d1;
   wire [27:0]   level3;
   wire          count2;
   reg           count2_d1;
   wire [27:0]   level2;
   reg [27:0]    level2_d1;
   wire          count1;
   wire [27:0]   level1;
   wire          count0;
   wire [27:0]   level0;
   wire [4:0]    sCount;
   
   always @(posedge clk)
      
      begin
         count4_d1 <= count4;
         count3_d1 <= count3;
         count2_d1 <= count2;
         level2_d1 <= level2;
      end
   assign level5 = I;
   assign count4 = (level5[27:12] == 16'b0000000000000000) ? 1'b1 : 
                   1'b0;
   assign level4 = (count4 == 1'b0) ? level5[27:0] : 
                   {level5[11:0], 16'b0000000000000000};
   assign count3 = (level4[27:20] == 8'b00000000) ? 1'b1 : 
                   1'b0;
   assign level3 = (count3 == 1'b0) ? level4[27:0] : 
                   {level4[19:0], 8'b00000000};
   assign count2 = (level3[27:24] == 4'b0000) ? 1'b1 : 
                   1'b0;
   assign level2 = (count2 == 1'b0) ? level3[27:0] : 
                   {level3[23:0], 4'b0000};
   assign count1 = (level2_d1[27:26] == 2'b00) ? 1'b1 : 
                   1'b0;
   assign level1 = (count1 == 1'b0) ? level2_d1[27:0] : 
                   {level2_d1[25:0], 2'b00};
   assign count0 = (level1[27] == 1'b0) ? 1'b1 : 
                   1'b0;
   assign level0 = (count0 == 1'b0) ? level1[27:0] : 
                   {level1[26:0], 1'b0};
   assign O = level0;
   assign sCount = {count4_d1, count3_d1, count2_d1, count1, count0};
   assign Count = sCount;
   
endmodule
//--------------Synchro barrier, entering cycle 4----------------
