----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2022 02:56:05 PM
-- Design Name: 
-- Module Name: Automat_f - Behavioral
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

entity Automat_f is
    port (clk, presc_fin, en: in STD_LOGIC; -- presc_fin liest Ausgang eines Vorteilers
            reset, presc_en, we_speicher, tor_offen : out  STD_LOGIC);   --Ausgänge: reset - resetet der Zählstand einer Zählerdekade, we_speicher - Speicher schreiben, presc_en - Vorteiler starten, tor_offen - Tor öffnen;
end Automat_f;

architecture Behavioral of Automat_f is
    type state_type is (RES_AN, TOR_AN, RAM_WE ); --Zustände dieses Automates
    signal state : state_type;
    signal new_state : state_type; --Hilfsstate

    
begin
    
    -- Zustandspeicher, übernimmt new_state bei steigender Flanke Takt
    p1: process (clk, en)	
    begin
        if en = '0' then 	-- asynchroner Reset
            state <= RES_AN; 
        elsif rising_edge(clk) then
            state <= new_state;
        end if;
    end process p1;
    
    -- next state Logik, bestimmt mittels Logik nächsten Zustand des Systems 
    p2: process(state, en, presc_fin)	
    begin
        case state is

            when RES_AN  => 
                if en = '1' then
                    new_state <= TOR_AN;
                else
                    new_state <= RES_AN;
                end if;

            when TOR_AN => 
                if presc_fin = '1' then 
                    new_state <= RAM_WE;
                else 
                    new_state <= TOR_AN; 
                end if;
    
            when RAM_WE =>
                new_state <= RES_AN;
                
        end case;
    end process;
    
    -- Ausgangslogik
    p3 : process (state)
    begin
        case state is

            when RES_AN  => 
                reset <= '1'; 
                presc_en <= '0';
                tor_offen <= '0';
                we_speicher <= '0'; 

            when TOR_AN =>
                reset <= '0'; 
                presc_en <= '1';
                tor_offen <= '1';
                we_speicher <= '0';

            when RAM_WE =>
                reset <= '0'; 
                presc_en <= '0';
                tor_offen <= '0';
                we_speicher <= '1';
        end case;
    end process;

end Behavioral;
