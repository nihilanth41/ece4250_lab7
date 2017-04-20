library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_2_bin is
    Port (
	 input_binary_8 : in std_logic_vector ( 7 downto 0 ) := "00000000";
    btn_1, btn_2, CLK : in std_logic := '0';
           bin_out : out  STD_LOGIC_VECTOR (15 downto 0) := (others => '0')
	);
end bcd_2_bin;

architecture Behavioral of bcd_2_bin is
	signal bcd_in_0 : STD_LOGIC_VECTOR (3 downto 0);
        signal  bcd_in_10 : STD_LOGIC_VECTOR (3 downto 0);
         signal  bcd_in_100 : STD_LOGIC_VECTOR (3 downto 0);
         signal  bcd_in_1000 : STD_LOGIC_VECTOR (3 downto 0);

 	signal bcd_in_16 : STD_LOGIC_VECTOR (15 downto 0) := ( others => '0' );
    signal state : integer range 0 to 2;
	signal delay : integer range 0 to 5;
    signal upper8, lower8 : std_logic_vector( 7 downto 0 );
begin
	process ( CLK, btn_1, btn_2, state)
	begin

	if ( CLK'EVENT and CLK = '1' ) then

  if ( btn_1 = '1' and btn_2 = '0' and state = 0) then
        upper8 <= input_binary_8;
        state <= 1;
  elsif ( btn_1 = '0' and btn_2 = '1' and state = 1) then
	lower8 <= input_binary_8;
	state <= 2;
  elsif ( state = 2 and btn_1 = '0' and btn_2 = '0') then 

	delay <= delay + 1;
	if ( delay = 2 ) then
		delay <= 0;
		state <= 0;
	end if;

	bcd_in_16 <= upper8( 7 downto 0 ) & lower8( 7 downto 0 );
	bcd_in_0 <= bcd_in_16 ( 3 downto 0 );
	bcd_in_10 <= bcd_in_16 ( 7 downto 4 );
	bcd_in_100 <= bcd_in_16 ( 11 downto 8 );
	bcd_in_1000 <= bcd_in_16 ( 15 downto 12 );

bin_out <= "0000000000000000" + (bcd_in_0 * "01")  --multiply by 1
                + (bcd_in_10 * "1010") --multiply by 10
                + (bcd_in_100 * "1100100") --multiply by 100
                + (bcd_in_1000 * "1111101000"); --multiply by 1000

end if;
end if;
	end process;
end Behavioral;
