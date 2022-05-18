----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2022 17:35:49
-- Design Name: 
-- Module Name: Dekaden_Kombination - Behavioral
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

entity Dekaden_Kombination is
  Port (    clk : in std_logic;                         --Taktsignal                   
            x : in std_logic;                           --Eingang fuer das zu messende Signal bei der Frequenzmessung, bei der Periodendauermessung agiert x eher als extra Enable (ist nicht nur einen Takt lang an, also werden rising edge von clk gezählt) 
            res : in std_logic;                         --reset fuer die 4 Zaehlerdekaden
            en : in std_logic;                          --Enable
            mb_ovf : out STD_LOGIC;                     --Messbereich Overflow
            dek0_y : out std_logic_vector(3 downto 0);  --Ausgaenge fuer den Zaehlstand der 4 Dekaden
            dek1_y : out std_logic_vector(3 downto 0);
            dek2_y : out std_logic_vector(3 downto 0);
            dek3_y : out std_logic_vector(3 downto 0)
            );
end Dekaden_Kombination;

architecture Behavioral of Dekaden_Kombination is

--Dekade die von 0-9 zaehlt; sendet overflow=1 bei 9 und resetet dann wieder auf 0
component Zaehlerdekade is
    Port ( res : in STD_LOGIC;
           en : in STD_LOGIC;
           clk : in std_logic;
           x : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (3 downto 0);
           overflow : out STD_LOGIC);
end component;

--Signale fuer die 4 Zaehlerdekaden
signal temp_dek0_y: std_logic_vector(3 downto 0);
signal temp_dek1_y: std_logic_vector(3 downto 0);
signal temp_dek2_y: std_logic_vector(3 downto 0);
signal temp_dek3_y: std_logic_vector(3 downto 0);
signal dek0_ovf: std_logic;
signal dek1_ovf: std_logic;
signal dek2_ovf: std_logic;
signal dek3_ovf: std_logic;
signal dek1_en: std_logic;
signal dek2_en: std_logic;
signal dek3_en: std_logic;

--===================================================================

begin

 Dekade0 : Zaehlerdekade Port map(res=>res, en=>en, x=>x, y=>temp_dek0_y, overflow => dek0_ovf, clk=>clk);
 Dekade1 : Zaehlerdekade Port map(res=>res, en=>dek1_en, x=>x, y=>temp_dek1_y, overflow => dek1_ovf, clk=>clk);
 Dekade2 : Zaehlerdekade Port map(res=>res, en=>dek2_en, x=>x, y=>temp_dek2_y, overflow => dek2_ovf, clk=>clk);
 Dekade3 : Zaehlerdekade Port map(res=>res, en=>dek3_en, x=>x, y=>temp_dek3_y, overflow => dek3_ovf, clk=>clk);

--Logik fuer das weiterzaehlen in der jeweils naechsten Dekade
 dek1_en <= dek0_ovf and en;
 dek2_en <= dek1_ovf and dek0_ovf and en;
 dek3_en <= dek2_ovf and dek1_ovf and dek0_ovf and en;
 
 --Logik fuer Messbereich-Overflow(leuchtet, wenn von allen Dekaden der Overflow = '1' ist) 
 mb_ovf <= dek0_ovf and dek1_ovf and dek2_ovf and dek3_ovf;
 
 
 --weiterleitung der Signale an den Ausgang
 dek0_y <= temp_dek0_y;
 dek1_y <= temp_dek1_y;
 dek2_y <= temp_dek2_y;
 dek3_y <= temp_dek3_y;
 

end Behavioral;
