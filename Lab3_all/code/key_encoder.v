`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2021 12:45:46 AM
// Design Name: 
// Module Name: key_encoder
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


module key_encoder(clk_5MHz, IOs, notecode);

input  clk_5MHz;
input  wire [9:0] IOs;
output reg [4:0] notecode;

	
/*****************************************************************************/
always @ (posedge clk_5MHz)
begin
// write your code here
// you can also modify other parts.
end	

endmodule
