----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2022 05:02:13 PM
-- Design Name: 
-- Module Name: Automat_T_tb - Behavioral
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

entity Automat_T_tb is
--  Port ( );
end Automat_T_tb;

architecture Behavioral of Automat_T_tb is
    component Automat_T is
        port (en, clk, x_in  : in STD_LOGIC;
              res, we_ram, count_en : out STD_LOGIC);
    end component;
    signal res, we_ram, count_en : std_logic;
    signal x_in, en, clk: std_logic := '1';

begin
    
    clk <= not clk after 5ns;
    x_in <= not x_in after 100ns;
    -- process begin
    --     rise <= '0';
    --     wait for 200ns;
    --     rise <= '1';
    --     wait for 10ns;
    -- end process;

    sim: Automat_T Port map (en => en, clk => clk, x_in => x_in, res => res, we_ram => we_ram, count_en => count_en);


end Behavioral;
