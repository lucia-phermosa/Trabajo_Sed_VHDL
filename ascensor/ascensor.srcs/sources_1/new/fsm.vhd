library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is
    port(
        CLK : in std_logic;
        RESET : in std_logic;
        piso_actual : in std_logic_vector(3 downto 0);
        piso_deseado : in std_logic_vector(3 downto 0);
        motorDoor : out std_logic_vector(1 downto 0); 
        UP_DOWN : out std_logic_vector(1 downto 0)
    );
end fsm;

architecture Behavioral of fsm is 
    
    component timer
        port(
            CLK : in std_logic;
            RESET : in std_logic;
            timer_value : in integer;
            CE : in std_logic;
            C_OUT : out std_logic
        );
    end component;

    type states_type is (IDLE, STANDBY, CLOSING, UP, DOWN, OPENING);
    signal curr_state : states_type := IDLE;
    signal nxt_state : states_type;
    signal btn_memo, nxt_btn_memo : std_logic_vector(3 downto 0);

    signal chip_enable : std_logic;
    signal wait_value : std_logic;
    signal chip_out : std_logic; 
    
begin

    Inst_timer: timer port map
    (
        CLK => CLK,
        RESET => RESET,
        timer_value => wait_value,
        CE => chip_enable,
        C_OUT => chip_out
    );

    state_register: process(RESET, CLK)
    begin
        if (RESET = '0') then
            curr_state <= IDLE;
            btn_memo <= (others => '0');
        elsif rising_edge(CLK) then
            curr_state <= nxt_state;
            btn_memo <= nxt_btn_memo;
        end if;
    end process state_register;
    
    next_state_decoder: process(curr_state, piso_deseado)
    begin
        nxt_state <= curr_state;
        nxt_btn_memo <= btn_memo;
        case curr_state is
            when IDLE => 
                nxt_state <= STANDBY;
            when STANDBY => 
                if (piso_deseado /= piso_actual) then
                    nxt_state <= CLOSING;
                    nxt_btn_memo <= piso_deseado;
                end if;
            when CLOSING =>
                chip_enable <= '1';
                wait_value <= 500;
                if(chip_out = '1') then 
                    if(btn_memo > piso_actual) then
                        nxt_state <= UP;
                    elsif (btn_memo < piso_actual) then
                        nxt_state <= DOWN;
                    end if;
                end if;
            when UP | DOWN => 
                chip_enable <= '0';
                wait_value <= 500;
                if(chip_out = '1') then 
                    if (btn_memo = piso_actual) then
                        nxt_state <= OPENING;
                    end if;
                end if;
           when OPENING =>
                chip_enable <= '1';
                nxt_state <= STANDBY;
           when others => 
                nxt_state <= IDLE;
        end case;
    end process next_state_decoder;
    
    salidas: process(curr_state)
    begin
        motorDoor <= "00";
        UP_DOWN <= "00";
        
        case curr_state is 
            when IDLE =>
                motorDoor <= "00";
                UP_DOWN <= "00";
            when STANDBY =>
                motorDoor <= "00";
                UP_DOWN <= "00";
            when CLOSING => 
                motorDoor <= "01";
                UP_DOWN <= "00";
            when UP => 
                motorDoor <= "11";
                UP_DOWN <= "10";
            when DOWN => 
                motorDoor <= "11";
                UP_DOWN <= "01";
            when OPENING => 
                motorDoor <= "10";
                UP_DOWN <= "00";
        end case;
    end process salidas;
  
end Behavioral;
