----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2022 18:13:56
-- Design Name: 
-- Module Name: Automat_f_tb - Behavioral
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

entity Automat_f_tb is
--  Port ( );
end Automat_f_tb;

architecture Behavioral of Automat_f_tb is

component Automat_f is
  port (clk, presc_fin, en: in STD_LOGIC;
        reset, presc_en, we_speicher, tor_offen : out  STD_LOGIC);
end component;
signal clk: std_logic:= '0';
signal presc_fin: std_Logic:= '1';
signal reset, en, presc_en, we_speicher, tor_offen: std_logic;

begin
test: Automat_f Port map(clk => clk, presc_fin => presc_fin, en => en, reset => reset, presc_en => presc_en, we_speicher => we_speicher, tor_offen => tor_offen);
--Ziel der Simulation: Tor_offen ist genausolange 1 wie presc_fin, wenn presc_fin 0 ist ist tor auch 0 und der Automat sendet ein we Signal und anschlie�end ein reset Signal jeweils f�r einen Takt

en <= '1'; --standartm��ig auf 1 gestellt um eingeschalteten Automaten zu simulieren, kann manuell auf 0 gestellt werden, um den ausgeschalteten Automaten zu simulieren
clk <= not clk after 5ns; --simuliertes Taktsignal
presc_fin <= not presc_fin after 49ns; --ist in der Realit�t nicht so alternierend, da der Zeitgeber eigentlich vom Automaten gesteuert wird, durch das alternieren kann jedoch die Wartezeit des Automaten auf das Signal simuliert werden

end Behavioral;
