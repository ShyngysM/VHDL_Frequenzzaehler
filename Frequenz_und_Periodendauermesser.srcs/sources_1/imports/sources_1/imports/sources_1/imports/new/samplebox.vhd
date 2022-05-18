----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2022 05:23:16 PM
-- Design Name: 
-- Module Name: samplebox - Behavioral
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

entity samplebox is
    Port ( clk, en, x, einheit  : in STD_LOGIC;
           y, reset, we_speicher : out STD_LOGIC);
end samplebox;

architecture Behavioral of samplebox is

    component Zeitspannengeber_1ms is
        Port ( 
            clk, en : in STD_LOGIC;
            y   : out STD_LOGIC
        );
    end component;

    component Zeitspannengeber_1s is
        Port ( 
            clk, en : in STD_LOGIC;
            y   : out STD_LOGIC
        );
    end component;
    
    signal temp_presc_fin_s : std_logic;
    signal temp_presc_fin_ms : std_logic;
    
    component Automat_f is
        port (clk, presc_fin, en: in STD_LOGIC;
              reset, presc_en, we_speicher, tor_offen : out  STD_LOGIC);
    end component;
    
    signal temp_tor_offen: std_logic;
    signal temp_presc_fin : std_logic;
    signal temp_presc_en : std_logic;
    
    component Sync_mit_FlankEr is
        Port ( async_sig : in std_logic;
               clk       : in std_logic;
               rise      : out std_logic;
               fall      : out std_logic
               );
    end component;
    signal temp_rEdge: std_logic;
    
begin


    Automat_hz: Automat_f Port map (clk => clk, presc_fin => temp_presc_fin, reset => reset, presc_en => temp_presc_en, we_speicher => we_speicher, en => en, tor_offen => temp_tor_offen);

    Zeitgeber_1ms : Zeitspannengeber_1ms Port map (clk => clk ,en => temp_presc_en , y => temp_presc_fin_ms);
    
    Zeitgeber_1s : Zeitspannengeber_1s Port map (clk => clk ,en => temp_presc_en , y => temp_presc_fin_s);
    
    Sync_und_Flanke : Sync_mit_FlankEr Port map(clk => clk, async_sig => x, rise => temp_rEdge);

    y <= temp_rEdge and temp_tor_offen;
    
    with einheit select temp_presc_fin <=
        temp_presc_fin_s when '0',
        temp_presc_fin_ms when others;

end Behavioral;

