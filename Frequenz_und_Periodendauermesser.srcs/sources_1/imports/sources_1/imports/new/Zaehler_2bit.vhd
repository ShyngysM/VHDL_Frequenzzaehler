----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2021 15:12:39
-- Design Name: 
-- Module Name: Zaehler_2bit - Behavioral
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

entity Zaehler_2bit is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (1 downto 0));
end Zaehler_2bit;

architecture Behavioral of Zaehler_2bit is

signal tempY: STD_LOGIC_VECTOR (1 downto 0) := "00";

begin
process(clk) begin
    if rising_edge(clk) AND en = '1' then
            if tempY = "00" then tempY <= "01"; 
            elsif tempY = "01" then tempY <= "10"; 
            elsif tempY = "10" then tempY <= "11"; 
              else tempY <= "00";
        end if;
     end if;
end process;

y <= tempY;

end Behavioral;
