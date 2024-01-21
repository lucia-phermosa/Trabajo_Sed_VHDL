library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity timer_tb is
end;

architecture bench of timer_tb is

  component timer
      port(
          CLK : in std_logic;
          RESET : in std_logic;
          timer_value : in integer;
          CE : in std_logic;
          C_OUT : out std_logic
      );
  end component;

  signal CLK: std_logic;
  signal RESET: std_logic;
  signal timer_value: integer;
  signal CE: std_logic;
  signal C_OUT: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: timer port map ( CLK         => CLK,
                        RESET       => RESET,
                        timer_value => timer_value,
                        CE          => CE,
                        C_OUT       => C_OUT );

  reset <= '0', '1' after 0.25*clock_period;
  
  stimulus: process
  begin
  
    timer_value <= 2;
    CE <= '1';
    wait for 200 ns;
    
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;

