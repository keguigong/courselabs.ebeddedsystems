`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name: 
// Module Name: fir_example
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


module fir_example(data_in,clk,data_out);
input signed [15:0] data_in;
input clk;
output signed [15:0] data_out;

parameter h1=5'd1;// can be any arbitary coeffiecient
parameter h2=5'd2;// can be any arbitary coeffiecient
parameter h3=5'd3;// can be any arbitary coeffiecient
parameter h4=5'd4;// can be any arbitary coeffiecient

reg signed [15:0] r1;// buffer1
reg signed [15:0] r2;// buffer2
reg signed [15:0] r3;// buffer3
reg signed [15:0] r4;// buffer4

//initialize buffers to zero
initial 
begin
    r1=16'd0;
    r2=16'd0;
    r3=16'd0;
    r4=16'd0;
end

always@(posedge clk)
begin

//write code here
end

//write code here

endmodule
