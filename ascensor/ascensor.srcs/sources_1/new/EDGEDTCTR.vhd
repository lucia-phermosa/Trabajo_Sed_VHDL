library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EDGEDTCTR is
     port (
         CLK : in std_logic;
         SYNC_IN : in std_logic_vector(3 downto 0);
         EDGE : out std_logic_vector(3 downto 0)
     );
end EDGEDTCTR;

architecture Behavioral of EDGEDTCTR is
    signal sreg0 : std_logic_vector(2 downto 0);
    signal sreg1 : std_logic_vector(2 downto 0);
    signal sreg2 : std_logic_vector(2 downto 0);
    signal sreg3 : std_logic_vector(2 downto 0);

begin
     process (CLK)
     begin
        if rising_edge(CLK) then
            sreg0 <= sreg0(1 downto 0) & SYNC_IN(0);
            sreg1 <= sreg1(1 downto 0) & SYNC_IN(1);
            sreg2 <= sreg2(1 downto 0) & SYNC_IN(2);
            sreg3 <= sreg3(1 downto 0) & SYNC_IN(3);
        end if;
     end process;
     
     with sreg0 select
        EDGE(0) <= '1' when "100",
                '0' when others;
     with sreg1 select
        EDGE(1) <= '1' when "100",
                '0' when others;
     with sreg2 select
        EDGE(2) <= '1' when "100",
                '0' when others;
     with sreg3 select
        EDGE(3) <= '1' when "100",
                '0' when others;
end Behavioral;