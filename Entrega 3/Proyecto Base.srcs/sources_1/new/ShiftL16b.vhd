----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2015 04:58:40 PM
-- Design Name: 
-- Module Name: ShiftL16b - Behavioral
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

entity ShiftL16b is
    Port ( inShiftL : in STD_LOGIC_VECTOR (15 downto 0);
           outShiftL : out STD_LOGIC_VECTOR (15 downto 0);
           co : out STD_LOGIC);
end ShiftL16b;

architecture Behavioral of ShiftL16b is

begin
    co <= inShiftL(15);
    outShiftL(15 downto 1) <= inShiftL(14 downto 0);
    outShiftL(0) <= '0';

end Behavioral;
