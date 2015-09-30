--ALU básica
--v1.1
--IIC2343 - Arquitectura de computadores
--Integrantes
--  Nicolás Acosta Huenulef
--  Sebastian Carraedo
--  Benjamin Rigonesi
--  Jorge Trincado
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

signal num1 : STD_LOGIC_VECTOR (15 downto 0);
signal num2 : STD_LOGIC_VECTOR (15 downto 0);
signal nums : STD_LOGIC_VECTOR (15 downto 0);

signal res : STD_LOGIC_VECTOR (15 downto 0);

signal display : STD_LOGIC_VECTOR (15 downto 0);

signal nulo : STD_LOGIC;
--
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
--Registros. No se les entrega un datain, solo los cambios
--Se mueve con izq-der
inst_regA: Reg port map(
        clock    => clock,
        load     => '0',
        up       => btn(3),
        down     => btn(2),
        datain   =>"0000000000000000",
        dataout  => num1
    );
--Se mueve con up-down
inst_regB: Reg port map(
        clock    => clock,
        load     => '0',
        up       => btn(1),
        down     => btn(4),
        datain   => "0000000000000000",
        dataout  => num2
     );
         
--ALU op. Siempre conectado. Operacion de salida elegida mediante un mux
inst_ALU: ALU port map
(
    numA => num1,
    numB => num2,
    sel => sw(2 downto 0),
    ci => '0',
    co => ALUstatus(0),
    res => res,
    Z => ALUstatus(2),
    N => ALUstatus(1)
);
--Fin de instancias



--Selector de información
led(15 downto 13) <= ALUstatus;

with btn(0) select
    display <=  nums when '0',
                res when '1',
                "0000000000000000" when others;

--Creacion del vector para numeros
nums (7 downto 0) <= num2 (7 downto 0);
nums (15 downto 8) <= num1 (7 downto 0);
--Envío a los numeros led
dis_a <= display(15 downto 12);
dis_b <= display(11 downto 8);
dis_c <= display(7 downto 4);
dis_d <= display(3 downto 0);
end Behavioral;
