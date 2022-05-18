----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.02.2022 17:26:15
-- Design Name: 
-- Module Name: Sync_mit_FlankEr_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sync_mit_FlankEr_tb is
--  Port ( );
end Sync_mit_FlankEr_tb;

architecture Behavioral of Sync_mit_FlankEr_tb is
    component Sync_mit_FlankEr is
        Port ( async_sig : in std_logic;
               clk       : in std_logic;
               rise      : out std_logic;
               fall      : out std_logic);
    end component;
    
signal async_sig: std_logic :='0';
signal clk: std_logic :='0';
signal rise: std_logic;
signal fall: std_logic;

begin
 test: Sync_mit_FlankEr Port map(async_sig=>async_sig, clk=>clk, rise=>rise, fall=>fall);
 --empfohlene simulate.runtime >1ms
 --Ziel der Simulation: async_sig wechselt alle 0.5ms, wenn das Signal von 0 auf 1 wechselt soll rise einen Takt lang 1 sein, Signal von 1 auf 0: fall ist einen Takt lang 1
    clk <= not clk after 5ns; --alternierendes Taktsignal
    async_sig <= not async_sig after 0.5ms; --alternierendes Messsignal (soll eine Taktfrequenz von 1kHz darstellen)
end Behavioral;
