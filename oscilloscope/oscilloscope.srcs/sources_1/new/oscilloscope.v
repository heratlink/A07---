`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 21:48:15
// Design Name: 
// Module Name: oscilloscope
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


module oscilloscope(
    input clk_100MHz,
    input [1:0]Key,
    input [7:0]ADC_Data,
    input UART0_Rx,
    
    output UART0_Tx,
    output clk_DAC,            //DAC时钟
    output DAC_Din,
    output DAC_Sync,
    output clk_ADC,          //ADC时钟
    output ADC_En
    );
    
    wire clk_100MHz_System;
    wire clk_10MHz;
    
    reg [17:0]Read_Addr = 0;        //Read signal address
    wire [7:0]ADC_Data_Out;      //Storage signal output
   
    //Offset 偏移地址
    wire [20:0]Offset;
    
    wire Tx_ACK;
    wire Rx_ACK;
    wire Tx_En;
    wire [7:0]Send_Buffer;
    wire [7:0]Rx_Data;
   
    //clk_5_10实例化
    clk_5_10 clk_division(.clk_out1(clk_DAC),.clk_out2(clk_100MHz_System),.clk_out3(clk_10MHz),.clk_in1(clk_100MHz));
    
    //DAC驱动模块实例化
    Driver_DAC_0 u_Driver_DAC(
        .clk_100MHz(clk_100MHz_System),
        .clk_DAC(clk_DAC),
        .DAC_En(1),
        .Wave_Mode(Key),
        .Phase(180),
        .DAC_Din(DAC_Din),
        .DAC_Sync(DAC_Sync)
        ); 

        //ADC驱动模块实例化
    Driver_ADC_0 u_Driver_ADC(
        .clk_100MHz(clk_100MHz_System), //System clock              
        .clk_system(clk_100MHz_System),        //Clock reading signal
        .Rst(1),                        //Reset signal, low reset
        .ADC_Data(ADC_Data),            //ADC sampling data
        .Read_Addr(Read_Addr),          //Read signal address
        .Trigger_Gate(128),             //Trigger threshold
        .Period(Offset),
        .clk_ADC(clk_ADC),              //ADC clock
        .ADC_En(ADC_En),                //ADC enable signal
        .ADC_Data_Out(ADC_Data_Out)     //Storage signal output
        );
    
     //UART驱动模块实例化   
     Driver_UART_0 u_Driver_UART(
        .clk_100MHz(clk_100MHz_System),
        .Rst(1),
        .En_Rx(1),
        .En_Tx(Tx_En),
        .Baud_Rate(38400),         //波特率
        .Rx(UART0_Rx),
        .Tx_Data(Send_Buffer),
        .Tx(UART0_Tx),
        .Rx_Data(Rx_Data),
        .Rx_ACK(Rx_ACK),
        .Tx_ACK(Tx_ACK)
        );
        
    UART_Send0 u_UART_Send(
        .clk_10MHz(clk_10MHz),
        .Tx_ACK(Tx_ACK),
        .Enable(1),
        .Data(ADC_Data_Out),
        .Tx_En(Tx_En),
        .Send_Buffer(Send_Buffer)
        );
        
endmodule
