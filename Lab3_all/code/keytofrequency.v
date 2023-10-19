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

input  clk_5MHz;
input wire[4:0] notecode;



/*****************************************************************************/
output reg[13:0] countStart;
always @ (posedge clk_5MHz)
begin
// write your code here
// you can also modify other parts.
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

