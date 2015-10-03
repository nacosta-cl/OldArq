--CPU Básico de 16 bits
--v0.0.2.1
--IIC2343 - Arquitectura de computadores
--Integrantes
--  Nicolás Acosta Huenulef
--  Benjamin Rigonesi
--  Jorge Trincado
--  Nicolás Julio
--  Cristobal Gomara

--Comentarios Generales
--Todos los arreglos que dicen downto son little endian

--Entidad raiz
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (2 downto 0);
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
            ALUstatus   : in std_logic_vector (2 downto 0);
            enabRegA    : out std_logic;
            enabRegB    : out std_logic;
            selMuxA     : out std_logic_vector (1 downto 0);
            selMuxB     : out std_logic_vector (1 downto 0);
            selALU      : out std_logic_vector (2 downto 0);
            write       : out std_logic;
            LPC         : out std_logic);
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
    Port ( e1 : in STD_LOGIC_VECTOR (15 downto 0);
           e2 : in STD_LOGIC_VECTOR (15 downto 0);
           e3 : in STD_LOGIC_VECTOR (15 downto 0);
           e4 : in STD_LOGIC_VECTOR (15 downto 0);
           mSelect  : in STD_LOGIC_VECTOR (1 downto 0);
           muxOut : out STD_LOGIC_VECTOR (15 downto 0) );
end component;

--Fin de componentes

--Inicio de señales

--ALU
signal ALUnumA      : STD_LOGIC_VECTOR (15 downto 0);
signal ALUnumB      : STD_LOGIC_VECTOR (15 downto 0);
signal ALUres       : STD_LOGIC_VECTOR (15 downto 0);
signal ALUstatus    : STD_LOGIC_VECTOR (2 downto 0);
signal ALUselect    : STD_LOGIC_VECTOR (2 downto 0);

--ROM
signal PCaddr    : STD_LOGIC_VECTOR(11 downto 0);
signal instrLit  : std_logic_vector(32 downto 0);

signal addr      : STD_LOGIC_VECTOR(11 downto 0);   --Conecta a RAM y PC
signal lit       : std_logic_vector(15 downto 0);
signal instr     : std_logic_vector(16 downto 0);

--Señales de control

signal loadPC   : STD_LOGIC;
signal enabRegA : STD_LOGIC;
signal enabRegB : STD_LOGIC;
signal selMuxA  : STD_LOGIC_VECTOR (1 downto 0);
signal selMuxB  : STD_LOGIC_VECTOR (1 downto 0);
signal selAlu   : STD_LOGIC_VECTOR (2 downto 0);
signal write    : STD_LOGIC;

--Salida de la RAM

signal RAMdOut  : STD_LOGIC_VECTOR (15 downto 0);

--Salidas de los registros

signal reg1 : STD_LOGIC_VECTOR (15 downto 0);
signal reg2 : STD_LOGIC_VECTOR (15 downto 0);

signal numA      : STD_LOGIC_VECTOR (15 downto 0);
signal numB      : STD_LOGIC_VECTOR (15 downto 0);
-- Integrados: reloj, display
signal clock  : std_logic;                     
            
signal dis_a : std_logic_vector(3 downto 0);
signal dis_b : std_logic_vector(3 downto 0);
signal dis_c : std_logic_vector(3 downto 0);
signal dis_d : std_logic_vector(3 downto 0);

--A la pantalla
signal display : STD_LOGIC_VECTOR (15 downto 0);
signal switches : STD_LOGIC_VECTOR (2 downto 0);
--cable vacío
signal nulo : STD_LOGIC;

--Fin señales

begin
--Listado de instancias
--Los componentes se ordenan por complejidad e importancia
--Componentes basicos

instr <= instrLit (32 downto 16); 
addr <= instrLit (11 downto 0);
lit <= instrLit (15 downto 0);

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
--ALU op. Siempre conectado. Operacion de salida elegida mediante un mux
inst_ALU: ALU port map(
        numA => ALUnumA,
        numB => ALUnumB,
        sel => ALUselect,
        ci => '0',
        co => ALUstatus(2),
        res => ALUres,
        Z => ALUstatus(0),
        N => ALUstatus(1)
    );
--ROM
inst_ROM: ROM port map(  
            address => PCaddr,
            dataout => instrLit 
         );
--CU
inst_CU: CU port map( 
        instruc   => instr,
        ALUstatus => ALUstatus,
        enabRegA  => enabRegA,
        enabRegB  => enabRegB,
        selMuxA   => selMuxA,
        selMuxB   => selMuxB,
        selALU    => ALUselect, 
        write     => write,
        LPC       => loadPC
        );
--PC
inst_PC: PC port map(
        clock    => clock,
        load     => loadPC,
        datain   => addr,
        dataout  => PCaddr
    );
--RAM
inst_RAM: RAM port map(
        clock    => clock,
        write    => write,
        address  => addr,
        datain   => ALUres,
        dataout  => RAMdOut
);
--Registros
inst_regA: Reg port map(
        clock    => clock,
        load     => enabRegA,
        up       => '0',
        down     => '0',
        datain   => ALUres,
        dataout  => numA
    );
inst_regB: Reg port map(
        clock    => clock,
        load     => enabRegB,
        up       => '0',
        down     => '0',
        datain   => ALUres,
        dataout  => numB
     );
             
--Muxers
inst_MUXa: MUX_2b port map(
    e1      => "0000000000000000",
    e2      => "0000000000000001",
    e3      => numA,
    e4      => "0000000000000000",
    mSelect => selMuxA,
    muxOut  => ALUnumA
    );
    
inst_MUXb: MUX_2b port map(
    e1      => "0000000000000000",
    e2      => numB,
    e3      => RAMdOut,
    e4      => lit,
    mSelect => selMuxB,
    muxOut  => ALUnumB
    );



--Fin de instancias

--instr <= instrLit(7 downto 0);
--lit <= instrLit(7 downto 0);
--addr <= instrLit(11 downto 0);
--Conexiones internas
--Status en las leds 
led(15 downto 13) <= ALUstatus;

--with 
switches(0)<= sw(0);
switches(1)<= sw(1);
switches(2)<= sw(2);
--switches(3)<= sw(3);
--switches(4)<= sw(4);
--switches(5)<= sw(5);
--switches(6)<= sw(6);
--switches(7)<= sw(7);
--switches(8)<= sw(8);
--switches(9)<= sw(9);
with switches select
    display <= ALUres   when "001",
               numA     when "010",
               numB     when "011",
               RAMdOut  when "100",
               "0000000000000000" when others;
----Envío a los numeros led
dis_a <= display(15 downto 12);
dis_b <= display(11 downto 8);
dis_c <= display(7 downto 4);
dis_d <= display(3 downto 0);
end Behavioral;
