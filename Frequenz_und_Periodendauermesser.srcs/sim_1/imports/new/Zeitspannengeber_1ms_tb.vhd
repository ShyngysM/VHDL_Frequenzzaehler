----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2022 18:08:55
-- Design Name: 
-- Module Name: Zeitspannengeber_1ms_tb - Behavioral
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

entity Zeitspannengeber_1ms_tb is
--  Port ( );
end Zeitspannengeber_1ms_tb;

architecture Behavioral of Zeitspannengeber_1ms_tb is
component Zeitspannengeber_1ms is
    Port ( 
        clk, en : in STD_LOGIC;
        y   : out STD_LOGIC
    );
end component;
signal clk: std_logic := '0';
signal en: std_logic := '1';
signal y: std_logic;

begin
test: Zeitspannengeber_1ms Port map(clk => clk, en => en, y => y);

en <= not en after 1.1ms;
clk <= not clk after 5ns;

end Behavioral;