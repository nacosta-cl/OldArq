----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2015 04:39:05 PM
-- Design Name: 
-- Module Name: NOT16b - Behavioral
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

entity NOT16b is
    Port ( inNot : in STD_LOGIC_VECTOR (15 downto 0);
           outNot : out STD_LOGIC_VECTOR (15 downto 0));
end NOT16b;

architecture Behavioral of NOT16b is

begin

    outNot <= not(inNot);

end Behavioral;
