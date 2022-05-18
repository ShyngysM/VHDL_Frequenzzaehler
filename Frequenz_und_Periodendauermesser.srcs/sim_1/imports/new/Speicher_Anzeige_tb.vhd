----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2022 14:26:00
-- Design Name: 
-- Module Name: Speicher_Anzeige_tb - Behavioral
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

entity Speicher_Anzeige_tb is
--  Port ( );
end Speicher_Anzeige_tb;

architecture Behavioral of Speicher_Anzeige_tb is
component Speicher_Anzeige is
    Port ( clk : in STD_LOGIC;
		   we : in STD_LOGIC; --write_enable
		   d0in : in STD_LOGIC_VECTOR (3 downto 0);
		   d1in : in STD_LOGIC_VECTOR (3 downto 0);
		   d2in : in STD_LOGIC_VECTOR (3 downto 0);
		   d3in : in STD_LOGIC_VECTOR (3 downto 0);
           d0out : out STD_LOGIC_VECTOR (3 downto 0);
		   d1out : out STD_LOGIC_VECTOR (3 downto 0);
		   d2out : out STD_LOGIC_VECTOR (3 downto 0);
		   d3out : out STD_LOGIC_VECTOR (3 downto 0));
end component;


signal clk : STD_LOGIC;
signal we : STD_LOGIC; --write_enable
signal d0in : STD_LOGIC_VECTOR (3 downto 0);
signal d1in : STD_LOGIC_VECTOR (3 downto 0);
signal d2in : STD_LOGIC_VECTOR (3 downto 0);
signal d3in : STD_LOGIC_VECTOR (3 downto 0);
signal d0out : STD_LOGIC_VECTOR (3 downto 0);
signal d1out : STD_LOGIC_VECTOR (3 downto 0);
signal d2out : STD_LOGIC_VECTOR (3 downto 0);
signal d3out : STD_LOGIC_VECTOR (3 downto 0);

begin
test: Speicher_Anzeige Port Map(clk=>clk, we=>we,  d0in=>d0in, d1in=>d1in, d2in=>d2in, d3in=>d3in, d0out=>d0out, d1out=>d1out, d2out=>d2out, d3out=>d3out);

process begin
   
    d0in <= "0001";
    d1in <= "0010";
    d2in <= "0011";
    d3in <= "0100";
    we <= '1';
    
    clk <= '1';
    wait for 5ns;
    clk <= '0';
    wait for 5ns;


   
    we <= '0';
    d0in <= "1111";
    d1in <= "1110";
    d2in <= "1101";
    d3in <= "1100";
    
    clk <= '1';
    wait for 5ns;
    clk <= '0';
    wait for 5ns;
    
    we <= '1';
    clk <= '1';
    wait for 5ns;
    clk <= '0';
    wait for 5ns;
    
end process;
end Behavioral;
