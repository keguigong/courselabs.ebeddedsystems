`include "define.v"
module matmult_kernel (Clk, Start, A_0, A_1, A_2, A_3, A_4, A_5, A_6, A_7,
                   A_8, A_9, A_10, A_11, A_12, A_13, A_14, A_15,
                   B_0, B_1, B_2, B_3, B_4, B_5, B_6, B_7,
                   B_8, B_9, B_10, B_11, B_12, B_13, B_14, B_15,
                   C, Rd_en, Rd_A_addr, Rd_B_addr, Wr_en, Wr_addr
);

input Clk, Start;
input signed [`INPUTWIDTH-1:0] A_0, A_1, A_2, A_3, A_4, A_5, A_6, A_7;
input signed [`INPUTWIDTH-1:0] A_8, A_9, A_10, A_11, A_12, A_13, A_14, A_15;
input signed [`INPUTWIDTH-1:0] B_0, B_1, B_2, B_3, B_4, B_5, B_6, B_7;
input signed [`INPUTWIDTH-1:0] B_8, B_9, B_10, B_11, B_12, B_13, B_14, B_15;

output reg Rd_en, Wr_en;
output reg [`INADDRWIDTH-1:0] Rd_A_addr;
output reg [`INADDRWIDTH-1:0] Rd_B_addr;
output reg [`OUTADDRWIDTH-1:0] Wr_addr;
output [`OUTPUTWIDTH-1:0] C;

//######################################################
reg [8:0] cycle_cnt=`EXECYCLE;

always @(posedge Clk)
begin
    if(Start && cycle_cnt == `EXECYCLE) 
    begin
        cycle_cnt<=0;
    end
    else if(cycle_cnt<`EXECYCLE)
    begin
        cycle_cnt<=cycle_cnt+1;
    end
end

always @(posedge Clk)
begin
    //To do: generate signals: Rd_A_addr, Rd_B_addr and Rd_en  
    //Tips: you should use cycle_cnt 

end

always @(posedge Clk)
begin
    if(cycle_cnt>=6 && cycle_cnt<`EXECYCLE)
    begin
        Wr_en<=1;
        Wr_addr<=cycle_cnt-6;
    end
    else 
    begin
        Wr_en<=0;
        Wr_addr<=0;
    end
end

//######################################################
reg [`OUTPUTWIDTH-1:0] reg_state_1 [15:0];
reg [`OUTPUTWIDTH-1:0] reg_state_2 [7:0];
reg [`OUTPUTWIDTH-1:0] reg_state_3 [3:0];
reg [`OUTPUTWIDTH-1:0] reg_state_4 [1:0];
reg [`OUTPUTWIDTH-1:0] reg_state_5;

//state_1
always@(posedge Clk)
begin
    //To do: finish pipeline stage 1

end

//state_2
always@(posedge Clk)
begin
    //To do: finish pipeline stage 2
    
end

//state_3
always@(posedge Clk)
begin
    //To do: finish pipeline stage 3
    
end

//state_4
always@(posedge Clk)
begin
    //To do: finish pipeline stage 4
    
end

//state_5
always@(posedge Clk)
begin
    //To do: finish pipeline stage 5
    
end

assign C=reg_state_5;

endmodule