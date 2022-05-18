----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2022 14:07:18
-- Design Name: 
-- Module Name: Speicher_Anzeige - Behavioral
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


entity Speicher_Anzeige is
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
end Speicher_Anzeige;

architecture Behavioral of Speicher_Anzeige is

signal tempd0 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal tempd1 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal tempd2 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal tempd3 : STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin

--wenn kein reset und writeEnable=1 ist wird der aktuelle Wert vom Eingang auf den Ausgang überommen
--wenn writeEnable=0 werden Änderungen am Ausgang nicht übernommen 
--bei reset werden alle Ausgänge auf 0 gesetzt
process(clk) begin
    if rising_edge(clk) then
            if we = '1' then
				tempd0 <= d0in;
				tempd1 <= d1in;
				tempd2 <= d2in;
				tempd3 <= d3in;
            end if;
    end if;
end process;
 
d0out <= std_logic_vector(tempd0);
d1out <= std_logic_vector(tempd1);
d2out <= std_logic_vector(tempd2);
d3out <= std_logic_vector(tempd3);

end Behavioral;
