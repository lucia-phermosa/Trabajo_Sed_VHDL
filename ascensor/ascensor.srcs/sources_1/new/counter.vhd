library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity counter is
    port(
        CLK : in std_logic;
        RESET : in std_logic;
        piso_deseado : in std_logic_vector(3 downto 0);
        UP : in std_logic_vector(1 downto 0);
        piso_act : out std_logic_vector(3 downto 0)
    );
end counter;

architecture Behavioral of counter is
    
    component fdivider
        port ( 
            CLK     : in std_logic;
            frecuencia : in integer := 1000 ; 
            clock_out : out std_logic
        );
    end component;

    -- Señal de reloj
    signal clk_out2 : std_logic;

    signal q_i : unsigned(3 downto 0);

begin

    prescaler2: fdivider 
    port map
    (
        CLK => CLK,
        frecuencia => 1, 
        clock_out => clk_out2
    );

    process(clk_out2, RESET)
    begin
        if(RESET = '0') then
            q_i <= (others => '0');
        elsif rising_edge(clk_out2) then
            if(UP = "10") then
                 q_i <= q_i + 1;
            elsif (UP = "01") then
                 q_i <= q_i - 1;
            end if;
        end if;
    end process;
    piso_act <= std_logic_vector(q_i);
end Behavioral;