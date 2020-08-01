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

//ADC����ģ��
module Driver_ADC(
    input clk_100MHz,     //Clock
    input clk_system,     //Clock reading signal    ʱ�Ӷ����ź�
    input Rst,            //Reset signal, low reset
    input[7:0]ADC_Data,   //ADC sampling data  ADC��������
    input[17:0]Read_Addr, //Read signal address   ��ȡ�źŵ�ַ
    input[7:0]Trigger_Gate, //Trigger threshold   ������ֵ
    
    output[17:0]Period, //frequency    Ƶ��
    output clk_ADC, //ADC clock
    output ADC_En, //ADC enable signal    ADCʹ���ź�
    output [7:0]ADC_Data_Out //Storage signal output  �洢�ź����
    ); 
  
    //Number of samples  ����������
    parameter Sampling_Num=38400;       //��Sampling_Num����Ϊ����38400
   
    //ADC, address counter  ADC��ַ������
    reg [15:0]Addr_Cnt=0;
   
    //Actual read address  ʵ�ʶ�ȡ��ַ
    reg[15:0]Addr_Read_Real=0;
    
    //ADC enable signal connection   ADCʹ���ź�����
    assign ADC_En=~Rst;          //~Rst������ֵ��ADC_En��ֻҪ~Rst�仯���ͻḳֵ
    
    //Frequency division produces ADC clock     Ƶ�ֲ���ADCʱ��
    Clk_Division_0 Clk_Division_ADC(
            .clk_100MHz(clk_100MHz),  // input wire clk_100MHz
            .clk_mode(200),           // input wire [30 : 0] clk_mode
            .clk_out(clk_ADC)         // output wire clk_out
            );
    //ADC address count    ADC��ַ����
    always@(posedge clk_ADC or negedge Rst)     //����������clk_ADC�����ػ���RST�½���
        begin
    //Low level reset
            if(!Rst)
                Addr_Cnt<=0;
            else if(Addr_Cnt==Sampling_Num-1)      //���ADC��ַ������Addr_Cnt=38400-1
                Addr_Cnt<=0;
            else
                Addr_Cnt<=Addr_Cnt+1;
        end
    //Frequency calculation   Ƶ�ʼ���
    Wave_Freq_Cal Freq_Cal0(
        .clk_100MHz(clk_100MHz),
        .Rst(Rst),
        .ADC_Data(ADC_Data),
        .F_Gate(Trigger_Gate),
        .Period(Period)
        );
    //Waveform signal storage    �����źŴ洢
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