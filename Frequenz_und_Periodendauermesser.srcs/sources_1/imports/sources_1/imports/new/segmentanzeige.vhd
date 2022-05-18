----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.11.2021 15:26:47
-- Design Name: 
-- Module Name: segmentanzeige - Behavioral
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

entity segmentanzeige is
    Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end segmentanzeige;

architecture Behavioral of segmentanzeige is

begin

seg <=   "0111111" when x = "0000" else
         "0000110" when x = "0001" else
         "1011011" when x = "0010" else
         "1001111" when x = "0011" else
         "1100110" when x = "0100" else
         "1101101" when x = "0101" else
         "1111101" when x = "0110" else  
         "0000111" when x = "0111" else
         "1111111" when x = "1000" else
         "1101111" when x = "1001" else
         "1110111" when x = "1010" else
         "1111100" when x = "1011" else
         "0111001" when x = "1100" else
         "1011110" when x = "1101" else
         "1111001" when x = "1110" else
         "1110001";

end Behavioral;
