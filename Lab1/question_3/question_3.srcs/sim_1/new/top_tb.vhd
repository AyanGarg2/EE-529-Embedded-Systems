library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top is
end tb_top;

architecture Behavioral of tb_top is

    constant N : integer := 8;

    signal a   : signed(N-1 downto 0);
    signal b   : signed(N-1 downto 0);
    signal y   : signed(N-1 downto 0);

begin

    dut : entity work.top
        generic map ( N => N )
        port map (
            a => a,
            b => b,
            y => y
        );

    stim_proc : process
    begin

    a <= to_signed(0, N);
    b <= to_signed(0, N);
    wait for 1 ns;
    
        -- Case 1: Normal addition (10 + 20 = 30)
        a <= to_signed(10, N);
        b <= to_signed(20, N);
        wait for 10 ns;
        assert y = to_signed(30, N)
            report "ERROR: 10 + 20 failed"
            severity error;

        -- Case 2: Positive overflow (127 + 1 = 127)
        a <= to_signed(127, N);
        b <= to_signed(1, N);
        wait for 10 ns;
        assert y = to_signed(127, N)
            report "ERROR: Positive saturation failed"
            severity error;

        -- Case 3: Negative overflow (-128 + -1 = -128)
        a <= to_signed(-128, N);
        b <= to_signed(-1, N);
        wait for 10 ns;
        assert y = to_signed(-128, N)
            report "ERROR: Negative saturation failed"
            severity error;

        -- Case 4: Normal negative addition (-50 + -20 = -70)
        a <= to_signed(-50, N);
        b <= to_signed(-20, N);
        wait for 10 ns;
        assert y = to_signed(-70, N)
            report "ERROR: -50 + -20 failed"
            severity error;

        -- Case 5: Mixed sign (50 + -20 = 30)
        a <= to_signed(50, N);
        b <= to_signed(-20, N);
        wait for 10 ns;
        assert y = to_signed(30, N)
            report "ERROR: 50 + -20 failed"
            severity error;

        report "All saturation adder test cases passed!" severity note;
        wait;
    end process;

end Behavioral;

