library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity q1_behavioral is
    Port (
        clk   : in  std_logic;
        reset : in  std_logic;
        w     : in  std_logic;
        z     : out std_logic
    );
end q1_behavioral;

architecture behavioral of q1_behavioral is

    type state_type is (
        S0,
        S1, S2, S3, S4,
        S5, S6, S7, S8
    );

    signal current_state, next_state : state_type;

begin

    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= S0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;


    process(current_state, w)
    begin
        case current_state is

            when S0 =>
                if w = '0' then
                    next_state <= S1;
                else
                    next_state <= S5;
                end if;

            when S1 =>
                if w = '0' then next_state <= S2;
                else           next_state <= S5;
                end if;

            when S2 =>
                if w = '0' then next_state <= S3;
                else           next_state <= S5;
                end if;

            when S3 =>
                if w = '0' then next_state <= S4;
                else           next_state <= S5;
                end if;

            when S4 =>
                if w = '0' then next_state <= S4; 
                else           next_state <= S5;
                end if;

            when S5 =>
                if w = '1' then next_state <= S6;
                else           next_state <= S1;
                end if;

            when S6 =>
                if w = '1' then next_state <= S7;
                else           next_state <= S1;
                end if;

            when S7 =>
                if w = '1' then next_state <= S8;
                else           next_state <= S1;
                end if;

            when S8 =>
                if w = '1' then next_state <= S8;
                else           next_state <= S1;
                end if;

        end case;
    end process;

    process(current_state)
    begin
        case current_state is
            when S4 | S8 =>
                z <= '1';
            when others =>
                z <= '0';
        end case;
    end process;

end behavioral;



