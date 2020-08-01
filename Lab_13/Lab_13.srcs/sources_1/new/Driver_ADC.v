`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 17:22:52
// Design Name: 
// Module Name: Driver_ADC
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

//ADC驱动模块
module Driver_ADC(
    input clk_100MHz,     //Clock
    input clk_system,     //Clock reading signal    时钟读数信号
    input Rst,            //Reset signal, low reset
    input[7:0]ADC_Data,   //ADC sampling data  ADC抽样数据
    input[17:0]Read_Addr, //Read signal address   读取信号地址
    input[7:0]Trigger_Gate, //Trigger threshold   触发阈值
    
    output[17:0]Period, //frequency    频率
    output clk_ADC, //ADC clock
    output ADC_En, //ADC enable signal    ADC使能信号
    output [7:0]ADC_Data_Out //Storage signal output  存储信号输出
    ); 
  
    //Number of samples  抽样的数量
    parameter Sampling_Num=38400;       //把Sampling_Num定义为常量38400
   
    //ADC, address counter  ADC地址计数器
    reg [15:0]Addr_Cnt=0;
   
    //Actual read address  实际读取地址
    reg[15:0]Addr_Read_Real=0;
    
    //ADC enable signal connection   ADC使能信号连接
    assign ADC_En=~Rst;          //~Rst连续赋值给ADC_En，只要~Rst变化，就会赋值
    
    //Frequency division produces ADC clock     频分产生ADC时钟
    Clk_Division_0 Clk_Division_ADC(
            .clk_100MHz(clk_100MHz),  // input wire clk_100MHz
            .clk_mode(200),           // input wire [30 : 0] clk_mode
            .clk_out(clk_ADC)         // output wire clk_out
            );
    //ADC address count    ADC地址计数
    always@(posedge clk_ADC or negedge Rst)     //敏感条件：clk_ADC上升沿或者RST下降沿
        begin
    //Low level reset
            if(!Rst)
                Addr_Cnt<=0;
            else if(Addr_Cnt==Sampling_Num-1)      //如果ADC地址计数器Addr_Cnt=38400-1
                Addr_Cnt<=0;
            else
                Addr_Cnt<=Addr_Cnt+1;
        end
    //Frequency calculation   频率计算
    Wave_Freq_Cal Freq_Cal0(
        .clk_100MHz(clk_100MHz),
        .Rst(Rst),
        .ADC_Data(ADC_Data),
        .F_Gate(Trigger_Gate),
        .Period(Period)
        );
    //Waveform signal storage    波形信号存储
    Wave_Ram Sampling_38400_0(
        .clka(clk_ADC), // input wire clka
        .wea(Rst), // input wire [0 : 0] wea
        .addra(Addr_Cnt), // input wire [9 : 0] addra
        .dina(ADC_Data), // input wire [7 : 0] dina
        .clkb(clk_system), // input wire clkb
        .addrb(Read_Addr), // input wire [15 : 0] addrb
        .doutb(ADC_Data_Out) // output wire [7 : 0] doutb
    );
endmodule