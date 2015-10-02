----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.10.2015 18:17:50
-- Design Name: 
-- Module Name: CU - Behavioral
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

entity CU is
    Port(   instruc     : in std_logic_vector (16 downto 0);
        ALUstatus   : in std_logic_vector (2 downto 0);
        enabRegA    : out std_logic;
        enabRegB    : out std_logic;
        selMuxA     : out std_logic_vector (1 downto 0);
        selMuxB     : out std_logic_vector (1 downto 0);
        selALU      : out std_logic_vector (2 downto 0);
        write       : out std_logic;
        LPC         : out std_logic);
end CU;

architecture Behavioral of CU is

begin


end Behavioral;
