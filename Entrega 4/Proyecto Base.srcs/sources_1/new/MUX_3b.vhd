----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2015 11:51:28 PM
-- Design Name: 
-- Module Name: MUX_3b - Behavioral
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

entity MUX_3b is
    Port ( e1 : in STD_LOGIC_VECTOR (15 downto 0);
           e2 : in STD_LOGIC_VECTOR (15 downto 0);
           e3 : in STD_LOGIC_VECTOR (15 downto 0);
           e4 : in STD_LOGIC_VECTOR (15 downto 0);
           e5 : in STD_LOGIC_VECTOR (15 downto 0);
           e6 : in STD_LOGIC_VECTOR (15 downto 0);
           e7 : in STD_LOGIC_VECTOR (15 downto 0);
           e8 : in STD_LOGIC_VECTOR (15 downto 0);
           mSelect : in STD_LOGIC_VECTOR (2 downto 0);
           muxOut : out STD_LOGIC_VECTOR (15 downto 0));
end MUX_3b;

architecture Behavioral of MUX_3b is

begin

with mSelect select
    muxOut <= e1 when "000",
              e2 when "001",
              e3 when "010",
              e4 when "011",
              e5 when "100",
              e6 when "101",
              e7 when "110",
              e8 when "111";

end Behavioral;
