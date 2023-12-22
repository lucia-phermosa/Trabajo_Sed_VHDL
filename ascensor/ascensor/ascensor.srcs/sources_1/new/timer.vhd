library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity timer is
    port(
        CLK : in std_logic;
        RESET : in std_logic;
        timer_value : in integer;
        CE : in std_logic;
        C_OUT : out std_logic
    );
end timer;

architecture Behavioral of timer is
    signal count : integer := 0;
    signal signal_out : std_logic := '0';
begin

    process(CLK, RESET)
    begin
        if (RESET = '0') then
            count <= 0;
            signal_out <= '0';
        elsif rising_edge(CLK) then 
            if (CE = '1') then
                count <= count + 1;
                if (count = timer_value) then
                    signal_out <= '1';
                    count <= 0;
                end if;
            end if;
        end if;
    end process;

    C_OUT <= signal_out;
end Behavioral;