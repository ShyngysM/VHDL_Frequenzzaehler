----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2022 07:18:16 PM
-- Design Name: 
-- Module Name: FrequenzzaehlerBeta - Behavioral
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

entity Frequenzzaehler_Hz is
 Port (clk, en, x_mess, einheit  : in STD_LOGIC; 
            seg : out STD_LOGIC_VECTOR (6 downto 0);            --Zahl die Angezeigt wird
            an : out STD_LOGIC_VECTOR (3 downto 0);
            mb_ovf : out STD_LOGIC;                             --Messbereich Overflow
            d0out_sp_test: out std_logic_vector (3 downto 0);   --extra Ausgänge für Testzwecke, im finalen Design nicht verbunden
            d1out_sp_test: out std_logic_vector (3 downto 0);
            d2out_sp_test: out std_logic_vector (3 downto 0);
            d3out_sp_test: out std_logic_vector (3 downto 0);
            res_Anzeige_test: out std_logic;
            we_Anzeige_test: out std_logic
            );
end Frequenzzaehler_Hz;

architecture Behavioral of Frequenzzaehler_Hz is
    component Zaehleranzeige is
        Port (  clk : in STD_LOGIC;                     --Taktsignal
                x_mess : in std_logic;                  --Eingang fuer das zu messende Signal
                res : in std_logic;                     --reset fuer die 4 Zaehlerdekaden
                en : in std_logic;                      --enable fuer das Anzeigen Gesamtkonstrukt
                we_speicher : in std_logic;             --Eingang fuer das Ansteuern des write enable des Speichers durch den Automaten
                dek_clk : in std_logic;                 --extra Eingang für die Taktfrequenz der Dekaden; wird hier nicht benötig, da sie nicht vorgeteilt werden muss
                                                        --ist deswegen von normalen "clk" angesteuert 
                seg : out STD_LOGIC_VECTOR (6 downto 0);--Zahl die Angezeigt wird
                an : out STD_LOGIC_VECTOR (3 downto 0); --Stelle, wo die Zahl angezeigt wird
                mb_ovf : out STD_LOGIC ;                 --Messbereich Overflow
                d0out_sp_test: out std_logic_vector (3 downto 0);   
                d1out_sp_test: out std_logic_vector (3 downto 0);
                d2out_sp_test: out std_logic_vector (3 downto 0);
                d3out_sp_test: out std_logic_vector (3 downto 0)
                );
    end component;

component samplebox is
    Port ( clk, en, x, einheit  : in STD_LOGIC;
           y, reset, we_speicher : out STD_LOGIC);
end component;
signal temp_x_mess, temp_reset, temp_we: std_logic;

begin

sample_box: samplebox Port map (clk => clk, en => en, x => x_mess, y => temp_x_mess, reset => temp_reset, we_speicher => temp_we, einheit => einheit);

zaehleranzeige_Hz: Zaehleranzeige port map (x_mess => temp_x_mess, en => en, res => temp_reset, seg => seg, an => an, clk => clk, dek_clk => clk,  we_speicher => temp_we, mb_ovf => mb_ovf, 
            d0out_sp_test => d0out_sp_test, d1out_sp_test => d1out_sp_test, d2out_sp_test => d2out_sp_test, d3out_sp_test => d3out_sp_test);

res_Anzeige_test <= temp_reset;
we_Anzeige_test <= temp_we;

end Behavioral;