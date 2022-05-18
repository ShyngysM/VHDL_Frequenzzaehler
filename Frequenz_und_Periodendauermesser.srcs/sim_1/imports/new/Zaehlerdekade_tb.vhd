----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2022 16:57:49
-- Design Name: 
-- Module Name: Zaehlerdekade_tb - Behavioral
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

entity Zaehlerdekade_tb is
--  Port ( );
end Zaehlerdekade_tb;

architecture Behavioral of Zaehlerdekade_tb is
component Zaehlerdekade is
    Port ( res : in STD_LOGIC;
           en : in STD_LOGIC;
           clk : in std_logic;
           x : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (3 downto 0);
           overflow : out STD_LOGIC);
end component;

signal clk : std_logic := '0';
signal res : std_logic := '0';
signal en : std_logic := '1';
signal x : std_logic;
signal y : std_logic_vector(3 downto 0);
signal overflow : std_logic;

begin
 test: Zaehlerdekade Port map(res=>res, en=>en, x=>x, y=>y, overflow=>overflow, clk => clk);

 clk <= not clk after 5ns;
 en <= '0' after 25ms;
 res <= '1' after 26ms;
-- en <= '1' after 27ms;
-- res <= '0' after 28ms;

 process begin
    x<='0';
    wait for 1ms;
    x<='1';
    wait for 10ns;
 end process;

end Behavioral;