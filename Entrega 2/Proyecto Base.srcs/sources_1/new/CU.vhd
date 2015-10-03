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

signal ctrlSigs : std_logic_vector (10 downto 0);
signal OPcode   : std_logic_vector (6 downto 0);

begin

--Formato instrucciones: "0000000000"+opcode (10 ceros + opcode)
--Traduccion a OPcode estandarizado
OPcode <= instruc(6 downto 0); 
--Conexiones pertinentes

LPC <= ctrlSigs(10);
enabRegA <= ctrlSigs(9);
enabRegB <= ctrlSigs(8);
selMuxA <= ctrlSigs(7 downto 6);
selMuxB <= ctrlSigs(5 downto 4);
selALU <= ctrlSigs(3 downto 1);
write <= ctrlSigs(0);

-- Tabla de situaciones
-- muxA      00-> 0x0   01->0x1    10->A      11->0x0

-- muxB      00-> 0x0   01->B      10->DOUT   11->LIT

-- selectAlu 000->ADD   001->SUB   010->AND   011->OR   100->XOR   101->NOT   110->SHL   111->SHR

-- Leer
--loadPC|loadA|loadB|selectMuxA|selectMuxB|selectALU|Write (11bits)
with OPcode select
    ctrlSigs <= "01000010000" when "0000000",
                "00110000000" when "0000001",
                "01000110000" when "0000010",
                "00100110000" when "0000011",
                "01000100000" when "0000100",
                "00100100000" when "0000101",
                "00010000001" when "0000110",
                "00000010001" when "0000111",
                --ADD
                "01010010000" when "0001011",
                "00110010000" when "0001100",
                "01010110000" when "0001101",
                --b,lit
                "01010100000" when "0001110",
                --b,dir
                "00010010001" when "0010000",
                "01010010010" when "0010001",
                "00110010010" when "0010010",
                
                
                "00000000000" when "1111111",
                "00000000000" when others;

end Behavioral;
