library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity display_decoder_tb is
end;

architecture bench of display_decoder_tb is

  component display_decoder
  	port(
  		motorDoor : in std_logic_vector(1 downto 0);
  		FLOOR : in std_logic_vector(3 downto 0);
  		code : out std_logic_vector(23 downto 0);
  		LED : out std_logic_vector(1 downto 0)
  	);	
  end component;

  signal motorDoor: std_logic_vector(1 downto 0);
  signal FLOOR: std_logic_vector(3 downto 0);
  signal code: std_logic_vector(23 downto 0);
  signal LED: std_logic_vector(1 downto 0) ;

begin

  uut: display_decoder port map ( motorDoor => motorDoor,
                                  FLOOR     => FLOOR,
                                  code      => code,
                                  LED       => LED );

  stimulus: process
  begin
  
    FLOOR <= "0000";
    motorDoor <= "00";
    wait for 2 ns;
    
    FLOOR <= "0000";
    motorDoor <= "01";
    wait for 3 ns;
    
    FLOOR <= "0001";
    motorDoor <= "11";
    wait for 3 ns;
    
    FLOOR <= "0001";
    motorDoor <= "10";
    wait for 2 ns;
    
    FLOOR <= "0001";
    motorDoor <= "00";
    wait for 2 ns;
    
    assert false
      report "[SUCCESS]: simulation finished."
      severity failure;
      
    wait;
  end process;

end;
