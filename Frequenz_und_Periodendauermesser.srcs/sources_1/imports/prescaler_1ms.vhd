----------------------------------------------------------------------------------
-- Company: HSMW
-- Engineer: Shyngys Muratbek
-- 
-- Create Date: 01/08/2022 05:39:04 PM
-- Design Name: Simple_S
-- Module Name: prescaler_Hz - Behavioral
-- Project Name: frequenzzaehler
-- Target Devices: Basys 3
-- Tool Versions: 
-- Description: Prescaler input kHz output Hz
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Bad name but lazy to change
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prescaler_1ms is
    Port ( 
        clk, en : in STD_LOGIC;
        y   : out STD_LOGIC := '0'
    );
end prescaler_1ms;

architecture Behavioral of prescaler_1ms is

begin

process (clk)
 variable cnt : integer range 0 to 100000 := 0;
begin
 if rising_edge(clk) then
  if cnt = 99999 then
        cnt := 0;
        y <= '1';
  else
        cnt := cnt + 1;
        y <= '0';
  end if;
 end if;
end process;


end Behavioral;
