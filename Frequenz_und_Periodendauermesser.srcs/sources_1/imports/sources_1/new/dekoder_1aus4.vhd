----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.10.2016 10:20:40
-- Design Name: 
-- Module Name: 1aus4_dekoder - Behavioral
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

entity dekoder_1aus4 is
    Port ( y : out STD_LOGIC_VECTOR (3 downto 0);
           x : in STD_LOGIC_VECTOR (1 downto 0));
end dekoder_1aus4;

architecture Behavioral of dekoder_1aus4 is

begin

  y(0) <= not x(0) and not x(1);
  y(1) <=     x(0) and not x(1);
  y(2) <= not x(0) and     x(1);
  y(3) <=     x(0) and     x(1);
    
end Behavioral;
