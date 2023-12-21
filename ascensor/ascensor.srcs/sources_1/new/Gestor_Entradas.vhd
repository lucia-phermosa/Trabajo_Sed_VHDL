library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Gestor_Entradas is
    port(
        CLK : in std_logic;
        RESET : in std_logic;
        BUTTON : in std_logic_vector(3 downto 0);
        piso_out : out std_logic_vector(3 downto 0)
    );
end Gestor_Entradas;

architecture Behavioral of Gestor_Entradas is
    
    component SYNCHRNZR
        port (
             CLK : in std_logic;
             ASYNC_IN : in std_logic_vector(3 downto 0);
             SYNC_OUT : out std_logic_vector(3 downto 0)
        );
    end component;  
    
    component EDGEDTCTR
        port (
             CLK : in std_logic;
             SYNC_IN : in std_logic_vector(3 downto 0);
             EDGE : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component button_decoder
        port(
            button : in std_logic_vector(3 downto 0);
            piso : out std_logic_vector(3 downto 0)
        );
    end component;
    
    -- Señales intermedias del sincronizador
    signal sync_out : std_logic_vector(3 downto 0);
    signal edge_out : std_logic_vector(3 downto 0);

begin
    
    Inst_SYNCHRNZR: SYNCHRNZR port map
    (
         CLK => CLK,
         ASYNC_IN => BUTTON,
         SYNC_OUT => sync_out
    );
    
    Inst_EDGEDTCTR: EDGEDTCTR port map
    (
         CLK => CLK,
         SYNC_IN => sync_out,
         EDGE => edge_out
    );
    
    Inst_button_decoder: button_decoder port map
    (
        button => edge_out,
        piso => piso_out
    );

end Behavioral;
