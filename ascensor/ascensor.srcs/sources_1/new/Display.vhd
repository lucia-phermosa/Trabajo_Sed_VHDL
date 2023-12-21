library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Display is
    port(
        CLK : in std_logic;
        RESET : in std_logic;
        code : in std_logic_vector(23 downto 0);
        seven_seg : out std_logic_vector(6 downto 0);
        AN : out std_logic_vector(7 downto 0)
    );
end Display;

architecture Behavioral of Display is
    signal bcd : std_logic_vector(3 downto 0);
    signal refresh_count : integer range 0 to 50000;
    signal anodo_count : std_logic_vector(2 downto 0);
begin
    
    decoder: process(bcd)
    begin
        case bcd is 
            when "0000" => seven_seg <= "0000001"; -- "0"
            when "0001" => seven_seg <= "1001111"; -- "1"
            when "0010" => seven_seg <= "0010010"; -- "2"
            when "0011" => seven_seg <= "0000110"; -- "3"
            when "0100" => seven_seg <= "1001110"; -- "-|"
            when "1000" => seven_seg <= "1111000"; -- "|-"
            when others => seven_seg <= "1111111";
        end case;
    end process decoder;
    
    clock_counter: process(CLK)
    begin
        if (RESET = '0') then
            refresh_count <= 0;
            anodo_count <= (others => '0');
            AN <= "11111110";
            bcd <= (others => '0');
        elsif rising_edge(CLK) then
            refresh_count <= refresh_count + 1;
            if (refresh_count = 50000) then
                refresh_count <= 0;
                anodo_count <= anodo_count + '1';
                case anodo_count is 
                    when "000" => 
                        AN <= "11111110";
                        bcd <= code(3 downto 0);
                    when "001" => 
                        AN <= "11111101";
                        bcd <= code(7 downto 4);
                    when "010" => 
                        AN <= "11111011";
                        bcd <= code(11 downto 8);
                    when "011" => 
                        AN <= "11110111";
                        bcd <= code(15 downto 12);
                    when "100" => AN <= "11111111";
                    when "101" => AN <= "11111111";
                    when "110" => 
                        AN <= "10111111";
                        bcd <= code(19 downto 16);
                    when "111" => 
                        AN <= "01111111";
                        bcd <= code(23 downto 20);
                    when others => AN <= "11111110";
                end case;
            end if;
      end if;
   end process clock_counter;
end Behavioral;
