----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.11.2015 12:07:17
-- Design Name: 
-- Module Name: Decoder - Behavioral
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

entity Decoder is
    Port ( din : in STD_LOGIC_VECTOR (0 to 15);
           loadOut : in STD_LOGIC;
           dout : out STD_LOGIC_VECTOR (0 to 2));
end Decoder;

architecture Behavioral of Decoder is

begin
    dout <= "000" when loadOut ='0' else
    "001" when  loadOut = '1 and din = '00'
    "010" when  loadOut = '1 and din = '01'
    "101" when  loadOut = '1 and din = '10'
    
    
    


end Behavioral;
