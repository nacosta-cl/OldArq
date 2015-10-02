----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.08.2015 15:35:46
-- Design Name: 
-- Module Name: FA - Behavioral
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

entity FA is Port
(
    num1 : in std_logic;
    num2 : in std_logic;
    cin : in std_logic;
    sum : out std_logic;
    cout : out std_logic
);
end FA;

architecture Behavioral of FA is

component HA
    Port(   a : in std_logic;
            b : in std_logic;
            s : out std_logic;
            c : out std_logic);
    end component;
   
signal s1 : std_logic;
signal c1 : std_logic;
signal c2 : std_logic;

begin
-- Union directa de los dos cables que salen de los carry

cout <= c1 or c2;

inst_HA: HA port map(
        a => num1,
        b => num2,
        s => s1,
        c => c1
        );

inst_HA2: HA port map(
        a => s1,
        b => cin,
        s => sum,
        c => c2
        );

end Behavioral;