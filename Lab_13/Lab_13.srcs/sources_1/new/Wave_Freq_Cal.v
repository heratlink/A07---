`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 17:11:26
// Design Name: 
// Module Name: Wave_Freq_Cal
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


//Waveform frequency calculation      波形频率计算
module Wave_Freq_Cal(
    input clk_100MHz,               //100MHz的输入时钟
    input Rst,                      //复位信号
    input [7:0]ADC_Data,            //位宽8位        ADC转换而来的8位数字信号
    input [7:0]F_Gate,              //位宽8位        设置的阈值
    output reg[20:0]Period=1        //位宽21位     想寄存一下，让信号在时钟边沿才变化就需要reg类型；always块中用reg型，assign语句用wire型。端口之间连线也用wire型
    );
    parameter Measure_Num=5;        //把Measure_Num定义为一个常量5
    //Measurement signal
    wire Signal_Pulse=ADC_Data>F_Gate?1:0;   //定义一个脉冲，如ADC的数字信号超过阈值为1，否则为0.     F_Gate是阈值
    //Measurement parameter
    reg [31:0]Measure_Cnt=0;     //测量计数  32位宽
    reg [19:0]Measure_Num_Cnt=0; //脉冲计数  20位宽
    reg [31:0]Measure_Delta_Cnt=0; //相邻间隔计数  32位宽
    reg Measure_Delta_Clear=0; //Adjacent measurement empty  相邻的测量值空的
    reg Delta_Clear_Flag=0; //Interval clear flag  间隔清除标志
   
    //Adjacent pulse interval count  相邻脉冲间隔计数
    always@(posedge clk_100MHz or negedge Rst)     // 敏感条件：100Mhz时钟的上升沿或者RST复位信号的下降沿 执行下边内容
        begin
     //Low level reset  低电平复位
            if(!Rst)                     //如果！RST=1 ——RST=0——如果Rst为低电平
                begin
                    Measure_Delta_Cnt<=0;        //相邻间隔计数赋值0         非阻塞赋值“<=”（时序逻辑电路）
                    Delta_Clear_Flag<=0;         //间隔清除标志初始化赋值0
                end
     //If cleared  
            else if(Measure_Delta_Clear)      //如果RST=1，并且Measure_Delta_Clear=1，理解为相邻的测量值不为空？
                begin
                    Measure_Delta_Cnt<=0;      //相邻间隔计数初始化赋值0
                    Delta_Clear_Flag<=1;           //间隔清除标志初始化赋值1
                end
            else                            //当上面两种都不符合时候， 即RST=1，并且Measure_Delta_Clear=0，理解为相邻的测量值为空？
                begin
                    Measure_Delta_Cnt<=Measure_Delta_Cnt+1;       //相邻间隔计数自动+1
                    Delta_Clear_Flag<=0;                          //间隔清除标志初始化赋值0             
                end 
            end
            
    //Pulse count 脉冲计数
    always@(posedge Signal_Pulse or negedge Rst or posedge Delta_Clear_Flag)  //敏感条件：脉冲上升沿或者RST下降沿或者间隔清除标志上升沿的时候执行下面
        begin
 //Low level reset 低电平复位
            if(!Rst)                      //如果Rst=0
                begin
                    Measure_Num_Cnt<=0;         //脉冲计数赋值0
                    Measure_Delta_Clear<=0;      //相邻的测量值空的
                    Measure_Cnt<=0;               //测量计数赋值0
                    Period<=0;                      //Period时间？？？ 赋值0
                end 
 //Cleared if cleared
        else if(Delta_Clear_Flag)            //如果RST=1且间隔清除标志=1
            Measure_Delta_Clear<=0;            //相邻的测量值空的
        else                                    //如果RST=1且间隔清除标志=0
            begin
                if(Measure_Num_Cnt==Measure_Num-1) //如果RST=1且间隔清除标志=0，并且且脉冲计数=5-1=4
                    begin
                        if(Measure_Cnt<200)     //如果RST=1且间隔清除标志=0且脉冲计数=4，并且测量计数<200
                            Period<=1;          //赋值
                        else if(Measure_Cnt>1000000)    //如果测量计数>1000000
                            Period<=5000;           //赋值
                        else                        //如果测量计数在200~1000000
                            Period<=Measure_Cnt/200;      //赋值=测量计数/200
                        Measure_Num_Cnt<=0;            //脉冲计数=0
                        Measure_Delta_Clear<=1;          //相邻的测量值不空？
                        Measure_Cnt<=0;                 //测量计数=0
                    end                    
                else            //如果RST=1且间隔清除标志=0，并且且脉冲计数不为4
                    begin
                        Measure_Num_Cnt<=Measure_Num_Cnt+1;            //脉冲计数自动+1
                        Measure_Cnt<=Measure_Cnt+Measure_Delta_Cnt;       //测量计数=测量计数+相邻间隔计数
                    end
            end
        end
endmodule
