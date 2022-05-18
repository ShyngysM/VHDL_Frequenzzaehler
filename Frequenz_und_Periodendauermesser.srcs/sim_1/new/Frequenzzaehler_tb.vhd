----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.02.2022 15:35:06
-- Design Name: 
-- Module Name: Frequenzzaehler_tb - Behavioral
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

entity Frequenzzaehler_tb is
--  Port ( );
end Frequenzzaehler_tb;

architecture Behavioral of Frequenzzaehler_tb is
component Frequenzzaehler_Hz is
 Port (clk, en, x_mess, einheit  : in STD_LOGIC; 
            seg : out STD_LOGIC_VECTOR (6 downto 0);--Zahl die Angezeigt wird
            an : out STD_LOGIC_VECTOR (3 downto 0);
            mb_ovf : out STD_LOGIC;                  --Messbereich Overflow
            d0out_sp_test: out std_logic_vector (3 downto 0);
            d1out_sp_test: out std_logic_vector (3 downto 0);
            d2out_sp_test: out std_logic_vector (3 downto 0);
            d3out_sp_test: out std_logic_vector (3 downto 0);
            res_Anzeige_test: out std_logic;
            we_Anzeige_test: out std_logic
            );
end component;

signal en, einheit: std_logic := '1';
signal x_mess: std_logic:='0';
signal clk: std_logic:='0';
signal mb_ovf: std_logic :='0';
signal d0out_sp_test: std_logic_vector (3 downto 0);
signal d1out_sp_test: std_logic_vector (3 downto 0);
signal d2out_sp_test: std_logic_vector (3 downto 0);
signal d3out_sp_test: std_logic_vector (3 downto 0);
signal res_Anzeige_test: std_logic ;
signal we_Anzeige_test: std_logic ;

begin
test: Frequenzzaehler_Hz Port map(einheit => einheit, en => en, clk=>clk, x_mess=>x_mess, mb_ovf => mb_ovf,
         d0out_sp_test => d0out_sp_test, d1out_sp_test => d1out_sp_test, d2out_sp_test => d2out_sp_test, d3out_sp_test => d3out_sp_test, res_Anzeige_test => res_Anzeige_test, we_Anzeige_test => we_Anzeige_test);
    
    clk <= not clk after 5ns; -- symm. Takt, 100MHz
    x_mess <= not x_mess after 0.04ms;



end Behavioral;
