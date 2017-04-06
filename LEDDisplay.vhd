---------------------------------------------------------------------------------
----  ECE 7250/4250 Lab
----  Digital Systems Design - VHDL and Programmable Logic Devices 
----  Instructor: Dr.Harry Tyrer & Fadi Muheidat
----  T.A.: Sruthikesh Surineni
---------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity LEDDisplay is
  port (DIN : in std_logic_vector(15 downto 0) := (others => '0');
        DONE : in std_logic := '0';
        counter : in std_logic_vector(2 downto 0) := (others => '0');
        segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g : out std_logic);
end LEDDisplay;

architecture Behav of LEDDisplay is

component dec_7seg 
  port (hex_digit : in std_logic_vector (3 downto 0);
        segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g : out std_logic);
end component;

signal segment_a1, segment_a2, segment_a3, segment_a4,
  segment_b1, segment_b2, segment_b3, segment_b4,
  segment_c1, segment_c2, segment_c3, segment_c4,
  segment_d1, segment_d2, segment_d3, segment_d4,
  segment_e1, segment_e2, segment_e3, segment_e4,
  segment_f1, segment_f2, segment_f3, segment_f4,
  segment_g1, segment_g2, segment_g3, segment_g4 : std_logic;
signal hex_digit1, hex_digit2, hex_digit3, hex_digit4 : std_logic_vector (3 downto 0) := (others => '0');

begin
process (DONE)	
begin
  if(DONE='1') then
    hex_digit1 <= DIN(3 downto 0);
    hex_digit2 <= DIN(7 downto 4);
    hex_digit3 <= DIN(11 downto 0);
    hex_digit4 <= DIN(15 downto 12);
  end if;
end process;


process (counter,
         segment_a1,segment_b1,segment_c1,segment_d1,segment_e1,segment_f1,segment_g1,
         segment_a2,segment_b2,segment_c2,segment_d2,segment_e2,segment_f2,segment_g2,
         segment_a3,segment_b3,segment_c3,segment_d3,segment_e3,segment_f3,segment_g3,
         segment_a4,segment_b4,segment_c4,segment_d4,segment_e4,segment_f4,segment_g4)
begin
	case counter is
--	when "1110" =>
	when "000" =>
		segment_a <= segment_a1;
		segment_b <= segment_b1;
		segment_c <= segment_c1;
		segment_d <= segment_d1;
		segment_e <= segment_e1;
		segment_f <= segment_f1;
		segment_g <= segment_g1;
--	when "1101" =>
	when "010" =>
		segment_a <= segment_a2;
		segment_b <= segment_b2;
		segment_c <= segment_c2;
		segment_d <= segment_d2;
		segment_e <= segment_e2;
		segment_f <= segment_f2;
		segment_g <= segment_g2;
--	when "1011" =>
	when "100" =>
		segment_a <= segment_a3;
		segment_b <= segment_b3;
		segment_c <= segment_c3;
		segment_d <= segment_d3;
		segment_e <= segment_e3;
		segment_f <= segment_f3;
		segment_g <= segment_g3;
--	when "0111" =>
	when "110" =>
		segment_a <= segment_a4;
		segment_b <= segment_b4;
		segment_c <= segment_c4;
		segment_d <= segment_d4;
		segment_e <= segment_e4;
		segment_f <= segment_f4;
		segment_g <= segment_g4;
	when others =>
		segment_a <= '1';
		segment_b <= '1';
		segment_c <= '1';
		segment_d <= '1';
		segment_e <= '1';
		segment_f <= '1';
		segment_g <= '1';
	end case;
end process;

LED_Display1: 	dec_7seg  port map (hex_digit1, segment_a1, segment_b1, segment_c1, segment_d1, segment_e1, segment_f1, segment_g1);
LED_Display2: 	dec_7seg  port map (hex_digit2, segment_a2, segment_b2, segment_c2, segment_d2, segment_e2, segment_f2, segment_g2);
LED_Display3:   dec_7seg  port map (hex_digit3, segment_a3, segment_b3, segment_c3, segment_d3, segment_e3, segment_f3, segment_g3);
LED_Display4:   dec_7seg  port map (hex_digit4, segment_a4, segment_b4, segment_c4, segment_d4, segment_e4, segment_f4, segment_g4);

end Behav;
