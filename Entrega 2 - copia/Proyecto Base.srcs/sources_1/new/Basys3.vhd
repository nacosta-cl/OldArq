--CPU Básico de 16 bits
--v0.0.1
--IIC2343 - Arquitectura de computadores
--Integrantes
--  Nicolás Acosta Huenulef
--  Benjamin Rigonesi
--  Jorge Trincado
--  Nicolás Julio
--  Cristobal Gomara
--Entidad raiz
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (15 downto 0);
        btn         : in   std_logic_vector (4 downto 0);  -- 0 Center, 1 Up, 2 Left, 3 Right, 4 Down
        led         : out   std_logic_vector (15 downto 0);
        clk         : in   std_logic;
        clk_up      : in   std_logic;
        seg         : out  std_logic_vector (7 downto 0);
        an          : out  std_logic_vector (3 downto 0)
          );
end Basys3;

architecture Behavioral of Basys3 is

--Inicio de componentes

component Clock_Divider
    Port ( clk          : in std_logic;
           clk_up       : in std_logic;
           slow         : in std_logic;
           clock        : out std_logic);
    end component;
    
component Led_Driver
    Port (  dis_a       : in   std_logic_vector (3 downto 0);
            dis_b       : in   std_logic_vector (3 downto 0);
            dis_c       : in   std_logic_vector (3 downto 0);
            dis_d       : in   std_logic_vector (3 downto 0);
            clk         : in   std_logic;
            seg         : out  std_logic_vector (7 downto 0);
            an          : out  std_logic_vector (3 downto 0)
           );
    end component;
    
component RAM
    Port (
        clock       : in   std_logic;
        write       : in   std_logic;
        address     : in   std_logic_vector (11 downto 0);
        datain      : in   std_logic_vector (15 downto 0);
        dataout     : out  std_logic_vector (15 downto 0)
          );
    end component;
    
component ROM
    Port (  address   : in  std_logic_vector(11 downto 0);
            dataout   : out std_logic_vector(32 downto 0)
         );
    end component;
component PC
    Port ( clock    : in  std_logic;
       load     : in  std_logic;
       datain   : in  std_logic_vector (11 downto 0);
       dataout  : out std_logic_vector (11 downto 0));
    end component;
--Unidad de control
component CU
    Port(   instruc     : in std_logic_vector (16 downto 0);
            actStatus   : in std_logic_vector (2 downto 0);
            enabRegA    : out std_logic;
            enabRegB    : out std_logic;
            selMuxA     : out std_logic_vector (1 downto 0);
            selMuxB     : out std_logic_vector (1 downto 0);
            selALU      : out std_logic_vector (2 downto 0);
            write       : out std_logic);
    end component;

component ALU
    Port ( numA        : in  std_logic_vector (15 downto 0);
           numB        : in  std_logic_vector (15 downto 0);
           sel      : in  std_logic_vector (2 downto 0);
           ci       : in  std_logic;
           co       : out std_logic;
           res   : out std_logic_vector (15 downto 0);
           Z    : out std_logic;
           N    : out std_logic);
    end component;
    
component Reg
    Port ( clock    : in  std_logic;
           load     : in  std_logic;
           up       : in  std_logic;
           down     : in  std_logic;
           datain   : in  std_logic_vector (15 downto 0);
           dataout  : out std_logic_vector (15 downto 0));
end component;

component MUX_2b
    Port ( e1 : in STD_LOGIC_VECTOR (16 downto 0);
           e2 : in STD_LOGIC_VECTOR (16 downto 0);
           e3 : in STD_LOGIC_VECTOR (16 downto 0);
           e4 : in STD_LOGIC_VECTOR (16 downto 0);
           mSelect  : in STD_LOGIC_VECTOR (1 downto 0);
           muxOut : in STD_LOGIC_VECTOR (16 downto 0) );
end component;

--Fin de componentes

--Inicio de señales
--Cosas de la ALU
signal ALUnum1 : STD_LOGIC_VECTOR (15 downto 0);
signal ALUnum2 : STD_LOGIC_VECTOR (15 downto 0);

--resultado de la ALU
signal ALUres : STD_LOGIC_VECTOR (15 downto 0);

--A la pantalla
signal display : STD_LOGIC_VECTOR (15 downto 0);

--cable vacío
signal nulo : STD_LOGIC;

--Salidas de los registros
signal reg1 : STD_LOGIC_VECTOR (15 downto 0);
signal reg2 : STD_LOGIC_VECTOR (15 downto 0);

-- Integrados: reloj, display
signal clock  : std_logic;                     
            
signal dis_a : std_logic_vector(3 downto 0);
signal dis_b : std_logic_vector(3 downto 0);
signal dis_c : std_logic_vector(3 downto 0);
signal dis_d : std_logic_vector(3 downto 0);

--ZNC
signal ALUstatus : std_logic_vector(2 downto 0); 

--Fin señales
begin


--Listado de instancias
--Componentes basicos
inst_Clock_Divider: Clock_Divider port map(
        clk         =>clk,
        clk_up      =>clk_up,
        slow        =>'0',
        clock       =>clock
    );

inst_Led_Driver: Led_Driver port map(
		dis_a => dis_a,
		dis_b => dis_b,
        dis_c => dis_c,
		dis_d => dis_d,
        clk => clk,
        seg => seg,
        an => an
	);
--Registros
inst_regA: Reg port map(
        clock    => clock,
        load     => selRegA,
        up       => btn(3),
        down     => btn(2),
        datain   => ALUres,
        dataout  => num1
    );
inst_regB: Reg port map(
        clock    => clock,
        load     => selRegB,
        up       => '0',
        down     => '0',
        datain   => ALUres,
        dataout  => num2
     );
             
--Muxers
inst_MUXa: MUX_2b port map(
    e1      =>
    e2      =>
    e3      =>
    e4      =>
    mSelect =>
    muxOut  =>
    );
    
inst_MUXb: MUX_2b port map(
    e1      =>
    e2      =>
    e3      =>
    e4      =>
    mSelect =>
    muxOut  =>
    );
--Se mueve con up-down

--ALU op. Siempre conectado. Operacion de salida elegida mediante un mux
inst_ALU: ALU port map
(
    numA => ALUnum1,
    numB => ALUnum2,
    sel => sw(2 downto 0),
    ci => '0',
    co => ALUstatus(2),
    res => ALUres,
    Z => ALUstatus(0),
    N => ALUstatus(1)
);
--Fin de instancias



--Selector de información
led(15 downto 13) <= ALUstatus;

--Creacion del vector para numeros
nums (7 downto 0) <= num2 (7 downto 0);
nums (15 downto 8) <= num1 (7 downto 0);
--Envío a los numeros led
dis_a <= display(15 downto 12);
dis_b <= display(11 downto 8);
dis_c <= display(7 downto 4);
dis_d <= display(3 downto 0);
end Behavioral;
