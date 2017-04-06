library ieee;
use ieee.std_logic_1164.all;

entity BCD2BIN is
  port(BCD : in std_logic_vector(7 downto 0) := (others => '0'); -- 8-bit BCD
       LD1, LD2 : in std_logic := '0'; -- Load 1, Load 2
       BIN : out std_logic_vector(15 downto 0) := (others => '0');
       DONE : out std_logic := '0');
end BCD2BIN;

architecture Behavior of BCD2BIN is
  
  

end Behavior;
                                                                      
       
       
       
       
