最初拟用实验指导计划书中实验十三单综示波器代码为框架，自己编写波形显示模块，ADC驱动模块，频率计算模块等等，
但是编译成功之后遇到了提示有部分引脚未接收到有效时钟信号的Critical warning，在接到电视显示屏验证时候没有出现预想中的图像。
无法确定是程序错误导致还是HDMI转MINI HDMI线的问题
查阅手册资料修改无果后询问精通这方面的同学，听取对方建议，调用现成的外部ADC-IP和DAC-IP以及URAT-IP,省去自己编写
驱动模块带来的不确定错误，用UART发送到电脑进行串口监视，得以验证实验结果
