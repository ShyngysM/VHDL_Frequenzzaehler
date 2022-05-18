----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2022 11:09:30 AM
-- Design Name: 
-- Module Name: Sync_mit_FlankEr - Behavioral
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

entity Sync_mit_FlankEr is
 Port ( async_sig : in std_logic;
        clk       : in std_logic;
        rise      : out std_logic;
        fall      : out std_logic);
end Sync_mit_FlankEr;

architecture Behavioral of Sync_mit_FlankEr is
-- signal temp_clk_board: std_logic;
-- signal rise, fall: std_logic;
begin

    process(clk, async_sig)
      variable sr : std_logic_vector (3 downto 0) := "0000";
    begin
      if rising_edge(clk) then
        -- Flanken erkennen
        rise <= not sr(3) and sr(2);
        fall <= not sr(2) and sr(3);
        -- Eingang in Schieberegister einlesen
        sr := sr(2 downto 0) & async_sig;
      end if;
    end process; 
end Behavioral;

