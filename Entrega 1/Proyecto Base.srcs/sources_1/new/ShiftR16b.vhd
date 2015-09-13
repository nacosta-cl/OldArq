----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2015 04:57:39 PM
-- Design Name: 
-- Module Name: ShiftR16b - Behavioral
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

entity ShiftR16b is
    Port ( inShiftR : in STD_LOGIC_VECTOR (15 downto 0);
           outShiftR : out STD_LOGIC_VECTOR (15 downto 0));
end ShiftR16b;

architecture Behavioral of ShiftR16b is

begin

    outShiftR(14 downto 0) <= inShiftR(15 downto 1);
    outShiftR(15) <= '0';

end Behavioral;
