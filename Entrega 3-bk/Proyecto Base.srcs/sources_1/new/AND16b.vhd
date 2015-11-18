----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2015 04:33:30 PM
-- Design Name: 
-- Module Name: AND16b - Behavioral
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

entity AND16b is
    Port ( aAnd : in STD_LOGIC_VECTOR (15 downto 0);
           bAnd : in STD_LOGIC_VECTOR (15 downto 0);
           oAnd : out STD_LOGIC_VECTOR (15 downto 0));
end AND16b;

architecture Behavioral of AND16b is

begin

    oAnd <= aAnd and bAnd;

end Behavioral;
