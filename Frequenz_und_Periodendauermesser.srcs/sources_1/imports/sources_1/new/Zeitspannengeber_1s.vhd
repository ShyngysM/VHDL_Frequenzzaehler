----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2022 17:17:34
-- Design Name: 
-- Module Name: Zeitspannengeber_1s - Behavioral
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

entity Zeitspannengeber_1s is
    Port ( 
        clk, en : in STD_LOGIC;
        y   : out STD_LOGIC
    );
end Zeitspannengeber_1s;

architecture Behavioral of Zeitspannengeber_1s is

begin
    process (clk)
     variable cnt : integer range 0 to 100000000 := 0;
    begin
      if rising_edge(clk) then
        if en = '1' then
            if cnt < 99999999 then
                y <= '0';
                cnt:= cnt + 1;
            else 
                y <= '1';
            end if;
        else
            y <= '0';
            cnt := 0;
        end if;
      end if;
    end process;
       
   
end Behavioral;