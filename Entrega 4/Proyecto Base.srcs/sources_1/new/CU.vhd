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
            jmpBits     : out std_logic_vector (7 downto 0);
            IncSP       : out std_logic;
            DecSP       : out std_logic;
            Spc         : out std_logic;
            Sadd        : out std_logic_vector(1 downto 0);
            Sdin        : out std_logic
            );
end CU;

architecture Behavioral of CU is

signal naturalSigs : std_logic_vector (16 downto 0);
signal ctrlSigs : std_logic_vector (16 downto 0);
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
--Hay algún opcode util de salto
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
cNE <= not Z     when (iJNE = '1') else '0'; --OK
cLT <= (N)       when (iJLT = '1') else '0'; --OK
cGE <= not N     when (iJGE = '1') else '0'; --OK
cCR <= (C)       when (iJCR = '1') else '0'; --OK
cGT <= (Z or N)  when (iJGT = '1') else '0'; --OK
cLE <= (Z nor N) when (iJLE = '1') else '0'; --OK

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
ctrlSigs <= "00000010000000000" when ((cEQ = '1') or (cNE = '1') or (cGT = '1') or (cGE = '1') or (cLT = '1') or (cLE = '1') or (cCR = '1'))
            else naturalSigs;
            
            
-- Tabla de situaciones
                -- muxA      00-> 0x0   01->0x1    10->A      11->muxin
               
                -- muxB      00-> 0x0   01->B      10->DOUT   11->LIT
                
                -- selectAlu 000->ADD   001->SUB   010->AND   011->OR   100->XOR   101->NOT   110->SHL   111->SHR
                
                --sadd       00-> LIT 01-> SP 10-> B 11->0000000
                --sdin        0->ALU 1->Adder
                --spc         0->lit 1->dout
                -- Leer
--incsp|decsp|spc|sadd|sdin|loadPC|loadA|loadB|selectMuxA|selectMuxB|selectALU|Write (11bits)
with OPcode select
                --MOV
naturalSigs <=  "00000000000000000" when "0000000", --NOP
                "00000000110000000" when "0000001", --MOV B,A
                "00000001000110000" when "0000010", --MOV A,Lit
                "00000000100110000" when "0000011", --MOV B,Lit
                "00000001000100000" when "0000100", --MOV A,(Dir)
                "00000000100100000" when "0000101", --MOV B,(Dir)
                "00000000010000001" when "0000110", --MOV (Dir),A
                "00000000000010001" when "0000111", --MOV (Dir),B
                "00010001000100000" when "0001000", --MOV A,(B)
                "00010000100100000" when "0001001", --MOV B,(B)
                "00010000010000001" when "0001010", --MOV (B),A
                "00000001010010000" when "0001011", --ADD A,B
                "00000000110010000" when "0001100", --ADD B,A
                "00000001010110000" when "0001101", --ADD A,Lit
                "00000001010110000" when "0001110", --ADD A,(Dir)
                "00010001010100000" when "0001111", --ADD A,(B)
                "00000000010010001" when "0010000", --ADD (Dir)
                "00000001010010010" when "0010001", --SUB A,B
                "00000000110010010" when "0010010", --SUB B,A
                "00000001010100010" when "0010011", --SUB A,(Dir)
                "00010001010100010" when "0010100", --SUB A,(B)
                "00000000010010011" when "0010101", --SUB (Dir)
                "00000001010010100" when "0010110", --AND A,B
                "00000000110010100" when "0010111", --AND B,A
                "00000001010110100" when "0011000", --AND A,Lit
                "00000001010100100" when "0011001", --AND A,(Dir)
                "00010001010100100" when "0011010", --AND A,(B)
                "00000000010010101" when "0011011", --AND (Dir)
                "00000001010010110" when "0011100", --OR A,B
                "00000000110010110" when "0011101", --OR B,A
                "00000001010110110" when "0011110", --OR A,Lit
                "00000001010100110" when "0011111", --OR A,(Dir)
                "00010001010100110" when "0100000", --OR A,(B)
                "00000000010010111" when "0100001", --OR (Dir)
                "00000001010001010" when "0100010", --NOT A
                "00000000110001010" when "0100011", --NOT B,A
                "00000001010011000" when "0101000", --XOR A,B
                "00000000110011000" when "0101001", --XOR B,A
                "00000001010111000" when "0101010", --XOR A,Lit
                "00000001010101000" when "0101011", --XOR A,(Dir)
                "00010001010101000" when "0101100", --XOR A,(B)
                "00000000010011001" when "0101101", --XOR (Dir)
                "00000001010001100" when "0101110", --SHL A
                "00000000110001100" when "0101111", --SHL B,A
                "00000000010011101" when "0110011", --SHL (Dir),A
                "00000001010001110" when "0110100", --SHR A
                "00000000110001110" when "0110101", --SHR B,A
                "00000000010011111" when "0111001", --SHR (Dir),A
                "00010000001100001" when "0111010", --INC (B)
                "00000000010010010" when "0111011", --CMP A,B
                "00000000010110010" when "0111100", --CMP A,Lit
                "00000010000000000" when "0111101", --JMP Ins
                "00000000110110000" when "1000000", --ADD B,Lit
                "00000000110100000" when "1000001", --ADD B,(Dir)
                "00000001010110010" when "1000010", --SUB A,Lit
                "00000000110110010" when "1000011", --SUB B,Lit
                "00000000110100011" when "1000100", --SUB B,(Dir)
                "00000000110110100" when "1000101", --AND B,Lit
                "00101010000000000" when "1000110", --RET
                "00000000110110110" when "1000111", --OR B,Lit
                "00000000110100110" when "1001000", --OR B,(Dir)
                "00000000110111000" when "1001001", --XOR B,Lit
                "00000000110101000" when "1001010", --XOR B,(Dir)
                "00000000001100001" when "1001011", --INC (Dir)
                "00000000010100010" when "1001100", --CMP A,(Dir)
                "00000010000000000" when "1001101", --JEQ Ins
                "00000010000000000" when "1001110", --JNE Ins
                "00000010000000000" when "1001111", --JGT Ins
                "00000010000000000" when "1010000", --JLT Ins
                "00000010000000000" when "1010001", --JGE Ins
                "00000010000000000" when "1010010", --JLE Ins
                "00000010000000000" when "1010011", --JCR Ins
                "00000000010001011" when "1010100", --NOT (Dir),A
                "00010000010001011" when "1010101", --NOT (B),A
                "00000000110100100" when "1010110", --AND B,(Dir)
                "00010000110100000" when "1011000", --ADD B,(B)
                "00010000110100010" when "1011010", --SUB B,(B)
                "00010000110100100" when "1011011", --AND B,(B)
                "00010000110100110" when "1011100", --OR B,(B)
                "01001110000000001" when "1011101", --CALL Dir
                "01001000010000001" when "1011110", --PUSH A
                "01001000000010001" when "1011111", --PUSH B
                "00001001000100000" when "1100000", --POP A
                "00001000100100000" when "1100001", --POP B
                "00010000110101000" when "1100010", --XOR B,(B)
                "00010000010001101" when "1100011", --SHL (B),A
                "00010000010001111" when "1100100", --SHR (B),A
                "00010000010100010" when "1100111", --CMP A,(B)
                "00000001011000000" when "1101000", --IN A,Lit
                "00000000111000000" when "1101001", --IN B,Lit
                "00010000011000001" when "1101010", --IN (B),Lit
                "01000000000000000" when "1101011", --DEC SP
                "10000000000000000" when "1101100", --INC SP
                "00000000101010000" when "1101110", -- INC B
                "00000001000010000" when "1111110", --MOV A,B
                "00000000000000000" when others;

end Behavioral;
