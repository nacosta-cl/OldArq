----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2015 19:19:58
-- Design Name: 
-- Module Name: MUXIO - Behavioral
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

entity MUXIO is
    Port ( e1 : in STD_LOGIC_VECTOR (15 downto 0);
           e2 : in STD_LOGIC_VECTOR (15 downto 0);
           e3 : in STD_LOGIC_VECTOR (15 downto 0);
           e4 : in STD_LOGIC_VECTOR (15 downto 0);
           mSelect  : in STD_LOGIC_VECTOR (1 downto 0);
           muxOut : out STD_LOGIC_VECTOR (15 downto 0) );
end MUXIO;

architecture Behavioral of MUXIO is

begin


end Behavioral;
