----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2021 14:06:28
-- Design Name: 
-- Module Name: Zaehlerdekade - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Zaehlerdekade is
    Port ( res : in STD_LOGIC;                      --Reset
           en : in STD_LOGIC;                       --Enable des Bausteins
           clk : in STD_LOGIC;                      --Taktsignal
           x : in std_logic;                        --Eingangssignal, hier im Projekt sollte es das Messsignal sein
           y : out STD_LOGIC_VECTOR (3 downto 0);   --Ausgang, enthaelt den altuellen Zaehlerstand
           overflow : out STD_LOGIC);               --ist 1, wenn der Zaehlerstand bei 9 ist
end Zaehlerdekade;

architecture Behavioral of Zaehlerdekade is

signal tempCnt : unsigned (3 downto 0) := "0000";
signal tempOvf : std_logic := '0';

begin

 process(clk, x) 
    begin
     if rising_edge(clk) then
        if res = '0' then                           --"res" steht ueber "en", damit wenn ein reset anliegt der Stand unabhaengig vom enable resettet wird (vorallem wichtig für Dekaden, die nicht immer an sind)
            if en = '1' then
                if x = '1' then                     --
                    if tempCnt = 9 then             --wenn der Zaehlstand 9 ist, wird er zurrueckgesetzt
                        tempOvf <= '0';
                        tempCnt <= "0000";
                    elsif tempCnt = 8 then          --TempCnt ist 8, damit im naechsten Takt, also wenn der Zaehlstand 9 ist auch der overflow-Ausgang '1' ist
                        tempOvf <= '1';
                        tempCnt <= tempCnt + 1;
                    else
                        tempOvf <= '0';
                        tempCnt <= tempCnt + 1;
                    end if;
                end if;
            end if;
        else
            tempOvf <= '0';     --muss hier auch noch mal auf '0' gesetzt werden, damit wenn ein reset bei Zählerstand 8 vorkommt kein unerwartetes Verhalten passiert
            tempCnt <= "0000";
        end if;
     end if;
 end process;
 
 y <= std_logic_vector(tempCnt);    --Umformung von unsigned in std_logic
 overflow <= tempOvf;
end Behavioral;
