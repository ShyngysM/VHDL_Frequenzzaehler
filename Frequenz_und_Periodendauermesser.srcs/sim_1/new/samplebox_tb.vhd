----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2022 18:18:43
-- Design Name: 
-- Module Name: samplebox_tb - Behavioral
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

entity samplebox_tb is
--  Port ( );
end samplebox_tb;


architecture Behavioral of samplebox_tb is
    
    component samplebox is
    Port ( clk, en, x, einheit  : in STD_LOGIC;
           y, reset, we_speicher : out STD_LOGIC);
end component;
        
    signal clk: std_logic := '0';
    signal x: std_logic := '0';
    signal einheit : std_logic := '1';
    signal en, y, reset, we_speicher: std_logic;

begin
test: samplebox port map (clk => clk, en => en, x => x, y => y, reset => reset, we_speicher => we_speicher, einheit => einheit);

    en <= '1';
    clk <= not clk after 5ns; -- symm. Takt, 100MHz
    x <= not x after 500ns; 


end Behavioral;