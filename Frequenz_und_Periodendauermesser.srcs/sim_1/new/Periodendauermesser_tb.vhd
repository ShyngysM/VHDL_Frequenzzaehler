----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2022 14:26:44
-- Design Name: 
-- Module Name: Periodendauermesser_tb - Behavioral
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

entity Periodendauermesser_tb is
--  Port ( );
end Periodendauermesser_tb;

architecture Behavioral of Periodendauermesser_tb is

component Periodendauermesser is
  Port (    clk, en, x_mess, einheit  : in STD_LOGIC; 
            seg : out STD_LOGIC_VECTOR (6 downto 0);--Zahl die Angezeigt wird
            an : out STD_LOGIC_VECTOR (3 downto 0);
            mb_ovf : out STD_LOGIC;                  --Messbereich Overflow
            d0out_sp_test: out std_logic_vector (3 downto 0);
            d1out_sp_test: out std_logic_vector (3 downto 0);
            d2out_sp_test: out std_logic_vector (3 downto 0);
            d3out_sp_test: out std_logic_vector (3 downto 0)
            );
end component;
 
signal clk : std_logic := '0';
signal en : std_logic := '1';
signal x_mess : std_logic := '0';
signal einheit : std_logic := '1';  --kann auf 0 geändert werden um den Messbereich von ms in s zu ändern (lässt sich jedoch wegen der Länge der Zähldauer schlecht in der Siumlation sehen)
signal d0out_sp_test: std_logic_vector (3 downto 0);
signal d1out_sp_test: std_logic_vector (3 downto 0);
signal d2out_sp_test: std_logic_vector (3 downto 0);
signal d3out_sp_test: std_logic_vector (3 downto 0);


begin
test : Periodendauermesser Port map(clk => clk, en => en, x_mess => x_mess, einheit => einheit, d0out_sp_test => d0out_sp_test, d1out_sp_test => d1out_sp_test, d2out_sp_test => d2out_sp_test, d3out_sp_test => d3out_sp_test);

clk <= not clk after 5ns;
x_mess <= not x_mess after 2ms;


end Behavioral;
