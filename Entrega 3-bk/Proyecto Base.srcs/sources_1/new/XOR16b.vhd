----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2015 04:35:35 PM
-- Design Name: 
-- Module Name: XOR16b - Behavioral
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

entity XOR16b is
    Port ( aXOR : in STD_LOGIC_VECTOR (15 downto 0);
           bXOR : in STD_LOGIC_VECTOR (15 downto 0);
           oXOR : out STD_LOGIC_VECTOR (15 downto 0));
end XOR16b;

architecture Behavioral of XOR16b is

begin

    oXOR <= aXOR xor bXOR;

end Behavioral;
