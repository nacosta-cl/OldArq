library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity reg_3b is
    Port ( clock    : in  std_logic;
           load     : in  std_logic;
           up       : in  std_logic;
           down     : in  std_logic;
           datain   : in  std_logic_vector (2 downto 0);
           dataout  : out std_logic_vector (2 downto 0));
end reg_3b;

architecture Behavioral of reg_3b is

signal reg : std_logic_vector(2 downto 0) := (others => '0');

begin

reg_process : process (clock)
        begin
          if (rising_edge(clock)) then
            if (load = '1') then
                reg <= datain;
            elsif (up = '1') then
                reg <= reg + 1;
            elsif (down = '1') then
                reg <= reg - 1;            
            end if;
          end if;
        end process;
        
dataout <= reg;
        
end Behavioral;
