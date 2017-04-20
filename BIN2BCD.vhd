library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity BIN2BCD is
  port (
    input_binary_8 : in std_logic_vector ( 7 downto 0 );
    btn_1, btn_2 : in std_logic;
    clk : in std_logic;
    BCD : out std_logic_vector ( 15 downto 0 )
  );
end entity BIN2BCD;
-----------------------------------
architecture a of BIN2BCD is
    signal digit_0 : std_logic_vector( 3 downto 0);
    signal digit_1 : std_logic_vector( 3 downto 0);
    signal digit_2 : std_logic_vector( 3 downto 0);
    signal digit_3 : std_logic_vector( 3 downto 0);
    signal digit_4 : std_logic_vector( 3 downto 0);

    signal in_binary : std_logic_vector( 15 downto 0 );
    signal upper8, lower8 : std_logic_vector( 7 downto 0 );

	 signal state : integer range 0 to 2;
	 signal delay : integer range 0 to 5;
begin

  process( CLK, btn_1, btn_2, state )
    variable s_digit_0 : unsigned( 3 downto 0);
    variable s_digit_1 : unsigned( 3 downto 0);
    variable s_digit_2 : unsigned( 3 downto 0);
    variable s_digit_3 : unsigned( 3 downto 0);
    variable s_digit_4 : unsigned( 3 downto 0);
  begin

	if ( CLK'EVENT and CLK = '1' ) then 

  if ( btn_1 = '1' and btn_2 = '0' and state = 0) then
        upper8 <= input_binary_8;
        state <= 1;
  elsif ( btn_1 = '0' and btn_2 = '1' and state = 1) then
	lower8 <= input_binary_8;
	state <= 2;
  elsif (btn_1 = '0' and btn_2 = '0' and state = 2 ) then 


	delay <= delay + 1;
	if ( delay = 2 ) then
		delay <= 0;
		state <= 0;
	end if;

    in_binary <= upper8( 7 downto 0 ) & lower8( 7 downto 0 );

    s_digit_4 := "0000";
    s_digit_3 := "0000";
    s_digit_2 := "0000";
    s_digit_1 := "0000";
    s_digit_0 := "0000";
 
    for i in 15 downto 0 loop

      if (s_digit_4 >= 5) then s_digit_4 := s_digit_4 + 3; end if;
      if (s_digit_3 >= 5) then s_digit_3 := s_digit_3 + 3; end if;
      if (s_digit_2 >= 5) then s_digit_2 := s_digit_2 + 3; end if;
      if (s_digit_1 >= 5) then s_digit_1 := s_digit_1 + 3; end if;
      if (s_digit_0 >= 5) then s_digit_0 := s_digit_0 + 3; end if;

      s_digit_4 := s_digit_4 sll 1; s_digit_4(0) := s_digit_3(3);
      s_digit_3 := s_digit_3 sll 1; s_digit_3(0) := s_digit_2(3);
      s_digit_2 := s_digit_2 sll 1; s_digit_2(0) := s_digit_1(3);
      s_digit_1 := s_digit_1 sll 1; s_digit_1(0) := s_digit_0(3);
      s_digit_0 := s_digit_0 sll 1; s_digit_0(0) := in_binary(i);

    end loop;
 
    digit_0 <= std_logic_vector(s_digit_0);
    digit_1 <= std_logic_vector(s_digit_1);
    digit_2 <= std_logic_vector(s_digit_2);
    digit_3 <= std_logic_vector(s_digit_3);
    digit_4 <= std_logic_vector(s_digit_4);


    bcd <= std_logic_vector(s_digit_3) & std_logic_vector(s_digit_2) & std_logic_vector(s_digit_1) & std_logic_vector(s_digit_0);
	

  end if;
	end if;
  end process;
 
end architecture a;