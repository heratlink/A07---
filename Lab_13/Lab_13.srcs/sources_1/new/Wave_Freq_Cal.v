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


//Waveform frequency calculation      ����Ƶ�ʼ���
module Wave_Freq_Cal(
    input clk_100MHz,               //100MHz������ʱ��
    input Rst,                      //��λ�ź�
    input [7:0]ADC_Data,            //λ��8λ        ADCת��������8λ�����ź�
    input [7:0]F_Gate,              //λ��8λ        ���õ���ֵ
    output reg[20:0]Period=1        //λ��21λ     ��Ĵ�һ�£����ź���ʱ�ӱ��زű仯����Ҫreg���ͣ�always������reg�ͣ�assign�����wire�͡��˿�֮������Ҳ��wire��
    );
    parameter Measure_Num=5;        //��Measure_Num����Ϊһ������5
    //Measurement signal
    wire Signal_Pulse=ADC_Data>F_Gate?1:0;   //����һ�����壬��ADC�������źų�����ֵΪ1������Ϊ0.     F_Gate����ֵ
    //Measurement parameter
    reg [31:0]Measure_Cnt=0;     //��������  32λ��
    reg [19:0]Measure_Num_Cnt=0; //�������  20λ��
    reg [31:0]Measure_Delta_Cnt=0; //���ڼ������  32λ��
    reg Measure_Delta_Clear=0; //Adjacent measurement empty  ���ڵĲ���ֵ�յ�
    reg Delta_Clear_Flag=0; //Interval clear flag  ��������־
   
    //Adjacent pulse interval count  ��������������
    always@(posedge clk_100MHz or negedge Rst)     // ����������100Mhzʱ�ӵ������ػ���RST��λ�źŵ��½��� ִ���±�����
        begin
     //Low level reset  �͵�ƽ��λ
            if(!Rst)                     //�����RST=1 ����RST=0�������RstΪ�͵�ƽ
                begin
                    Measure_Delta_Cnt<=0;        //���ڼ��������ֵ0         ��������ֵ��<=����ʱ���߼���·��
                    Delta_Clear_Flag<=0;         //��������־��ʼ����ֵ0
                end
     //If cleared  
            else if(Measure_Delta_Clear)      //���RST=1������Measure_Delta_Clear=1�����Ϊ���ڵĲ���ֵ��Ϊ�գ�
                begin
                    Measure_Delta_Cnt<=0;      //���ڼ��������ʼ����ֵ0
                    Delta_Clear_Flag<=1;           //��������־��ʼ����ֵ1
                end
            else                            //���������ֶ�������ʱ�� ��RST=1������Measure_Delta_Clear=0�����Ϊ���ڵĲ���ֵΪ�գ�
                begin
                    Measure_Delta_Cnt<=Measure_Delta_Cnt+1;       //���ڼ�������Զ�+1
                    Delta_Clear_Flag<=0;                          //��������־��ʼ����ֵ0             
                end 
            end
            
    //Pulse count �������
    always@(posedge Signal_Pulse or negedge Rst or posedge Delta_Clear_Flag)  //�������������������ػ���RST�½��ػ��߼�������־�����ص�ʱ��ִ������
        begin
 //Low level reset �͵�ƽ��λ
            if(!Rst)                      //���Rst=0
                begin
                    Measure_Num_Cnt<=0;         //���������ֵ0
                    Measure_Delta_Clear<=0;      //���ڵĲ���ֵ�յ�
                    Measure_Cnt<=0;               //����������ֵ0
                    Period<=0;                      //Periodʱ�䣿���� ��ֵ0
                end 
 //Cleared if cleared
        else if(Delta_Clear_Flag)            //���RST=1�Ҽ�������־=1
            Measure_Delta_Clear<=0;            //���ڵĲ���ֵ�յ�
        else                                    //���RST=1�Ҽ�������־=0
            begin
                if(Measure_Num_Cnt==Measure_Num-1) //���RST=1�Ҽ�������־=0���������������=5-1=4
                    begin
                        if(Measure_Cnt<200)     //���RST=1�Ҽ�������־=0���������=4�����Ҳ�������<200
                            Period<=1;          //��ֵ
                        else if(Measure_Cnt>1000000)    //�����������>1000000
                            Period<=5000;           //��ֵ
                        else                        //�������������200~1000000
                            Period<=Measure_Cnt/200;      //��ֵ=��������/200
                        Measure_Num_Cnt<=0;            //�������=0
                        Measure_Delta_Clear<=1;          //���ڵĲ���ֵ���գ�
                        Measure_Cnt<=0;                 //��������=0
                    end                    
                else            //���RST=1�Ҽ�������־=0�����������������Ϊ4
                    begin
                        Measure_Num_Cnt<=Measure_Num_Cnt+1;            //��������Զ�+1
                        Measure_Cnt<=Measure_Cnt+Measure_Delta_Cnt;       //��������=��������+���ڼ������
                    end
            end
        end
endmodule
