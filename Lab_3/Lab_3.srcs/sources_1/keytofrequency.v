`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2021 12:45:46 AM
// Design Name: 
// Module Name: keytofrequency
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module keytofrequency(clk_5MHz, notecode, countStart);

input clk_5MHz;
input wire[4:0] notecode;

output reg[13:0] countStart;

reg [15:0] frequency;
reg [4:0] freq_offset;

always @(posedge clk_5MHz) begin
    case (notecode)
       1: frequency <= 261;
       2: frequency <= 293;
       3: frequency <= 329;
       4: frequency <= 349;
       5: frequency <= 391;
       6: frequency <= 439;
       7: frequency <= 493;
       
       8: frequency <= 523;
       9: frequency <= 587;
       10: frequency <= 659;
       11: frequency <= 698;
       12: frequency <= 783;
       13: frequency <= 874;
       14: frequency <= 987;
       
       15: frequency <= 1046;
       16: frequency <= 1174;
       17: frequency <= 1318;
       18: frequency <= 1396;
       19: frequency <= 1568;
       20: frequency <= 1760;
       21: frequency <= 1974;

       default: frequency <= 0;
    endcase
end

always @(posedge clk_5MHz) begin
    if (frequency > 0) begin
        freq_offset <= (5000000 / frequency) / 2;
    end
   else begin
       freq_offset <= 0;
   end
end

/*****************************************************************************/
//output reg[13:0] countStart;
always @ (posedge clk_5MHz) begin
   // write your code here
   // you can also modify other parts.
   if (freq_offset > 0) begin
       countStart <= freq_offset - 1;
   end else begin
       countStart <= 0;
   end
end	

/*****************************************************************************/
// output wire[13:0] countStart;
// blk_mem_gen_0 BRAMROM(
//        .clka(clk_5MHz),
//        .addra(notecode),
//        .douta(countStart),
//        .ena(1)
//       );
   
endmodule

