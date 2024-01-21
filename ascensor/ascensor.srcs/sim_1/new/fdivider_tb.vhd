library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity fdivider_tb is
end;

architecture bench of fdivider_tb is

  component fdivider is
    Port ( CLK : in  STD_LOGIC;
           frecuencia: integer := 50000000;  -- default value is for 1hz
           clk_out : out  STD_LOGIC );
  end component;

  signal clk: STD_LOGIC;
  signal clk_out1, clk_out2: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock : boolean;
  
begin

  uut1: fdivider port map ( CLK => clk,
                            frecuencia => 3,
                            clk_out => clk_out1 );
  uut2: fdivider port map ( CLK => clk,
                            frecuencia => 2,
                            clk_out => clk_out2 );                               
                                                           
  stimulus: process
  begin
 
    wait for 500 ns;

    stop_the_clock <= true;
    
    assert false
      report "[SUCCESS]: simulation finished."
      severity failure;
      
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;