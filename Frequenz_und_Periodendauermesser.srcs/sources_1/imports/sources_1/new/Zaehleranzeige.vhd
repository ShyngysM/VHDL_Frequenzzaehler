----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2022 15:18:52
-- Design Name: 
-- Module Name: Zaehleranzeige - Behavioral
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

entity Zaehleranzeige is
    Port (  clk : in STD_LOGIC;                     --Taktsignal
            x_mess : in std_logic;                  --Eingang fï¿½r das zu messende Signal
            res : in std_logic;                     --reset fï¿½r die 4 Zï¿½hlerdekaden
            en : in std_logic;                      --enable fï¿½r das Anzeigen Gesamtkonstrukt
            dek_clk : in std_logic;                 --extra Eingang für das clk Signal der Dekaden, ist beim Fr.Zähler einfach nur clk, bei der Periodendauermessung aber vorgeteilt
            we_speicher : in std_logic;             --Eingang fï¿½r das Ansteuern des write enable des Speichers durch den Automaten
            seg : out STD_LOGIC_VECTOR (6 downto 0);--Zahl die Angezeigt wird
            an : out STD_LOGIC_VECTOR (3 downto 0); --Stelle, wo die Zahl angezeigt wird
            mb_ovf : out STD_LOGIC;                  --Messbereich Overflow
            d0out_sp_test: out std_logic_vector (3 downto 0);
            d1out_sp_test: out std_logic_vector (3 downto 0);
            d2out_sp_test: out std_logic_vector (3 downto 0);
            d3out_sp_test: out std_logic_vector (3 downto 0)
            );
end Zaehleranzeige;

architecture Behavioral of Zaehleranzeige is
--=============================================
--Zï¿½hler, der 0-3 zï¿½hlt und wieder von vorne, wird benutzt um 4 Digits der Anzeige gleichzeitig darzustellen
component Zaehler_2bit is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (1 downto 0));
end component;
signal tempZaehlerY: STD_LOGIC_VECTOR (1 downto 0);

--Auswahl, welche Anode der Anzeige "beschrieben" wird
component dekoder_1aus4 is
    Port ( y : out STD_LOGIC_VECTOR (3 downto 0);
           x : in STD_LOGIC_VECTOR (1 downto 0));
end component;
signal tempAn : STD_LOGIC_VECTOR (3 downto 0);

--Dekodierer, welcher die Zahl im x-Vektor umwandelt, sodass sie auf der Digitalanzeige als Zahlen dargestellt werden (im Praktikum erstellt)
component segmentanzeige is
    Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;
signal tempSeg : STD_LOGIC_VECTOR (6 downto 0);
signal tempDigit : STD_LOGIC_VECTOR (3 downto 0);

--Vorteiler fuer den schnellen Wechsel von Digit0-3 (im Praktikum erstellt)
component Vorteiler is
    Port ( clk : in STD_LOGIC;
           y : out STD_LOGIC := '0');
end component;
signal clkVT : STD_LOGIC;

--Zwischensignale fuer die Werte von Stellen 0-3 der Anzeige
signal digit0: STD_LOGIC_VECTOR (3 downto 0);
signal digit1: STD_LOGIC_VECTOR (3 downto 0);
signal digit2: STD_LOGIC_VECTOR (3 downto 0);
signal digit3: STD_LOGIC_VECTOR (3 downto 0);

--Speicher fuer die Anzeige
component Speicher_Anzeige is
    Port ( clk : in STD_LOGIC;
		   we : in STD_LOGIC; --write_enable
		   d0in : in STD_LOGIC_VECTOR (3 downto 0);
		   d1in : in STD_LOGIC_VECTOR (3 downto 0);
		   d2in : in STD_LOGIC_VECTOR (3 downto 0);
		   d3in : in STD_LOGIC_VECTOR (3 downto 0);
           d0out : out STD_LOGIC_VECTOR (3 downto 0);
		   d1out : out STD_LOGIC_VECTOR (3 downto 0);
		   d2out : out STD_LOGIC_VECTOR (3 downto 0);
		   d3out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--die 4 Zaehlerdekaden
component Dekaden_Kombination is
  Port (    clk :in std_logic;            
            x : in std_logic;                  --Eingang fï¿½r das zu messende Signal
            res : in std_logic;                     --reset fï¿½r die 4 Zï¿½hlerdekaden
            en : in std_logic;                      --Enable
            mb_ovf : out STD_LOGIC;                 --Messbereich Overflow
            dek0_y : out std_logic_vector(3 downto 0);
            dek1_y : out std_logic_vector(3 downto 0);
            dek2_y : out std_logic_vector(3 downto 0);
            dek3_y : out std_logic_vector(3 downto 0)
            );
end component;
signal temp_dek0_y : std_logic_vector(3 downto 0);
signal temp_dek1_y : std_logic_vector(3 downto 0);
signal temp_dek2_y : std_logic_vector(3 downto 0);
signal temp_dek3_y : std_logic_vector(3 downto 0);


--Signale zwischen Speicher und MUX
signal d0out_sp: std_logic_vector(3 downto 0);
signal d1out_sp: std_logic_vector(3 downto 0);
signal d2out_sp: std_logic_vector(3 downto 0);
signal d3out_sp: std_logic_vector(3 downto 0);

--===========================================================

begin
 Vorteiler_Zaehler: Vorteiler Port map (clk => clk, y => clkVT);
 Zaehler : Zaehler_2bit Port map (clk => clk, en => clkVT, y => tempZaehlerY);

 Dekaden : Dekaden_Kombination Port map (clk => dek_clk, x => x_mess, res=>res, en=>en, mb_ovf => mb_Ovf, dek0_y=>temp_dek0_y, dek1_y=>temp_dek1_y, dek2_y=>temp_dek2_y, dek3_y=>temp_dek3_y);

 Speicher: Speicher_Anzeige Port map
            (clk=>clk, we=>we_speicher, d0in=>temp_dek0_y, d1in=>temp_dek1_y, d2in=>temp_dek2_y, d3in=>temp_dek3_y, d0out=>d0out_sp, d1out=>d1out_sp, d2out=>d2out_sp, d3out=>d3out_sp);

 anDekoder : dekoder_1aus4 Port map(x => tempZaehlerY, y => tempAn);
 an <= not tempAn;
 segDekoder : segmentanzeige Port map(x => tempDigit, seg => tempSeg);
 seg <= not tempSeg;

--tempZaehler wechselt mit vorgeteiltem clk Takt schnell von 0-3; mit dem folgendem wird der Wechsel der Stellenanzeigen und Werte dieser realisiert
 with tempZaehlerY select tempDigit <=
 d0out_sp when "00",
 d1out_sp when "01",
 d2out_sp when "10",
 d3out_sp when others;
 

 
 --für Testzwecke: die Zahlenwerte, die am Ausgang des Speichers sind können besser gelesen werden, als die codierten (seg) am Ausgang. So lässt sich die Simulation besser bewerten
 d0out_sp_test <= d0out_sp;
 d1out_sp_test <= d1out_sp;
 d2out_sp_test <= d2out_sp;
 d3out_sp_test <= d3out_sp;
 
end Behavioral;

