library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity fdivider is
  Port ( 
       CLK     : in std_logic;
       frecuencia      : in integer := 1000 ; -- Frecuencia deseada
       clock_out : out std_logic
  );
end fdivider;

architecture Behavioral of fdivider is
constant clk_frec : integer := 100000000; -- Frecuencia del reloj de la fpga (100MHz)
signal count : integer := 0; 
signal max : integer := clk_frec / frecuencia; 
signal signal_out : std_logic := '0';

begin
process (CLK)
begin
    if (rising_edge(CLK)) then
        count <= count + 1;
        if (count >= max) then
            signal_out <= not signal_out;
            count <= 1;
        end if;
    end if;
end process ;
clock_out <= signal_out;
end Behavioral;
