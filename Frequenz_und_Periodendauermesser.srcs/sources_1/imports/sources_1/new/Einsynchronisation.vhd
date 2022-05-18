----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Shyngys Muratbek 
-- 
-- Create Date: 02/22/2022 05:54:12 PM
-- Design Name: 
-- Module Name: Sinc - Behavioral
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

entity Einsynchronisation is
 Port (clk, x: in std_logic;
        y: out std_logic );
end Einsynchronisation;

architecture Behavioral of Einsynchronisation is

signal signal_last: std_logic;
signal asyn: std_logic;


begin

    process(clk) begin
      if rising_edge(clk) then
        asyn <= x;
        signal_last <= asyn;
      end if;
    end process;

    y <= signal_last;

end Behavioral;
