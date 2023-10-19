`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2021 01:28:00 AM
// Design Name: 
// Module Name: PWMcontroler
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


module PWMcontroller(
        clk_5MHz,
        countStart,
        reset,
        beep
    );
    
input clk_5MHz;
input [13:0] countStart;
input reset;
output beep;


reg beep_r;
reg [13:0] count;
  
// write your code here
// you can also modify other parts.
reg [1:0] flag;

always @(posedge clk_5MHz, posedge reset)
begin  
    if (reset)
    begin
        // write your code here
        // you can also modify other parts.
        count <= 0;
        beep_r <= 0;
        flag <= 1'b1;
    end 
    else
    begin
        // write your code here
        // you can also modify other parts.
        if (count < countStart) begin
            count <= count + 1;
        end else begin
            count <= 0;
            flag <= ~flag;
        end
    end
    beep <= flag;
end

endmodule
