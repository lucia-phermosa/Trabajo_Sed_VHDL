library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity display_tb is
end;

architecture bench of display_tb is

  component display
      port(
          CLK : in std_logic;
          RESET : in std_logic;
          code : in std_logic_vector(23 downto 0);
          seven_seg : out std_logic_vector(6 downto 0);
          AN : out std_logic_vector(7 downto 0)
      );
  end component;

  signal CLK: std_logic;
  signal RESET: std_logic;
  signal code: std_logic_vector(23 downto 0);
  signal seven_seg: std_logic_vector(6 downto 0);
  signal AN: std_logic_vector(7 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: display port map ( CLK       => CLK,
                          RESET     => RESET,
                          code      => code,
                          seven_seg => seven_seg,
                          AN        => AN );

  reset <= '0', '1' after 0.25*clock_period;
 
  stimulus: process
  begin
    
    code <= X"FFFFF0";
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