----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2022 02:56:05 PM
-- Design Name: 
-- Module Name: Automat_T - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Visualisierung dieses Automates siehe Kapitel 2.4

-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Automat_T is
    port (x_in, en, clk  : in STD_LOGIC;    --Eingänge:  x_in - Messsignal, en - Automat starten, clk - Takt;
          res, we_ram, count_en : out STD_LOGIC);   --Ausgänge: res - resetet der Zählstand einer Zählerdekade, we_ram - Speicher schreiben, count_en - Zähler starten;
end Automat_T;

architecture Behavioral of Automat_T is
    type state_type is (AUS, RES_AN, COUNT_AN, RAM_WE );    --Zustände dieses Automates
    signal state : state_type; 
    signal new_state : state_type;  --Hilfsstate

    component Sync_mit_FlankEr is
        Port ( async_sig : in std_logic;
               clk       : in std_logic;
               rise      : out std_logic);
    end component;
    signal rise : std_logic;
begin
    FlErk: Sync_mit_FlankEr Port map (async_sig => x_in, clk => clk, rise => rise );    --Flankenerkennung mit Einsynchonisation für asynchrone Signale
    
    -- Zustandspeicher, übernimmt new_state bei steigender Flanke Takt
    p1: process (clk, en)	
    begin
        if en = '0' then 	-- asynchroner Reset
            state <= AUS; 
        elsif rising_edge(clk) then
            state <= new_state;
        end if;
    end process p1;
    
    -- next state Logik, bestimmt mittels Logik nächsten Zustand des Systems 
    p2: process(state, en, rise)	
    begin
        case state is
            when AUS  => 
                if en = '1' then
                    new_state <= RES_AN;
                else
                    new_state <= AUS;
                end if;

            when RES_AN  => 
                if rise = '1' then
                    new_state <= COUNT_AN;
                else
                    new_state <= RES_AN;
                end if;

            when COUNT_AN => 
                if rise = '1' then 
                    new_state <= RAM_WE;
                else 
                    new_state <= COUNT_AN; 
                end if;
    
            when RAM_WE =>
                new_state <= RES_AN;
                
        end case;
    end process;
    
    -- Ausgangslogik
    p3 : process (state)
    begin
        case state is
            when AUS => 
                res <= '1'; 
                we_ram <= '0';
                count_en <= '0';

            when RES_AN  => 
                res <= '1';
                we_ram <= '0';
                count_en <= '0';

            when COUNT_AN => 
                count_en <= '1';
                we_ram <= '0';
                res <= '0';

            when RAM_WE =>
                we_ram <= '1';
                res <= '0';
                count_en <= '0';
        end case;
    end process;

end Behavioral;
