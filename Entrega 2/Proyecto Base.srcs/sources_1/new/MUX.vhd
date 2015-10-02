----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2015 18:19:59
-- Design Name: 
-- Module Name: MUX 2b - Behavioral
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

entity MUX_2b is
    Port ( e1 : in STD_LOGIC_VECTOR (16 downto 0);
           e2 : in STD_LOGIC_VECTOR (16 downto 0);
           e3 : in STD_LOGIC_VECTOR (16 downto 0);
           e4 : in STD_LOGIC_VECTOR (16 downto 0);
           mSelect  : in STD_LOGIC_VECTOR (1 downto 0);
           muxOut : out STD_LOGIC_VECTOR (16 downto 0) );
end MUX_2b;

architecture Behavioral of MUX_2b is

begin

with mSelect select
    muxout <= e1 when "00",
              e2 when "01",
              e3 when "10",
              e4 when "11";

end Behavioral;
