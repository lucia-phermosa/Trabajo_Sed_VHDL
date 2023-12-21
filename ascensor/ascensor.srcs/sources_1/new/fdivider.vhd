library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity fdivider is
  Port ( 
       CLK     : in std_logic;
       PSE_FREQ      : in integer := 1000 ; -- Desired Hz -- Uncomment when using with receiving signal
       PSE_OUT : out std_logic
  );
end fdivider;

architecture Behavioral of fdivider is
constant kCLK_FREQ : integer := 100000000; --kHz To the package
--constant PSE_FREQ : integer := 8000; -- Desired Hz -- Comment when using input
signal sPSE_COUNTER : integer := 0; 
signal sPSE_CNT_MAX : integer := kCLK_FREQ / PSE_FREQ; --kHz To the package
signal sPSE_OUT      : std_logic := '0';

begin

PSE_OUT <= sPSE_OUT;
process (CLK)
begin
    if (rising_edge(CLK)) then
        sPSE_COUNTER <= sPSE_COUNTER + 1;
        if (sPSE_COUNTER > sPSE_CNT_MAX) then
            sPSE_COUNTER <= 0;
        elsif (sPSE_COUNTER = sPSE_CNT_MAX) then
            sPSE_OUT <= not SPSE_OUT;
        end if;
    end if;
end process ;
end Behavioral;
