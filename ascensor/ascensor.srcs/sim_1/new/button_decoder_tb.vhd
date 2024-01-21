library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity button_decoder_tb is
end;

architecture bench of button_decoder_tb is

  component button_decoder
      port(
          button : in std_logic_vector(3 downto 0);
          piso : out std_logic_vector(3 downto 0)
     );
  end component;

  signal button: std_logic_vector(3 downto 0);
  signal piso: std_logic_vector(3 downto 0) ;

begin

  uut: button_decoder port map ( button => button,
                                 piso   => piso );
                                                                                             
  stimulus: process
  begin
  
    button <= "0001";
    wait for 20 ns;
    button <= "0010";
    wait for 20 ns;
    button <= "0100";
    wait for 20 ns;
    button <= "1000";
    wait for 20 ns;
    
    wait;
  end process;

end;