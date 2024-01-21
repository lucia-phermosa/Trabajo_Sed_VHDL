library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity fsm_tb is
end;

architecture bench of fsm_tb is

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

  signal CLK: std_logic;
  signal RESET: std_logic;
  signal piso_actual: std_logic_vector(3 downto 0);
  signal piso_deseado: std_logic_vector(3 downto 0);
  signal motorDoor: std_logic_vector(1 downto 0);
  signal UP_DOWN: std_logic_vector(1 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: fsm port map ( CLK          => CLK,
                      RESET        => RESET,
                      piso_actual  => piso_actual,
                      piso_deseado => piso_deseado,
                      motorDoor    => motorDoor,
                      UP_DOWN      => UP_DOWN );

  reset <= '0', '1' after 0.25*clock_period;
   
  stimulus: process
  begin
  
    piso_actual <= "0000";
    piso_deseado <= "0011";
    wait for 200 ns;
    
    piso_actual <= "0011";
    piso_deseado <= "0001";
    wait for 200 ns;

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