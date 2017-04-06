library ieee;
use ieee.std_logic_1164.all;

entity Lab7Bench is
  port(DIN : in std_logic_vector(7 downto 0) := (others => '0');
       LD1, LD2, CLK : in std_logic := '0';
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

  signal number_out : std_logic_vector(15 downto 0);
  signal done_signal : std_logic;
  signal counter : std_logic_vector(2 downto 0);
  signal Anode : std_logic_vector(3 downto 0);

begin

  AN0 <= Anode(0);
  AN1 <= Anode(1);
  AN2 <= Anode(2);
  AN3 <= Anode(3);

  segment_dp <= '1';

  -- Named association component name => entity name
  -- CONV: BCD2BIN port map()
  -- CONV: BIN2BCD port map()
  LEDDisplay0: LEDDisplay port map(number_out, done_signal, counter,
                                   segment_a, segment_b, segment_c,
                                   segment_d, segment_f, segment_g);
  ANDisplay: AnodeControl port map(CLK, counter, Anode);
  
end Behavior;
