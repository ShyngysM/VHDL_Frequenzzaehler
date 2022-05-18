----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2021 13:13:25
-- Design Name: 
-- Module Name: Vorteiler - Behavioral
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

entity Vorteiler is
    Port ( clk : in STD_LOGIC;
           y : out STD_LOGIC := '0');
end Vorteiler;

architecture Behavioral of Vorteiler is

begin

process (clk)
 variable cnt : integer range 0 to 1000 := 0;
begin
 if rising_edge(clk) then
  if cnt = 999 then
        cnt := 0;
        y <= '1';
  else
        cnt := cnt + 1;
        y <= '0';
  end if;
 end if;
end process;


end Behavioral;
