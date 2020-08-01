-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Fri Jul 31 22:23:10 2020
-- Host        : DESKTOP-6MI8UE8 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/2018.3/vivado_program/oscilloscope/oscilloscope.srcs/sources_1/ip/Driver_UART_0/Driver_UART_0_stub.vhdl
-- Design      : Driver_UART_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7s15ftgb196-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Driver_UART_0 is
  Port ( 
    clk_100MHz : in STD_LOGIC;
    Rst : in STD_LOGIC;
    En_Rx : in STD_LOGIC;
    En_Tx : in STD_LOGIC;
    Baud_Rate : in STD_LOGIC_VECTOR ( 30 downto 0 );
    Rx : in STD_LOGIC;
    Tx_Data : in STD_LOGIC_VECTOR ( 7 downto 0 );
    Tx : out STD_LOGIC;
    Rx_Data : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Rx_ACK : out STD_LOGIC;
    Tx_ACK : out STD_LOGIC
  );

end Driver_UART_0;

architecture stub of Driver_UART_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_100MHz,Rst,En_Rx,En_Tx,Baud_Rate[30:0],Rx,Tx_Data[7:0],Tx,Rx_Data[7:0],Rx_ACK,Tx_ACK";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "Driver_UART,Vivado 2018.3";
begin
end;
