--CPU Básico de 16 bits
--v0.0.2.1
--IIC2343 - Arquitectura de computadores
--Integrantes
--  Nicolás Acosta
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
        sw          : in   std_logic_vector (15 downto 0); -- Señales de entrada de los interruptores -- Arriba   = '1'   -- Los 3 swiches de la derecha: 2, 1 y 0.
        btn         : in   std_logic_vector (4 downto 0);  -- Señales de entrada de los botones       -- Apretado = '1'   -- 0 central, 1 arriba, 2 izquierda, 3 derecha y 4 abajo.
        led         : out  std_logic_vector (3 downto 0);  -- Señales de salida  a  los leds          -- Prendido = '1'   -- Los 4 leds de la derecha: 3, 2, 1 y 0.
        clk         : in   std_logic;                      -- No Tocar - Señal de entrada del clock   -- Frecuencia = 100Mhz.
        seg         : out  std_logic_vector (7 downto 0);  -- No Tocar - Salida de las señales de segmentos.
        an          : out  std_logic_vector (3 downto 0)   -- No Tocar - Salida del selector de diplay.
      );
end Basys3;

architecture Behavioral of Basys3 is

--Inicio de componentes
--Incorporados
component Clock_Divider -- No Tocar
    Port (
        clk         : in    std_logic;
        speed       : in    std_logic_vector (1 downto 0);
        clock       : out   std_logic
          );
    end component;

component Debouncer
    Port (
        clk         : in    std_logic;
        datain      : in    std_logic_vector (4 downto 0);
        dataout     : out   std_logic_vector (4 downto 0));
    end component;

component Timer 
    Port (  
        clk         : in    std_logic;
        seconds     : out   std_logic_vector (15 downto 0);
        mseconds    : out   std_logic_vector (15 downto 0);
        useconds    : out   std_logic_vector (15 downto 0)
          );
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
--En pruebas. Tomado desde el demo de la placa Basys3
--component UART_TX_CTRL
--    Port(
--        SEND : in std_logic;
--        DATA : in std_logic_vector(7 downto 0);
--        CLK : in std_logic;          
--        READY : out std_logic;
--        UART_TX : out std_logic
--        );
--    end component;
--CPU
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
            LPC         : out std_logic;
            jmpBits     : out std_logic_vector (7 downto 0);
            IncSP       : out std_logic;
            DecSP       : out std_logic;
            Spc         : out std_logic;
            Sadd        : out std_logic_vector(1 downto 0);
            Sdin        : out std_logic  
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

component Reg_3b
    Port ( clock    : in  std_logic;
       load     : in  std_logic;
       up       : in  std_logic;
       down     : in  std_logic;
       datain   : in  std_logic_vector (2 downto 0);
       dataout  : out std_logic_vector (2 downto 0));
end component;

component MUX_2b
    Port ( e1 : in STD_LOGIC_VECTOR (15 downto 0);
           e2 : in STD_LOGIC_VECTOR (15 downto 0);
           e3 : in STD_LOGIC_VECTOR (15 downto 0);
           e4 : in STD_LOGIC_VECTOR (15 downto 0);
           mSelect  : in STD_LOGIC_VECTOR (1 downto 0);
           muxOut : out STD_LOGIC_VECTOR (15 downto 0) );
end component;
component MUX_2b_12d
    Port ( e1 : in STD_LOGIC_VECTOR (11 downto 0);
           e2 : in STD_LOGIC_VECTOR (11 downto 0);
           e3 : in STD_LOGIC_VECTOR (11 downto 0);
           e4 : in STD_LOGIC_VECTOR (11 downto 0);
           mSelect  : in STD_LOGIC_VECTOR (1 downto 0);
           muxOut : out STD_LOGIC_VECTOR (11 downto 0) );
end component;
component ADD16b Port 
(
       word1 : in STD_LOGIC_VECTOR (15 downto 0);
       word2 : in STD_LOGIC_VECTOR (15 downto 0);
       sCin : in STD_LOGIC;
       sSum : out STD_LOGIC_VECTOR (15 downto 0);
       sCout : out STD_LOGIC
);
end component;
--Fin de componentes

--Inicio de señales

signal d_btn        : std_logic_vector(4 downto 0);
signal timer_s        : std_logic_vector(15 downto 0);
signal timer_ms        : std_logic_vector(15 downto 0);
signal timer_us        : std_logic_vector(15 downto 0);


--ALU
signal ALUnumA      : STD_LOGIC_VECTOR (15 downto 0);
signal ALUnumB      : STD_LOGIC_VECTOR (15 downto 0);
signal ALUres       : STD_LOGIC_VECTOR (15 downto 0);
signal ALUstatus    : STD_LOGIC_VECTOR (2 downto 0);
signal ALUselect    : STD_LOGIC_VECTOR (2 downto 0);
signal actStatus    : STD_LOGIC_VECTOR (2 downto 0);
--ROM

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
signal writeStatus : STD_LOGIC;


--Salida de la RAM

signal RAMdOut : STD_LOGIC_VECTOR (15 downto 0);
signal RAMaddr : STD_LOGIC_VECTOR (11 downto 0);
signal RAMDin : STD_LOGIC_VECTOR (15 downto 0);
signal RAMdOut12 : STD_LOGIC_VECTOR (11 downto 0);

--Salidas de los registros

signal reg1 : STD_LOGIC_VECTOR (15 downto 0);
signal reg2 : STD_LOGIC_VECTOR (15 downto 0);

signal numA : STD_LOGIC_VECTOR (15 downto 0);
signal numB : STD_LOGIC_VECTOR (15 downto 0);

signal numB12 : STD_LOGIC_VECTOR (11 downto 0);
--PC

signal Spc : STD_LOGIC;
signal selMuxPC : STD_LOGIC_VECTOR(1 downto 0);
signal PCset : STD_LOGIC_VECTOR (11 downto 0);

signal PCaddr : STD_LOGIC_VECTOR (11 downto 0);
signal PCaddr16 : STD_LOGIC_VECTOR (15 downto 0);

signal PCaddrPlus : STD_LOGIC_VECTOR (15 downto 0);
signal Sdin : STD_LOGIC;
signal selMuxDin : STD_LOGIC_VECTOR(1 downto 0);
--SP

signal IncSP: STD_LOGIC;
signal DecSP : STD_LOGIC;
signal SPout : STD_LOGIC_VECTOR(15 downto 0);

signal Sadd : STD_LOGIC_VECTOR (1 downto 0);
-- Integrados: reloj, display

signal clock  : std_logic;                     
            
signal dis_a : std_logic_vector(3 downto 0);
signal dis_b : std_logic_vector(3 downto 0);
signal dis_c : std_logic_vector(3 downto 0);
signal dis_d : std_logic_vector(3 downto 0);

--A la pantalla
signal display : STD_LOGIC_VECTOR (15 downto 0);
signal regValues : STD_LOGIC_VECTOR (15 downto 0);
signal PCdisp : STD_LOGIC_VECTOR (15 downto 0);
signal jbits : STD_LOGIC_VECTOR (15 downto 0);
signal statusBits : STD_LOGIC_VECTOR (15 downto 0);
signal switches : STD_LOGIC_VECTOR (2 downto 0);
--cable vacío
signal nulo : STD_LOGIC;

signal IOlit       : STD_LOGIC_VECTOR (15 downto 0);
signal btnIN       : STD_LOGIC_VECTOR (15 downto 0);
--Controles para el UART
--UART_TX_CTRL control signals
--signal uartRdy : std_logic;
--signal uartSend : std_logic := '0';
--signal uartData : std_logic_vector (7 downto 0):= "00000000";
--signal uartTX : std_logic;

--Fin señales

begin
--Listado de instancias
--Los componentes se ordenan por complejidad e importancia
--Componentes basicos

inst_Clock_Divider: Clock_Divider port map( -- No Tocar - Intancia de Clock_Divider.
    clk         => clk,  -- No Tocar - Entrada del clock completo (100Mhz).
    speed       => "01", -- Selector de velocidad: "00" full, "01" fast, "10" normal y "11" slow. 
    clock       => clock -- No Tocar - Salida del clock reducido: 50Mhz, 8hz, 2hz y 0.5hz.
    );

inst_Debouncer: Debouncer port map(
    clk         => clk,
    datain      => btn,
    dataout     => d_btn
    );

inst_Timer: Timer port map(
    clk         => clk,
    seconds     => timer_s,
    mseconds    => timer_ms,
    useconds    => timer_us
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
--ALU
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
        ALUstatus => actStatus,
        enabRegA  => enabRegA,
        enabRegB  => enabRegB,
        selMuxA   => selMuxA,
        selMuxB   => selMuxB,
        selALU    => ALUselect, 
        write     => write,
        LPC       => loadPC,
        jmpBits   => jBits (7 downto 0),
        IncSP     => IncSP,
        DecSP     => DecSP,
        Spc       => selMuxPC(0),
        Sadd      => Sadd,
        Sdin      => selMuxDin(0)
    );
--PC
inst_PC: PC port map(
        clock    => clock,
        load     => loadPC,
        datain   => PCset,
        dataout  => PCaddr
    );
--RAM
inst_RAM: RAM port map(
        clock    => clock,
        write    => write,
        address  => RAMaddr,
        datain   => RAMDin,
        dataout  => RAMdOut
    );
--Adder
inst_adder: ADD16b port map( 
        word1  => "0000000000000001",
        word2  => PCaddr16,
        sCin   => '0',
        sSum   => PCaddrPlus
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
    
inst_SP: Reg port map(
        clock    => clock,
        load     => '0',
        up       => IncSP,
        down     => DecSP,
        datain   => "0000000000000000",
        dataout  => SPout
    );
    
inst_statusReg: Reg_3b port map(
        clock    => clock,
        load     => '1',--writeStatus,
        up       => '0',
        down     => '0',
        datain   => ALUstatus,
        dataout  => actStatus
    );
                          
--Muxers

inst_MUXDataIn: MUX_2b port map(
        e1      => ALUres,
        e2      => PCaddrPlus,
        e3      => "0000000000000000",
        e4      => "0000000000000000",
        mSelect => selMuxDin,
        muxOut  => RAMDin
    );
    
inst_MUXPC: MUX_2b_12d port map(
        e1      => addr,
        e2      => RAMdout(11 downto 0),
        e3      => "000000000000",
        e4      => "000000000000",
        mSelect => selMuxPC,
        muxOut  => PCset
    );
inst_MUXSP: MUX_2b_12d port map(
        e1      => addr,
        e2      => SPout(11 downto 0),
        e3      => numB12,
        e4      => "000000000000",
        mSelect => Sadd,
        muxOut  => RAMaddr
    );

-- Requiere un mux de 16inst_MUXIO: MUX_2b port map(
--    e1      => ,
--    e2      => ,
--    e3      => numA,
--    e4      => "0000000000000000",
--    mSelect => selMuxA,
--    muxOut  => ALUnumA
--    );


inst_MUXa: MUX_2b port map(
        e1      => "0000000000000000",
        e2      => "0000000000000001",
        e3      => numA,
        e4      => IOlit,
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
inst_MUXIO: MUX_2b port map(
        e1      => btnIN,
        e2      => sw,
        e3      => "0000000000000000",
        e4      => "0000000000000000",
        mSelect => lit(1 downto 0),
        muxOut  => IOlit
    );
--Fin de instancias
--Conexiones internas


instr <= instrLit (32 downto 16); 
addr <= instrLit (11 downto 0);
lit <= instrLit (15 downto 0);
----Conversiones de largo de buses
PCaddr16 (11 downto 0) <= PCaddr;
--MuxPC
selMuxPC(0) <= Spc;
selMuxDin(0) <= Sdin;

RAMdOut12 <= RAMdOut (11 downto 0);
--MuxS
numB12 <= numB (11 downto 0);

----Status en las leds
led(15 downto 13) <= ALUstatus;
led(7 downto 0) <= jBits(7 downto 0);

switches(0)<= sw(0);
switches(1)<= sw(1);
switches(2)<= sw(2);

btnIN(4 downto 0) <= btn;
--Debugger (Ver opción UART)

regValues(15 downto 8) <= numA(7 downto 0);
regValues(7 downto 0) <= numB(7 downto 0);

display <= regValues;
dis_a <= display(15 downto 12);
dis_b <= display(11 downto 8);
dis_c <= display(7 downto 4);
dis_d <= display(3 downto 0);
end Behavioral;
