library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( numA        : in  std_logic_vector (15 downto 0);
           numB        : in  std_logic_vector (15 downto 0);
           sel      : in  std_logic_vector (2 downto 0);
           ci       : in  std_logic;
           res   : out std_logic_vector (15 downto 0);
           Z    : out std_logic;
           N    : out std_logic;
           co       : out std_logic
           );

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
    Port (  aXOR : in STD_LOGIC_VECTOR (15 downto 0);
            bXOR : in STD_LOGIC_VECTOR (15 downto 0);
            oXOR : out STD_LOGIC_VECTOR (15 downto 0));
    end component;

component OR16b is
    Port (  aOR : in STD_LOGIC_VECTOR (15 downto 0);
            bOR : in STD_LOGIC_VECTOR (15 downto 0);
            oOR : out STD_LOGIC_VECTOR (15 downto 0));
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

--Cables de conexion

signal opR0 : STD_LOGIC_VECTOR (15 downto 0);
signal opR1 : STD_LOGIC_VECTOR (15 downto 0);
signal opR2 : STD_LOGIC_VECTOR (15 downto 0);
signal opR3 : STD_LOGIC_VECTOR (15 downto 0);
signal opR4 : STD_LOGIC_VECTOR (15 downto 0);
signal opR5 : STD_LOGIC_VECTOR (15 downto 0);
signal opR6 : STD_LOGIC_VECTOR (15 downto 0);
signal opR7 : STD_LOGIC_VECTOR (15 downto 0);

--Resultado interno
signal iCo : STD_LOGIC;
signal iZ : STD_LOGIC;
signal iRes : STD_LOGIC_VECTOR (15 downto 0);
begin
--Mux de seleccion de los cables
with sel select
    iRes <=  opR0 when "000",
            opR1 when "001",
            opR2 when "010",
            opR3 when "011",
            opR4 when "100",
            opR5 when "101",
            opR6 when "110",
            opR7 when "111",
            "0000000000000000" when others;

co <= iCo;

--Cero
with iCo select
    Z <= iZ when '0',
         '0' when others;
with iRes select
    iZ <= '1' when "0000000000000000",
         '0' when others;
--Negativo
with iRes(15) select
    N <= '1' when '1',
         '0' when others;
            
res <= iRes;
--Operadores modulares
inst_ADD: ADD16b port map
(
    word1 => numA,
    word2 => numB,
    sCin => ci,
    sCout => iCo,
    sSum => opR0
);
inst_SUS: SUS16b port map
(
    rWord1 => numA,
    rWord2 => numB,
    rest => opR1
);

inst_AND: AND16b port map
(
    aAnd => numA,
    bAnd => numB,
    oAnd => opR2
);
inst_OR: OR16b port map
(
    aOR => numA,
    bOR => numB,
    oOR => opR3
);
inst_XOR: XOR16b port map
(
    aXOR => numA,
    bXOR => numB,
    oXOR => opR4
);
inst_NOT: NOT16b port map
(
    inNot => numA,
    outNot => opR5
);
inst_sh16bL: ShiftL16b port map
(
    inShiftL => numA,
    outShiftL => opR6
);
inst_sh16bR: ShiftR16b port map
(
    inShiftR => numA,
    outShiftR => opR7
);
--Fin operadores
end Behavioral;
