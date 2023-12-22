library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SYNCHRNZR is
    port (
         CLK : in std_logic;
         ASYNC_IN : in std_logic_vector(3 downto 0);
         SYNC_OUT : out std_logic_vector(3 downto 0)
     );
end SYNCHRNZR;

architecture Behavioral of SYNCHRNZR is
    signal sreg0 : std_logic_vector(1 downto 0);
    signal sreg1 : std_logic_vector(1 downto 0);
    signal sreg2 : std_logic_vector(1 downto 0);
    signal sreg3 : std_logic_vector(1 downto 0);

begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            sync_out(0) <= sreg0(1);
            sreg0 <= sreg0(0) & async_in(0);
            sync_out(1) <= sreg1(1);
            sreg1 <= sreg1(0) & async_in(1);
            sync_out(2) <= sreg2(1);
            sreg2 <= sreg2(0) & async_in(2);
            sync_out(3) <= sreg3(1);
            sreg3 <= sreg3(0) & async_in(3);
        end if;
    end process;

end Behavioral;
