----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.03.2022 18:10:37
-- Design Name: 
-- Module Name: Periodendauermesser - Behavioral
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

entity Periodendauermesser is
  Port (    clk, en, x_mess, einheit  : in STD_LOGIC; 
            seg : out STD_LOGIC_VECTOR (6 downto 0);--Zahl die Angezeigt wird
            an : out STD_LOGIC_VECTOR (3 downto 0);
            mb_ovf : out STD_LOGIC;                  --Messbereich Overflow
            d0out_sp_test: out std_logic_vector (3 downto 0);
            d1out_sp_test: out std_logic_vector (3 downto 0);
            d2out_sp_test: out std_logic_vector (3 downto 0);
            d3out_sp_test: out std_logic_vector (3 downto 0)
            );
end Periodendauermesser;


architecture Behavioral of Periodendauermesser is
    component Zaehleranzeige is
        Port (  clk : in STD_LOGIC;                     --Taktsignal
                x_mess : in std_logic;                  --Eingang fuer das zu messende Signal
                res : in std_logic;                     --reset fuer die 4 Zaehlerdekaden
                en : in std_logic;                      --enable fuer das Anzeigen Gesamtkonstrukt
                we_speicher : in std_logic;             --Eingang fuer das Ansteuern des write enable des Speichers durch den Automaten
                seg : out STD_LOGIC_VECTOR (6 downto 0);--Zahl die Angezeigt wird
                an : out STD_LOGIC_VECTOR (3 downto 0); --Stelle, wo die Zahl angezeigt wird
                mb_ovf : out STD_LOGIC ;                 --Messbereich Overflow
                dek_clk : in std_logic;
                d0out_sp_test: out std_logic_vector (3 downto 0);
                d1out_sp_test: out std_logic_vector (3 downto 0);
                d2out_sp_test: out std_logic_vector (3 downto 0);
                d3out_sp_test: out std_logic_vector (3 downto 0)
                );
    end component;
    --
    component Automat_T is
        port (  x_in, en, clk  : in STD_LOGIC;
                res, we_ram, count_en : out STD_LOGIC);
    end component;
    signal temp_count_en, temp_reset, temp_we: std_logic;
    --
    component prescaler_100us is
        Port (  clk, en : in STD_LOGIC;
                y   : out STD_LOGIC
                );
    end component;
    signal temp_presc_100us_y : std_logic;
    
    component prescaler_1ms is
        Port (  clk, en : in STD_LOGIC;
                y   : out STD_LOGIC
                );
    end component;
    signal temp_presc_1ms_y : std_logic;
    
    signal temp_dek_vt : std_logic;
begin

Automat_s: Automat_T port map(x_in => x_mess, en => en, clk => clk, res => temp_reset, we_ram => temp_we, count_en => temp_count_en);
zaehleranzeige_PDM: Zaehleranzeige port map (x_mess => temp_count_en, en => en, res => temp_reset, seg => seg, an => an, clk => clk, dek_clk => temp_dek_vt, we_speicher => temp_we, mb_ovf => mb_ovf, d0out_sp_test => d0out_sp_test, d1out_sp_test => d1out_sp_test, d2out_sp_test => d2out_sp_test, d3out_sp_test => d3out_sp_test);

presc_100us: prescaler_100us Port map(clk => clk, en => en, y => temp_presc_100us_y);
presc_1ms: prescaler_1ms Port map(clk => clk, en => en, y => temp_presc_1ms_y);

--einheit = '0' z�hlt wegen den Prescalern in einem Bereich von 000.1ms(100us) bis 999.9ms und bei '1' von 1ms bis 9999ms(10s)
--die Punkte werden auf der Anzeige nicht angezeigt
 with einheit select temp_dek_vt <=
        temp_presc_100us_y when '0',
        temp_presc_1ms_y when others;


end Behavioral;
