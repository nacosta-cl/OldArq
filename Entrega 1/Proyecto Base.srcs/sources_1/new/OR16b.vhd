----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2015 04:34:40 PM
-- Design Name: 
-- Module Name: OR16b - Behavioral
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

entity OR16b is
    Port ( aOR : in STD_LOGIC_VECTOR (15 downto 0);
           bOR : in STD_LOGIC_VECTOR (15 downto 0);
           oOr : out STD_LOGIC_VECTOR (15 downto 0));
end OR16b;

architecture Behavioral of OR16b is

begin

    oOr <= aOR or bOr;

end Behavioral;
