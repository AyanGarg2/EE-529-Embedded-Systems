library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF is
    Port (
        D     : in  std_logic;
        clk   : in  std_logic;
        reset : in  std_logic;
        Q     : out std_logic
    );
end DFF;

architecture bhv of DFF is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            Q <= '0';
        elsif rising_edge(clk) then
            Q <= D;
        end if;
    end process;
end bhv;
