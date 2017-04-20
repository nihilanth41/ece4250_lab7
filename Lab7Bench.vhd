library ieee;
use ieee.std_logic_1164.all;

entity Lab7Bench is
  port(SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7 : in std_logic;
       BTN0, BTN1, CLK : in std_logic;
       AN0, AN1, AN2, AN3 : out std_logic := '0';
       segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g, segment_dp : out std_logic := '0');
end Lab7Bench;

architecture Behavior of Lab7Bench is
  component AnodeControl
    port(clk : in std_logic;
          counter_out : out std_logic_vector(2 downto 0);
          Anode : out std_logic_vector(3 downto 0));
  end component;

  -- component BCD2BIN
  -- component BIN2BCD

  component LEDDisplay is
  port (DIN : in std_logic_vector(15 downto 0);
        DONE : in std_logic;
        counter : in std_logic_vector(2 downto 0);
        segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g : out std_logic);
  end component;

  signal number_in : std_logic_vector(7 downto 0);
  signal number_out : std_logic_vector(15 downto 0);
  signal done_signal : std_logic;
  signal counter : std_logic_vector(2 downto 0);
  signal Anode : std_logic_vector(3 downto 0);

begin

  AN0 <= Anode(0);
  AN1 <= Anode(1);
  AN2 <= Anode(2);
  AN3 <= Anode(3);
  number_in(0) <= SW0;
  number_in(1) <= SW1;
  number_in(2) <= SW2;
  number_in(3) <= SW3;
  number_in(4) <= SW4;
  number_in(5) <= SW5;
  number_in(6) <= SW6;
  number_in(7) <= SW7;
  
  segment_dp <= '1';

  -- Named association component name => entity name
  -- CONV0: BCD2BIN port map(number_in, BTN0, BTN1, CLK, number_out)
  -- CONV1: BIN2BCD port map(number_in, BTN0, BTN1, CLK, number_out)
  LEDDisplay0: LEDDisplay port map(number_out, done_signal, counter,
                                   segment_a, segment_b, segment_c,
                                   segment_d, segment_f, segment_g);
  ANDisplay: AnodeControl port map(CLK, counter, Anode);
  
end Behavior;
