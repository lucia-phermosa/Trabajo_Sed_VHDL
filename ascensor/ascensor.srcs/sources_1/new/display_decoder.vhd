library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_decoder is
	port(
		motorDoor : in std_logic_vector(1 downto 0);
		FLOOR : in std_logic_vector(3 downto 0);
		code : out std_logic_vector(23 downto 0);
		LED : out std_logic_vector(1 downto 0)
	);	
end entity;

architecture Behavioral of display_decoder is
begin

	process(FLOOR, motorDoor)
	begin
	    -- Información que se va a almacenar en función de la planta en la que nos encontramos
		case FLOOR is
		    -- Planta Baja
			when "0000" => 	
				code(15 downto 4) <= (others => '1');
				code(3 downto 0) <= (others => '0');
		    -- Piso 1
			when "0001" => 
				code(15 downto 8) <= (others => '1');
				code(7 downto 4) <= "0001";
				code(3 downto 0) <= (others => '1');
		    -- Piso 2
			when "0010" =>
				code(15 downto 12) <= (others => '1');
				code(11 downto 8) <= "0010";
				code(7 downto 0) <= (others => '1');
		    -- Piso 3
			when "0011" => 
				code(15 downto 12) <= "0011";
				code(11 downto 0) <= (others => '1');
			-- Error
			when others => code <= (others => '1');
		end case;
		
		-- Información que se va a almacenar en función del estado de las puertas
		case motorDoor is
		    -- Puertas abiertas
			when "00" => 
			     code(23 downto 16) <= (others => '1');
			     LED <= "11";
			-- Puertas cerrándose
			when "01" => 
			     code(23 downto 16) <= "01001000";
			     LED <= "00";
			-- Puertas abriéndose
			when "10" => 
			     code(23 downto 16) <= "10000100";
			     LED <= "00";
			-- Puertas cerradas
			when "11" => 
			     code(23 downto 16) <= (others => '1');
			     LED <= "00";
			-- Error
			when others => 
			     code(23 downto 16) <= (others => '1');
			     LED <= "00";
		end case;
	end process;
	
end Behavioral;