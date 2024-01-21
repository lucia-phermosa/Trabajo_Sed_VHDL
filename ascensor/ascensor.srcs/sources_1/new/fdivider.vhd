library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity fdivider is
    port ( 
           CLK : in  STD_LOGIC;
           frecuencia: integer;  
           clk_out : out  STD_LOGIC 
     );
end fdivider;

architecture Behavioral of fdivider is
    signal clk_sig: std_logic := '0';
    signal count: integer := 0;
begin

  process (CLK)
  begin
		if rising_edge(CLK) then
			count <= count + 1;
            if (count = frecuencia) then
				count <= 0;
				clk_sig <= not(clk_sig);
			end if;
		end if;
  end process;
  
  clk_out <= clk_sig;
  
end Behavioral;

