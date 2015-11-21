----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2015 07:55:25 PM
-- Design Name: 
-- Module Name: SUS16b - Behavioral
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

entity SUS16b is
    Port ( rWord1 : in STD_LOGIC_VECTOR (15 downto 0);
           rWord2 : in STD_LOGIC_VECTOR (15 downto 0);
           rest : out STD_LOGIC_VECTOR (15 downto 0);
           rCout : out STD_LOGIC);
end SUS16b;

architecture Behavioral of SUS16b is

component ADD16b
    Port ( word1 : in STD_LOGIC_VECTOR (15 downto 0);
           word2 : in STD_LOGIC_VECTOR (15 downto 0);
           sCin : in STD_LOGIC;
           sSum : out STD_LOGIC_VECTOR (15 downto 0);
           sCout : out STD_LOGIC);
    end component;

begin


ADD: ADD16b port map(
        word1 => rWord1,
        word2 => not(rWord2),
        sCin => '1',
        sCout => rCout,
        sSum => rest
    );


end Behavioral;
