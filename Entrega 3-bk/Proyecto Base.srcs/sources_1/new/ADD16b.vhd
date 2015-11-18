----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.09.2015 18:54:15
-- Design Name: 
-- Module Name: ADD16b - Behavioral
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

entity ADD16b is
    Port 
    (
           word1 : in STD_LOGIC_VECTOR (15 downto 0);
           word2 : in STD_LOGIC_VECTOR (15 downto 0);
           sCin : in STD_LOGIC;
           sSum : out STD_LOGIC_VECTOR (15 downto 0);
           sCout : out STD_LOGIC
    );
end ADD16b;

architecture Behavioral of ADD16b is

component FA Port
    (
        num1 : in std_logic;
        num2 : in std_logic;
        cin : in std_logic;
        sum : out std_logic;
        cout : out std_logic
    );
    end component;

signal c0 : std_logic;
signal c1 : std_logic;
signal c2 : std_logic;
signal c3 : std_logic;
signal c4 : std_logic;
signal c5 : std_logic;
signal c6 : std_logic;
signal c7 : std_logic;
signal c8 : std_logic;
signal c9 : std_logic;
signal c10 : std_logic;
signal c11 : std_logic;
signal c12 : std_logic;
signal c13 : std_logic;
signal c14 : std_logic;
signal c15 : std_logic;

begin

FAbit0: FA port map(
        num1 => word1(0),
        num2 => word2(0),
        sum => sSum(0),
        cin => sCin,
        cout => c0
    );

FAbit1: FA port map(
        num1 => word1(1),
        num2 => word2(1),
        sum => sSum(1),
        cin => c0,
        cout => c1
    );

FAbit2: FA port map(
        num1 => word1(2),
        num2 => word2(2),
        sum => sSum(2),
        cin => c1,
        cout => c2
    );

FAbit3: FA port map(
        num1 => word1(3),
        num2 => word2(3),
        sum => sSum(3),
        cin => c2,
        cout => c3
    );


FAbit4: FA port map(
        num1 => word1(4),
        num2 => word2(4),
        sum => sSum(4),
        cin => c3,
        cout => c4
    );


FAbit5: FA port map(
        num1 => word1(5),
        num2 => word2(5),
        sum => sSum(5),
        cin => c4,
        cout => c5
    );

FAbit6: FA port map(
        num1 => word1(6),
        num2 => word2(6),
        sum => sSum(6),
        cin => c5,
        cout => c6
    );

FAbit7: FA port map(
        num1 => word1(7),
        num2 => word2(7),
        sum => sSum(7),
        cin => c6,
        cout => c7
    );

FAbit8: FA port map(
        num1 => word1(8),
        num2 => word2(8),
        sum => sSum(8),
        cin => c7,
        cout => c8
    );

FAbit9: FA port map(
        num1 => word1(9),
        num2 => word2(9),
        sum => sSum(9),
        cin => c8,
        cout => c9
    );

FAbit10: FA port map(
        num1 => word1(10),
        num2 => word2(10),
        sum => sSum(10),
        cin => c9,
        cout => c10
    );

FAbit11: FA port map(
        num1 => word1(11),
        num2 => word2(11),
        sum => sSum(11),
        cin => c10,
        cout => c11
    );

FAbit12: FA port map(
        num1 => word1(12),
        num2 => word2(12),
        sum => sSum(12),
        cin => c11,
        cout => c12
    );

FAbit13: FA port map(
        num1 => word1(13),
        num2 => word2(13),
        sum => sSum(13),
        cin => c12,
        cout => c13
    );

FAbit14: FA port map(
        num1 => word1(14),
        num2 => word2(14),
        sum => sSum(14),
        cin => c13,
        cout => c14
    );

FAbit15: FA port map(
        num1 => word1(15),
        num2 => word2(15),
        sum => sSum(15),
        cin => c14,
        cout => sCout
    );


end Behavioral;