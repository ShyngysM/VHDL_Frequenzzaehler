----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2022 17:54:19
-- Design Name: 
-- Module Name: Dekaden_Kombination_tb - Behavioral
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

entity Dekaden_Kombination_tb is
--  Port ( );
end Dekaden_Kombination_tb;

architecture Behavioral of Dekaden_Kombination_tb is

component Dekaden_Kombination is
  Port (    clk : in STD_LOGIC;                     --Taktsignal
            x : in std_logic;                       --Eingang für das zu messende Signal
            res : in std_logic;                     --reset für die 4 Zählerdekaden
            en : in std_logic;                      --Enable
            mb_ovf : out STD_LOGIC;                 --Messbereich Overflow
            dek0_y : out std_logic_vector(3 downto 0);
            dek1_y : out std_logic_vector(3 downto 0);
            dek2_y : out std_logic_vector(3 downto 0);
            dek3_y : out std_logic_vector(3 downto 0)
            );
end component;
 
signal clk : STD_LOGIC := '0';                   
signal x : std_logic := '0';                  
signal res : std_logic := '0';                  
signal en : std_logic := '1';                     
signal mb_ovf : STD_LOGIC;                  
signal dek0_y : std_logic_vector(3 downto 0);
signal dek1_y : std_logic_vector(3 downto 0);
signal dek2_y : std_logic_vector(3 downto 0);
signal dek3_y : std_logic_vector(3 downto 0);


begin
test: Dekaden_Kombination Port map(clk=>clk, x=>x, res=>res, en=>en, mb_ovf=>mb_ovf, dek0_y=>dek0_y, dek1_y=>dek1_y, dek2_y=>dek2_y, dek3_y=>dek3_y);

--Stimuli für das Zählen von Frequenz (simulierte rising Edge die ankommt)
    clk <= not clk after 5ns;
    en <= '0' after 100000ns;
    --res <= '1' after 200000ns;
    process begin
        x<='0';
        wait for 100ns;
        x<='1';
        wait for 10ns;
     end process;
     
 
--Stimuli für Periodendauermessung (bei Benutzung die anderen auskommentieren)
    -- clk <= not clk after 100ns; --Vorgeteiltes APPEND_MODE
    -- x <= not x after 10000ns;  --Simuliert die Dauer zwischen zwei steigenden Flanken
 
end Behavioral;
