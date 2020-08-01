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

//������ʾģ��
module Wave_Generator(
    input RGB_VDE,         //RGB��ʾ��
    input [17:0]Offset,     //ƫ�Ƶ�ַ������
    input [11:0]Set_X,
    input [11:0]Set_Y,
    input [7:0]ADC_Data_Out,
    
    output reg[17:0]Read_Addr,       //����ַ
    output reg[23:0]RGB_Data=0       //RBG
    );
    always@(*)      //����������alwaysģ���е��κ�һ�������źŻ��ƽ�����仯ʱ
        begin
            Read_Addr=Set_X+Offset;       //��Set_X+ƫ�Ƶ�ַ��ֵ��Read_Addr
             if(Set_Y>=283&&Set_Y<797)    //��Set_Y����[283,797����ʱ��
                 if(Set_Y==ADC_Data_Out+284||Set_Y==ADC_Data_Out+283||Set_Y==ADC_Data_Out+285)   //
                     RGB_Data<=24'hff00ff;
                 else
                     RGB_Data<=24'h000000;
            else                          //��Set_Y����[283,797����ʱ��
                 RGB_Data<=24'h000000;      //���ȫ��0
        end
endmodule