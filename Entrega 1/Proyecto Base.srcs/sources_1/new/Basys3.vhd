library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (2 downto 0);
        btn         : in   std_logic_vector (4 downto 0);  -- 0 Center, 1 Up, 2 Left, 3 Right, 4 Down
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

signal exNum1 : STD_LOGIC_VECTOR (15 downto 0);
signal exNum2 : STD_LOGIC_VECTOR (15 downto 0);
signal res : STD_LOGIC_VECTOR (15 downto 0);

signal clock  : std_logic;                     
            
signal dis_a : std_logic_vector(3 downto 0);
signal dis_b : std_logic_vector(3 downto 0);
signal dis_c : std_logic_vector(3 downto 0);
signal dis_d : std_logic_vector(3 downto 0);
signal atob : std_logic;

begin

exNum1 <= "0101011101010101";
exNum2 <= "0001111110111110";

dis_a <= res(15 downto 12);
dis_b <= res(11 downto 8);
dis_c <= res(7 downto 4);
dis_d <= res(3 downto 0);

--inst_ADD16b: ADD16b port map
--    (
--        word1 => exNum1,
--        word2 => exNum2,
--        sCin  => '0',
--        sSum  => res
--    );

inst_AND16b: AND16b port map
    (
        aAnd =>exNum1,
        bAnd =>exNum2,
        oAnd =>res
    );

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

    
end Behavioral;
