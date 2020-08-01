`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 13:49:49
// Design Name: 
// Module Name: Wave_Generator
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

//波形显示模块
module Wave_Generator(
    input RGB_VDE,         //RGB显示器
    input [17:0]Offset,     //偏移地址？？？
    input [11:0]Set_X,
    input [11:0]Set_Y,
    input [7:0]ADC_Data_Out,
    
    output reg[17:0]Read_Addr,       //读地址
    output reg[23:0]RGB_Data=0       //RBG
    );
    always@(*)      //敏感条件：always模块中的任何一个输入信号或电平发生变化时
        begin
            Read_Addr=Set_X+Offset;       //把Set_X+偏移地址赋值给Read_Addr
             if(Set_Y>=283&&Set_Y<797)    //当Set_Y处于[283,797）的时候
                 if(Set_Y==ADC_Data_Out+284||Set_Y==ADC_Data_Out+283||Set_Y==ADC_Data_Out+285)   //
                     RGB_Data<=24'hff00ff;
                 else
                     RGB_Data<=24'h000000;
            else                          //当Set_Y不在[283,797）的时候
                 RGB_Data<=24'h000000;      //输出全赋0
        end
endmodule