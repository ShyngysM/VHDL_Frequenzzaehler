----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2022 14:53:28
-- Design Name: 
-- Module Name: Zaehleranzeige_tb - Behavioral
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

entity Zaehleranzeige_tb is
--  Port ( );
end Zaehleranzeige_tb;

architecture Behavioral of Zaehleranzeige_tb is
component Zaehleranzeige is
    Port (  clk, dek_clk : in STD_LOGIC;                     --Taktsignal
            x_mess : in std_logic;                  --Eingang f�r das zu messende Signal
            res : in std_logic;                     --reset f�r die 4 Z�hlerdekaden
            en : in std_logic;                      --enable f�r das Anzeigen Gesamtkonstrukt
            we_speicher : in std_logic;             --Eingang f�r das Ansteuern des write enable des Speichers durch den Automaten
            seg : out STD_LOGIC_VECTOR (6 downto 0);--Zahl die Angezeigt wird
            an : out STD_LOGIC_VECTOR (3 downto 0); --Stelle, wo die Zahl angezeigt wird
            mb_ovf : out STD_LOGIC;                  --Messbereich Overflow
            d0out_sp_test: out std_logic_vector (3 downto 0);
            d1out_sp_test: out std_logic_vector (3 downto 0);
            d2out_sp_test: out std_logic_vector (3 downto 0);
            d3out_sp_test: out std_logic_vector (3 downto 0)
            );
end component;

signal x_mess : std_logic;
signal res : std_logic := '0';
signal seg : STD_LOGIC_VECTOR (6 downto 0);
signal an : STD_LOGIC_VECTOR (3 downto 0);
signal clk, dek_clk : STD_LOGIC := '0';
signal mb_ovf : std_logic;
signal en : std_logic := '1';
signal we_speicher : std_logic := '0';
signal d0out_sp_test, d1out_sp_test, d2out_sp_test, d3out_sp_test: std_logic_vector (3 downto 0);

begin
test: Zaehleranzeige Port Map(dek_clk => dek_clk, x_mess=>x_mess, res=>res, seg=>seg, an=>an, clk=>clk, mb_ovf=>mb_ovf, en=>en, we_speicher=>we_speicher, d0out_sp_test => d0out_sp_test, d1out_sp_test => d1out_sp_test, d2out_sp_test => d2out_sp_test, d3out_sp_test => d3out_sp_test);
-- Stimuli für Frequenzzaehler
clk <= not clk after 5ns;
dek_clk <= not dek_clk after 5ns;

en <= '0' after 5ms;

 process begin
    x_mess<='0';
    wait for 100ns;
    x_mess<='1';
    wait for 10ns;
 end process;
 
 process begin
    wait for 510ns;
    res <= not res;
    wait for 10ns;
    res <= not res;
 end process;

 process begin
    wait for 500ns;
    we_speicher <= not we_speicher;
    wait for 10ns;
    we_speicher <= not we_speicher;
 end process;

end Behavioral;
