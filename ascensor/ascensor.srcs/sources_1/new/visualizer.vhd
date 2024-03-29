library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity visualizer is
    port(
        CLK : in std_logic;
        RESET : in std_logic;
        motorDoor : in std_logic_vector(1 downto 0);
        FLOOR : in std_logic_vector(3 downto 0);
        LED : out std_logic_vector(1 downto 0);
        seven_seg : out std_logic_vector(6 downto 0);
        AN : out std_logic_vector(7 downto 0)
    );
end visualizer;

architecture Behavioral of visualizer is

    component display_decoder
        port(
            motorDoor : in std_logic_vector(1 downto 0);
            FLOOR : in std_logic_vector(3 downto 0);
            code : out std_logic_vector(23 downto 0);
            LED : out std_logic_vector(1 downto 0)
	   );
    end component;
    
    component display
        port(
            CLK : in std_logic;
            RESET : in std_logic;
            code : in std_logic_vector(23 downto 0);
            seven_seg : out std_logic_vector(6 downto 0);
            AN : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- Variable para almacenar la información que se quiere mostrar en los displays
    -- Como se van a utilizar 6 displays, se necesitan 4 bits por cada uno, 6x4=24 bits
    signal code : std_logic_vector(23 downto 0);
begin

    Inst_decoder: display_decoder port map
    (
        motorDoor => motorDoor,
        FLOOR => FLOOR,
        code => code,
        LED => LED
    );
    
    Inst_display: display port map
    (
            CLK => CLK,
            RESET => RESET,
            code => code,
            seven_seg => seven_seg,
            AN => AN
      );

end Behavioral;
