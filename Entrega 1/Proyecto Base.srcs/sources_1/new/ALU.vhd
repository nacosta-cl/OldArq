library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( numA        : in  std_logic_vector (15 downto 0);
           numB        : in  std_logic_vector (15 downto 0);
           sel      : in  std_logic_vector (2 downto 0);
           ci       : in  std_logic;
           co       : out std_logic;
           res   : out std_logic_vector (15 downto 0));
end ALU;

architecture Behavioral of ALU is

component ADD16b
    Port (  word1 : in STD_LOGIC_VECTOR (15 downto 0);
            word2 : in STD_LOGIC_VECTOR (15 downto 0);   
            sCin : in STD_LOGIC;
            sSum : out STD_LOGIC_VECTOR (15 downto 0);
            sCout : out STD_LOGIC
    );
    end component;
    
component SUS16b 
    Port (  rWord1 : in STD_LOGIC_VECTOR (15 downto 0);
            rWord2 : in STD_LOGIC_VECTOR (15 downto 0);
            rest : out STD_LOGIC_VECTOR (15 downto 0)
    );
    end component;    

component AND16b 
    Port (  aAnd : in STD_LOGIC_VECTOR (15 downto 0);
            bAnd : in STD_LOGIC_VECTOR (15 downto 0);
            oAnd : out STD_LOGIC_VECTOR (15 downto 0));
    end component;
    
component XOR16b is
    Port ( aXOR : in STD_LOGIC_VECTOR (15 downto 0);
       bXOR : in STD_LOGIC_VECTOR (15 downto 0);
       oXOR : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

component OR16b is
    Port ( aOR : in STD_LOGIC_VECTOR (15 downto 0);
       bOR : in STD_LOGIC_VECTOR (15 downto 0);
       oOr : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

component NOT16b is
    Port ( inNot : in STD_LOGIC_VECTOR (15 downto 0);
           outNot : out STD_LOGIC_VECTOR (15 downto 0));
    end component;
    
component ShiftL16b is
    Port ( inShiftL : in STD_LOGIC_VECTOR (15 downto 0);
       outShiftL : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

component ShiftR16b is
    Port ( inShiftR : in STD_LOGIC_VECTOR (15 downto 0);
       outShiftR : out STD_LOGIC_VECTOR (15 downto 0));
    end component;
begin
    
inst_ADD: ADD16b Port map
(
    word1 =>
)
inst_SUS:
inst_AND:
inst_OR:
inst_XOR:
inst_NOT:
inst_sh16bL:
inst_sh16bR:
    

end Behavioral;
