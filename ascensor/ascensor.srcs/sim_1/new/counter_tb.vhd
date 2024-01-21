library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity counter_tb is
end;

architecture bench of counter_tb is

  component counter
      port(
          CLK : in std_logic;
          RESET : in std_logic;
          UP : in std_logic_vector(1 downto 0);
          piso_act : out std_logic_vector(3 downto 0)
      );
  end component;

  signal CLK: std_logic;
  signal RESET: std_logic;
  signal UP: std_logic_vector(1 downto 0);
  signal piso_act: std_logic_vector(3 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: counter port map ( CLK          => CLK,
                          RESET        => RESET,
                          UP           => UP,
                          piso_act     => piso_act );

  RESET <= '0', '1' after 0.25*clock_period;
  
  stimulus: process
  begin

    UP <= "10";
    wait for 30 ns;
    
    UP <= "01";
    wait for 20 ns;
    
    UP <= "00";
    wait for 20 ns;
    stop_the_clock <= true;
    
    assert false
      report "[SUCCESS]: simulation finished."
      severity failure;
      
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
