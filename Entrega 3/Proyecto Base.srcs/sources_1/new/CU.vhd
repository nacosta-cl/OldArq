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
            LPC         : out std_logic;
            wStatus     : out std_logic;
            jmpBits     : out std_logic_vector (7 downto 0)
            );
end CU;

architecture Behavioral of CU is

signal naturalSigs : std_logic_vector (10 downto 0);
signal ctrlSigs : std_logic_vector (10 downto 0);
signal OPcode   : std_logic_vector (6 downto 0);

signal Z : std_logic;
signal N : std_logic;
signal C : std_logic;

signal cEQ : std_logic;
signal cNE : std_logic;
signal cGT : std_logic;
signal cLT : std_logic;
signal cGE : std_logic;
signal cLE : std_logic;
signal cCR : std_logic;

signal iJEQ : STD_LOGIC;
signal iJNE : STD_LOGIC;
signal iJLT : STD_LOGIC;
signal iJGE : STD_LOGIC;
signal iJCR : STD_LOGIC;
signal iJGT : STD_LOGIC;
signal iJLE : STD_LOGIC;

begin

--Formato instrucciones: "0000000000"+opcode (10 ceros + opcode)
--Traduccion a OPcode estandarizado
OPcode <= instruc(6 downto 0); 
--Conexiones pertinentes
IncSP       <= ctrlSigs(16);
DecSP       <= ctrlSigs(15);
Spc         <= ctrlSigs(14);
Sadd        <= ctrlSigs(13 downto 12);
Sdin        <= ctrlSigs(11);

LPC         <= ctrlSigs(10);
enabRegA    <= ctrlSigs(9);
enabRegB    <= ctrlSigs(8);
selMuxA     <= ctrlSigs(7 downto 6);
selMuxB     <= ctrlSigs(5 downto 4);
selALU      <= ctrlSigs(3 downto 1);
write       <= ctrlSigs(0);

Z <= ALUstatus(0);
N <= ALUstatus(1);
C <= ALUstatus(2);


--Eveluadores de condicion correcta para saltos condicionales
--Hay alg�n opcode util de salto
with opcode select
    iJEQ <= '1' when "1001101",    
            '0' when others;
with opcode select
    iJNE <= '1' when "1001110",
            '0' when others;
with opcode select
    iJGT <= '1' when "1001111",    
            '0' when others;
with opcode select
    iJGE <= '1' when "1010001",    
            '0' when others;
with opcode select
    iJLT <= '1' when "1010000",    
            '0' when others;
with opcode select
    iJLE <= '1' when "1010010",    
            '0' when others;
with opcode select
    iJCR <= '1' when "1010011",    
            '0' when others;

--Condiciones de paso
--Se tiene que cumplir condicion de salto y funcionalidad de OPcode
cEQ <= (Z)       when (iJEQ = '1') else '0'; --OK
cNE <= not Z     when (iJNE = '1') else '0'; --Ncomp
cLT <= (N)       when (iJLT = '1') else '0'; --Ncomp
cGE <= not N     when (iJGE = '1') else '0'; --Ncomp
cCR <= (C)       when (iJCR = '1') else '0'; --Ncomp
cGT <= (Z or N)  when (iJGT = '1') else '0'; --Ncomp
cLE <= (Z nor N) when (iJLE = '1') else '0'; --Ncomp

jmpBits(0) <= cEQ;
jmpBits(1) <= cNE;
jmpBits(2) <= cLT;
jmpBits(3) <= cGE;
jmpBits(4) <= cCR;
jmpBits(5) <= cGT;
jmpBits(6) <= cLE;

--JMP JEQ JNE JGT JGE JLT JLE JCR
--Activar registro de status

--salta si existe salto
ctrlSigs <= "10000000000" when ((cEQ = '1') or (cNE = '1') or (cGT = '1') or (cGE = '1') or (cLT = '1') or (cLE = '1') or (cCR = '1'))
            else naturalSigs;
            
            
-- Tabla de situaciones
                -- muxA      00-> 0x0   01->0x1    10->A      11->0x0
               
                -- muxB      00-> 0x0   01->B      10->DOUT   11->LIT
                
                -- selectAlu 000->ADD   001->SUB   010->AND   011->OR   100->XOR   101->NOT   110->SHL   111->SHR
                
                -- Leer
--incsp|decsp|spc|sadd|sdin|loadPC|loadA|loadB|selectMuxA|selectMuxB|selectALU|Write (11bits)

with OPcode select
                --MOV
 naturalSigs <= "000000 01000010000" when "1111110",
                "000000 00110000000" when "0000001",
                "000000 01000110000" when "0000010",
                "000000 00100110000" when "0000011",
                "000000 01000100000" when "0000100",
                "000000 00100100000" when "0000101",
                "000000 00010000001" when "0000110",
                "000000 00000010001" when "0000111",
                "000000 00000000000" when "0001000",
                "000000 00000000000" when "0001001",
                "000000 00000000000" when "0001010",
                "000000 01010010000" when "0001011", --ADD
                "000000 00110010000" when "0001100",
                "000000 01010110000" when "0001101",
                "000000 00110110000" when "1000000",--b,lit
                "000000 01010100000" when "0001110",
                "000000 00110100000" when "1000001", --b,dir
                "000000 00000000000" when "0001111",
                "000000 00010010001" when "0010000",
                "000000 01010010010" when "0010001",
                "000000 00110010010" when "0010010",
                "000000 01010110010" when "1000010", --SUB A,Lit
                "000000 00110110010" when "1000011", --SUB B,Lit
                "000000 01010100010" when "0010011",
                "000000 00110100010" when "1000100", --SUB B,Dir
                "000000 00000000000" when "0010100",
                "000000 00010010011" when "0010101",
                "000000 01010010100" when "0010110",
                "000000 00110010100" when "0010111",
                "000000 01010110100" when "0011000",
                "000000 00110110100" when "1000101", --AND B,Lit
                "000000 01010100100" when "0011001",
                "000000 00110100100" when "1000110", --AND B,Dir
                "000000 00000000000" when "0011010",
                "000000 00010010101" when "0011011",
                "000000 01010010110" when "0011100",
                "000000 00110010110" when "0011101",
                "000000 01010110110" when "0011110",
                "000000 00110110110" when "1000111", --OR B,Lit
                "000000 01010100110" when "0011111",
                "000000 00110100110" when "1001000", --OR B,Dir
                "000000 00000000000" when "0100000",
                "000000 00010010111" when "0100001",
                "000000 01010001010" when "0100010",
                "000000 00110001010" when "0100011",
                "000000 00000000000" when "0100100",
                "000000 00000000000" when "0100101",
                "000000 00000000000" when "0100110",
                "000000 00010011011" when "0100111",
                "000000 01010011000" when "0101000",
                "000000 00110011000" when "0101001",
                "000000 01010111000" when "0101010",
                "000000 00110111000" when "1001001", --XOR B,Lit
                "000000 01010101000" when "0101011",
                "000000 00110101000" when "1001010", --XOR B,Dir
                "000000 00000000000" when "0101100",
                "000000 00010011001" when "0101101",
                "000000 01010001100" when "0101110",
                "000000 00110001100" when "0101111",
                "000000 00000000000" when "0110000",
                "000000 00000000000" when "0110001",
                "000000 00000000000" when "0110010",
                "000000 00010011101" when "0110011",
                "000000 01010001110" when "0110100",
                "000000 00110001110" when "0110101",
                "000000 00000000000" when "0110110",
                "000000 00000000000" when "0110111",
                "000000 00000000000" when "0111000",
                "000000 00010011111" when "0111001",
--              -000000 -INC A se reemplaza en compilador por la instruccion ADD A,1
                "000000 00101010000" when "0111010", --INC B
                "000000 00001100001" when "1001011", --INC Dir
--              -000000 -DEC A idem arriba SUB A,1
                "000000 00010010010" when "0111011", --CMP A,B
                "000000 00010110010" when "0111100", --CMP
                "000000 00010100010" when "1001100", --CMP A,Dir 
                -000000 -Saltos
                "000000 10000000000" when "0111101", --JMP
                "000000 00010001011" when "1010100", --NOT (DIR),A
                "000000 00000000000" when "0000000", --NOP
                "000000 00000000000" when others;

end Behavioral;
