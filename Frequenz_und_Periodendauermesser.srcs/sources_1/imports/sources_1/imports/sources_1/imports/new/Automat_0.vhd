library IEEE;

use IEEE.std_logic_1164.all;


-- Finite State Machine 
-- Ablaufssteuerung eines Frequenzz�hlers
-- mit nur einem Prozess
entity Automat_f is
  port (clk, presc_fin, en: in STD_LOGIC;
        reset, presc_en, we_speicher, tor_offen : out  STD_LOGIC);
end entity;

architecture Behavioral of Automat_f is
  type state_type is (Reset_an, Reset_aus, Tor_auf, Uebernahme, Uebernommen);
  signal state : state_type := Reset_an;    -- unsere Statevariable 


begin
  -- Prozess wird bei jedem Takt und bei Reset abgearbeitet
  process (clk, presc_fin)
  begin
      if rising_edge(clk) then
        if en = '1' then
          case state is
            when Reset_an => 
              reset <= '1'; 
              state <= Reset_aus;
            when Reset_aus => 
              reset <= '0'; 
              state <= Tor_auf;   
            when Tor_auf  => 
              presc_en <= '1';
              tor_offen <='1'; 
              if presc_fin = '1' then
                    tor_offen <= '0';
                    presc_en <= '0'; 
                    state <= Uebernahme;
              else
                    state <= Tor_auf;
              end if;

            when Uebernahme =>
              we_speicher <= '1';
              state <= Uebernommen;
            when Uebernommen => 
              we_speicher <= '0';
              state <= Reset_an;
          end case;
        end if;
     end if;
  end process;
  
end Behavioral;
