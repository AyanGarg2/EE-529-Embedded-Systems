library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity q1_behavioral_tb is
end q1_behavioral_tb;

architecture Behavioral of q1_behavioral_tb is
    component q1_behavioral
        Port (
            clk : in  std_logic;
            reset : in  std_logic;
            w   : in  std_logic;
            z   : out std_logic
        );
    end component;

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal w   : std_logic := '0';
    signal z   : std_logic;

begin

    uut: q1_behavioral
        port map (
            clk => clk,
            reset => reset,
            w   => w,
            z   => z
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    rst_process : process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait;
    end process;


    stim_proc: process
    begin
        wait until reset = '0';

        w <= '1'; wait for 10 ns;
        w <= '1'; wait for 10 ns;
        w <= '1'; wait for 10 ns;
        w <= '1'; wait for 10 ns;
        w <= '1'; wait for 10 ns;

        w <= '0'; wait for 10 ns;
        w <= '0'; wait for 10 ns;

        w <= '1'; wait for 10 ns;

        w <= '0'; wait for 10 ns;
        w <= '0'; wait for 10 ns;
        w <= '0'; wait for 10 ns;
        w <= '0'; wait for 10 ns;

        assert false
            report "Simulation completed successfully"
            severity failure;
    end process;

end Behavioral;
