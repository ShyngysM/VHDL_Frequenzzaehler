----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2022 01:26:53 PM
-- Design Name: 
-- Module Name: Einsynchronisation_tb - Behavioral
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

entity Einsynchronisation_tb is
--  Port ( );
end Einsynchronisation_tb;

architecture Behavioral of Einsynchronisation_tb is
    component Einsynchronisation is
        Port (clk, x: in std_logic;
               y: out std_logic );
       end component;
    signal clk : std_logic := '1';
    signal x : std_logic := '0';
    signal y : std_logic;
begin

    einsync: Einsynchronisation Port map (clk => clk, x => x, y => y);

    clk <= not clk after 5ns;
    x <= not x after 103ns;

end Behavioral;
