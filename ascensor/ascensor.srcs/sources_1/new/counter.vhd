library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity counter is
    port(
        CLK : in std_logic;
        RESET : in std_logic;
        UP : in std_logic_vector(1 downto 0);
        piso_act : out std_logic_vector(3 downto 0)
    );
end counter;

architecture Behavioral of counter is 
    signal q_i : unsigned(3 downto 0);
begin
    
    process(CLK, RESET)
    begin
        if(RESET = '0') then
            q_i <= (others => '0');
        elsif rising_edge(CLK) then
            if(UP = "10") then
                 q_i <= q_i + 1;
            elsif (UP = "01") then
                 q_i <= q_i - 1;
            end if;
        end if;
    end process;
    
    piso_act <= std_logic_vector(q_i);
    
end Behavioral;
