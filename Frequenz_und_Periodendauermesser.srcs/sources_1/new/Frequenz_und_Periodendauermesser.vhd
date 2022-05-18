----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.02.2022 16:14:19
-- Design Name: 
-- Module Name: Frequenz_und_Periodendauermesser - Behavioral
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

entity Frequenz_und_Periodendauermesser is
  Port (    clk : in STD_LOGIC;     --Taktsignal
            x_mess : in std_logic;  --zu messendes Eingangssignal
            einheit : in std_logic; --der Schalter für die Auswahl der Zeitbasis
            modus : in std_logic;   --der Schalter für die Auswahl, welcher Modus und welches Ergebniss angezeigt werden
            
            seg : out STD_LOGIC_VECTOR (6 downto 0);--Zahl die Angezeigt wird
            an : out STD_LOGIC_VECTOR (3 downto 0); --Welche der 3 Anoden die Information von seg bekommt
            mb_ovf : out STD_LOGIC                  --Messbereich Overflow
            );
end Frequenz_und_Periodendauermesser;

architecture Behavioral of Frequenz_und_Periodendauermesser is
--Baustein für die Einsynchronisation der beiden Auswahlschalter, das Eingangssignal ist nicht mit diesem Baustein verbunden, da
--  die Synchronisierung von dieser bereits in Sync_mit_FlErk geschieht
component Einsynchronisation is
 Port (clk, x: in std_logic;
        y: out std_logic );
end component;
--Signale, welche am "en" der Hauptbestandteile ankommt
signal einheit_sync: std_logic;
signal modus_sync: std_logic;

component Frequenzzaehler_Hz is
 Port (     clk, en, x_mess, einheit  : in STD_LOGIC; 
            seg : out STD_LOGIC_VECTOR (6 downto 0);--Zahl die angezeigt wird
            an : out STD_LOGIC_VECTOR (3 downto 0);
            mb_ovf : out STD_LOGIC                  --Messbereich Overflow
            );
end component;

component Periodendauermesser is
  Port (    clk, en, x_mess, einheit  : in STD_LOGIC; 
            seg : out STD_LOGIC_VECTOR (6 downto 0);--Zahl die angezeigt wird
            an : out STD_LOGIC_VECTOR (3 downto 0);
            mb_ovf : out STD_LOGIC                  --Messbereich Overflow
            );
end component;

--Signale für die richtige Verbindung der 2 Hauptbestandteile mit den Ein- und Ausgängen
signal FrZ_en : std_logic;
signal FrZ_seg : std_logic_vector(6 downto 0);
signal FrZ_an : std_logic_vector(3 downto 0);
signal FrZ_ovf: std_logic;

signal PDM_en : std_logic;
signal PDM_seg : std_logic_vector(6 downto 0);
signal PDM_an : std_logic_vector(3 downto 0);
signal PDM_ovf: std_logic;

begin
Sync_mode: Einsynchronisation port map (clk => clk, x => modus, y => modus_sync);
Sync_einheit: Einsynchronisation port map(clk => clk, x => einheit, y => einheit_sync);

FrZaehler:  Frequenzzaehler_Hz Port map(clk => clk, en => FrZ_en, x_mess => x_mess, seg => FrZ_seg, an => FrZ_an, mb_ovf => FrZ_ovf, einheit => einheit_sync);
PDM : Periodendauermesser Port map(clk => clk, en => PDM_en, x_mess => x_mess, einheit => einheit_sync, seg => PDM_seg, an => PDM_an, mb_ovf => PDM_ovf);

--so ist jeweils nur immer einer der Modi aktiviert(Frequenzzähler bei Schalter = '0', Periodendauermesser bei Schalter = '1'
FrZ_en <= not modus_sync;
PDM_en <= modus_sync;

--3 Multiplexer, damit das jeweils nur das Ergebniss vom ausgewählten Modus angezeigt wird
with modus select an <=
        PDM_an when '1',
        FrZ_an when others;

with modus select seg <=
        PDM_seg when '1',
        FrZ_seg when others;
        
with modus select mb_ovf <=
        PDM_ovf when '1',
        FrZ_ovf when others;


end Behavioral;
