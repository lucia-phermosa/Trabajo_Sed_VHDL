library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity button_decoder is
    port(
        button : in std_logic_vector(3 downto 0);
        piso : out std_logic_vector(3 downto 0)
   );
end button_decoder;

architecture dataflow of button_decoder is
begin
    with button select
        piso <= "0000" when "0001", -- Planta Baja
                "0001" when "0010", -- Piso 1
                "0010" when "0100", -- Piso 2
                "0011" when "1000", -- Piso 3
                "1111" when others; -- Error
end dataflow;