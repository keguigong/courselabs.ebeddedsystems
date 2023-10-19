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

parameter DO = 0;
parameter RA = 1;
parameter ME = 2;
parameter FA = 3;
parameter SO = 4;
parameter LA = 5;
parameter TI = 6;

reg [4:0] key_code;
reg [2:0] freq_range;
	
/*****************************************************************************/
//always @ (posedge clk_5MHz)
//begin
//    // write your code here
//    // you can also modify other parts.
//    case(IOs[9:7])
//        3'b001: freq_range = 0;
//        3'b010: freq_range = 1;
//        3'b100: freq_range = 2;
//        default: freq_range = 3'b000;
//    endcase
//end

//always @(posedge clk_5MHz) begin
//    case (IOs[6:0])
//        7'b0000001: key_code <= DO + (freq_range * 7) + 1;
//        7'b0000010: key_code <= RA + (freq_range * 7) + 1;
//        7'b0000100: key_code <= ME + (freq_range * 7) + 1;
//        7'b0001000: key_code <= FA + (freq_range * 7) + 1;
//        7'b0010000: key_code <= SO + (freq_range * 7) + 1;
//        7'b0100000: key_code <= LA + (freq_range * 7) + 1;
//        7'b1000000: key_code <= TI + (freq_range * 7) + 1;
//        default: key_code <= 5'b00000;
//    endcase
//end

always @(posedge clk_5MHz) begin
    case (IOs[9:0])
        10'b001_0000001: key_code <= 1;
        10'b001_0000010: key_code <= 2;
        10'b001_0000100: key_code <= 3;
        10'b001_0001000: key_code <= 4;
        10'b001_0010000: key_code <= 5;
        10'b001_0100000: key_code <= 6;
        10'b001_1000000: key_code <= 7;
        
        10'b010_0000001: key_code <= 8;
        10'b010_0000010: key_code <= 9;
        10'b010_0000100: key_code <= 10;
        10'b010_0001000: key_code <= 11;
        10'b010_0010000: key_code <= 12;
        10'b010_0100000: key_code <= 13;
        10'b010_1000000: key_code <= 14;
        
        10'b100_0000001: key_code <= 15;
        10'b100_0000010: key_code <= 16;
        10'b100_0000100: key_code <= 17;
        10'b100_0001000: key_code <= 18;
        10'b100_0010000: key_code <= 19;
        10'b100_0100000: key_code <= 20;
        10'b100_1000000: key_code <= 21;
        
        default: key_code <= 5'b00000;
    endcase
end

always @(posedge clk_5MHz) begin
    notecode <= key_code;
end

endmodule
