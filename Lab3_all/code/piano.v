`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2021 01:32:12 AM
// Design Name: 
// Module Name: piano
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


module piano(
        clk_in,
        IOs,
        reset,
        beep
    );
    
input  clk_in;
input  reset;
input  wire [9:0] IOs;
output beep;

wire clk_5MHz;
wire [4:0] notecode;
wire[13:0] countStart;

clk_divider CLKDIV(/*fill here*/);
key_encoder ENCODER(/*fill here*/);
keytofrequency TOFREQ(/*fill here*/);
PWMcontroller PWMCTRL(/*fill here*/);

endmodule
