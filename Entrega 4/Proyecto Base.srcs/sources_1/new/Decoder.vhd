library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
 
entity Decoder is
   port(loadOut : in std_logic;
        din : in std_logic_vector(1 downto 0);
        dout : out std_logic_vector(3 downto 0));
end Decoder;
 
architecture Behavioral of Decoder is

begin
   
   dout <="0000" when loadOut='0' else
        "0001" when loadOut='1' and din="00" else
        "0010" when loadOut='1' and din="01" else
        "0100" when loadOut='1' and din="10" else
        "1000" when loadOut='1' and din="11";

end Behavioral;
