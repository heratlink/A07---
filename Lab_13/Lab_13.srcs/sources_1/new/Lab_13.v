`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 17:10:50
// Design Name: 
// Module Name: Lab_13
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

//=是串行的，<=是并行的      input必须是wire  out看赋值方式决定是reg还是wire  
//无符号数：位宽' 进制 数字   有符号数： 位宽 'sb 数字
module Lab_13(
    input clk_100MHz,
    input [7:0]ADC_Data,
    
    output clk_ADC,
    output ADC_En,
    output TMDS_Tx_Clk_N,
    output TMDS_Tx_Clk_P,
    output [2:0]TMDS_Tx_Data_N,
    output [2:0]TMDS_Tx_Data_P
    );
    wire clk_100MHz_system;
    wire clk_system;        //Clock reading signal    时钟读数信号
    wire [23:0]RGB_Data;
    wire [23:0]RGB_In;
    wire RGB_HSync;
    wire RGB_VSync;
    wire RGB_VDE;
    wire [11:0]Set_X;
    wire [11:0]Set_Y;
    
    //ADC
    wire[17:0]Read_Addr; //Read signal address    读取信号地址
    wire[7:0]ADC_Data_Out; //Storage signal output    存储信号输出
    
    //Offset 
    wire [20:0]Offset;
    //例化clk_wiz
    clk_wiz_0 clk_10(.clk_out1(clk_system),.clk_out2(clk_100MHz_system),.clk_in1(clk_100MHz)); 

    //RGBToDvi instantiation      RGBToDvi实例化
    rgb2dvi_0 rgb2dvi(
    .TMDS_Clk_p(TMDS_Tx_Clk_P),
    .TMDS_Clk_n(TMDS_Tx_Clk_N),
    .TMDS_Data_p(TMDS_Tx_Data_P),
    .TMDS_Data_n(TMDS_Tx_Data_N),
    .aRst_n(1),
    .vid_pData(RGB_Data),
    .vid_pVDE(RGB_VDE),
    .vid_pHSync(RGB_HSync),
    .vid_pVSync(RGB_VSync),
    .PixelClk(clk_system));
    
    //Video production      视频制作（Driver_HDMI_0实例化
    Driver_HDMI_0 Driver_HDMI0(
    .clk(clk_system), //Clock
    .Rst(1), //Reset signal, low reset
    .Video_Mode(0), //Video format
    .RGB_In(RGB_In), //Input data
    .RGB_Data(RGB_Data), //Output data
    .RGB_HSync(RGB_HSync), //Line signal
    .RGB_VSync(RGB_VSync), //Field signal
    .RGB_VDE(RGB_VDE), //Data valid signal
    .Set_X(Set_X), //Image coordinate X
    .Set_Y(Set_Y) //Image coordinate Y
    );
    
    //ADC Driver        ADC驱动模块实例化
    Driver_ADC Driver_ADC0(
    .clk_100MHz(clk_100MHz_system), //System clock
    .clk_system(clk_system), //Clock reading signal
    .Rst(1), //Reset signal, low reset
    .ADC_Data(ADC_Data), //ADC sampling data
    .Read_Addr(Read_Addr), //Read signal address
    .Trigger_Gate(128), //Trigger threshold
    .Period(Offset),
    .clk_ADC(clk_ADC), //ADC clock
    .ADC_En(ADC_En), //ADC enable signal
    .ADC_Data_Out(ADC_Data_Out) //Storage signal output
    );
    
    Wave_Generator Wave_Generator0(        //波形显示模块实例化
    .RGB_VDE(RGB_VDE),
    .Offset(Offset),
    .Set_X(Set_X),
    .Set_Y(Set_Y),
    .ADC_Data_Out(ADC_Data_Out),
    .Read_Addr(Read_Addr),
    .RGB_Data(RGB_In) //RBG
    );
endmodule