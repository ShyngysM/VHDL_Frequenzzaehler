----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2022 15:55:31
-- Design Name: 
-- Module Name: prescaler_100us - Behavioral
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

entity prescaler_100us is
    Port ( 
        clk, en : in STD_LOGIC;
        y   : out STD_LOGIC := '0'
    );
end prescaler_100us;

architecture Behavioral of prescaler_100us is

begin

process (clk)
 variable cnt : integer range 0 to 10000 := 0;
begin
 if rising_edge(clk) then
  if cnt = 9999 then
        cnt := 0;
        y <= '1';
  else
        cnt := cnt + 1;
        y <= '0';
  end if;
 end if;
end process;


end Behavioral;