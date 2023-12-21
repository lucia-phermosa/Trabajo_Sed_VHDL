library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port(
        CLK : in std_logic;
        RESET : in std_logic; 
        BUTTON : in std_logic_vector(3 downto 0);
        LED : out std_logic_vector(1 downto 0);
        seven_seg : out std_logic_vector(6 downto 0);
        AN : out std_logic_vector(7 downto 0)
    );
end top;

architecture Behavioral of top is
    
    component fdivider
        port ( 
            CLK     : in std_logic;
            frecuencia : in integer := 1000 ; 
            clock_out : out std_logic
        );
    end component;
    
    component Gestor_Entradas
        port(
            CLK : in std_logic;
            RESET : in std_logic;
            BUTTON : in std_logic_vector(3 downto 0);
            piso_out : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component fsm
        port(
            CLK : in std_logic;
            RESET : in std_logic;
            piso_actual : in std_logic_vector(3 downto 0);
            piso_deseado : in std_logic_vector(3 downto 0);
            motorDoor : out std_logic_vector(1 downto 0); 
            UP_DOWN : out std_logic_vector(1 downto 0)
         );
    end component;
    
    component counter
        port(
            CLK : in std_logic;
            RESET : in std_logic;
            piso_deseado : in std_logic_vector(3 downto 0);
            UP : in std_logic_vector(1 downto 0);
            piso_act : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component visualizer
         port(
            CLK : in std_logic;
            RESET : in std_logic;
            motorDoor : in std_logic_vector(1 downto 0);
            FLOOR : in std_logic_vector(3 downto 0);
            LED : out std_logic_vector(1 downto 0);
            seven_seg : out std_logic_vector(6 downto 0);
            AN : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- Señales reloj
    signal clk_out1 : std_logic; -- Señal de reloj de salida 1
    signal clk_out2 : std_logic; -- Señal de reloj de salida 2
    
    signal piso_deseado : std_logic_vector(3 downto 0); -- Piso deseado determinado por los botones de entrada
    signal piso : std_logic_vector(3 downto 0); -- Piso actual en el que nos encontramos
    signal motor : std_logic_vector(1 downto 0); -- Motor de las puertas (STANDBY/OPENING/CLOSING)
    signal up_down : std_logic_vector(1 downto 0); -- Motor del ascensor (STANDBY/UP/DOWN)
begin
    
    prescaler1: fdivider 
    port map
    (
        CLK => CLK,
        frecuencia => 1000, 
        clock_out => clk_out1
    );
    
    prescaler2: fdivider 
    port map
    (
        CLK => CLK,
        frecuencia => 1, 
        clock_out => clk_out2
    );
    
    Inst_gestor_entradas: gestor_entradas port map
    (
        CLK => clk_out1,
        RESET => RESET,
        BUTTON => BUTTON,
        piso_out => piso_deseado
    );
    
    Inst_fsm: fsm port map
    (
        CLK => CLK,
        RESET => RESET,
        piso_actual => piso,
        piso_deseado => piso_deseado,
        motorDoor => motor,
        UP_DOWN => up_down
    );
    
    Inst_counter: counter port map
    (
        CLK => clk_out2,
        RESET => RESET,
        piso_deseado => piso_deseado,
        UP => up_down,
        piso_act => piso
    );
    
    Inst_visualizer: visualizer port map
    (
        CLK => CLK,
        RESET => RESET,
        motorDoor => motor,
        FLOOR => piso,
        LED => LED,
        seven_seg => seven_seg,
        AN => AN
    );

end Behavioral;
