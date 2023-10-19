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

always @(posedge clk_5MHz) begin
    case (IOs)
        10'b001_0000001: notecode <= 1;
        10'b001_0000010: notecode <= 2;
        10'b001_0000100: notecode <= 3;
        10'b001_0001000: notecode <= 4;
        10'b001_0010000: notecode <= 5;
        10'b001_0100000: notecode <= 6;
        10'b001_1000000: notecode <= 7;
        
        10'b010_0000001: notecode <= 8;
        10'b010_0000010: notecode <= 9;
        10'b010_0000100: notecode <= 10;
        10'b010_0001000: notecode <= 11;
        10'b010_0010000: notecode <= 12;
        10'b010_0100000: notecode <= 13;
        10'b010_1000000: notecode <= 14;
        
        10'b100_0000001: notecode <= 15;
        10'b100_0000010: notecode <= 16;
        10'b100_0000100: notecode <= 17;
        10'b100_0001000: notecode <= 18;
        10'b100_0010000: notecode <= 19;
        10'b100_0100000: notecode <= 20;
        10'b100_1000000: notecode <= 21;
        
        default: notecode <= 5'b00000;
    endcase
end

endmodule
