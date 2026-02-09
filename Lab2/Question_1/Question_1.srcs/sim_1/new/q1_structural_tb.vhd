library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity q1_structural_tb is
end q1_structural_tb;

architecture Behavioral of q1_structural_tb is

    component q1_structural
        port (
            clk   : in  std_logic;
            reset : in  std_logic;
            w     : in  std_logic;
            z     : out std_logic
        );
    end component;

    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';
    signal w     : std_logic := '0';
    signal z     : std_logic;

begin

    DUT : q1_structural
        port map (
            clk   => clk,
            reset => reset,
            w     => w,
            z     => z
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

    reset_process : process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait;
    end process;

    stim_proc : process
    begin
        wait until reset = '0';

        wait until rising_edge(clk); w <= '1';
        wait until rising_edge(clk); w <= '1';
        wait until rising_edge(clk); w <= '1';
        wait until rising_edge(clk); w <= '1';
        wait until rising_edge(clk); w <= '1';

        wait until rising_edge(clk); w <= '0';
        wait until rising_edge(clk); w <= '0';

        wait until rising_edge(clk); w <= '1';

        wait until rising_edge(clk); w <= '0';
        wait until rising_edge(clk); w <= '0';
        wait until rising_edge(clk); w <= '0';
        wait until rising_edge(clk); w <= '0';
        wait until rising_edge(clk); w <= '0';
        wait until rising_edge(clk); w <= '0';

        assert false
            report "Simulation completed successfully"
            severity failure;
    end process;

end Behavioral;
