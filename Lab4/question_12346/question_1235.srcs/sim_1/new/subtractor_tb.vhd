library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder_subtractor_4bit_tb is
end adder_subtractor_4bit_tb;

architecture Behavioral of adder_subtractor_4bit_tb is

    component adder_subtractor_4bit
        Port (
            A    : in  STD_LOGIC_VECTOR(3 downto 0);
            B    : in  STD_LOGIC_VECTOR(3 downto 0);
            M    : in  STD_LOGIC;
            S    : out STD_LOGIC_VECTOR(3 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    signal A    : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal B    : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal M    : STD_LOGIC := '0';
    signal S    : STD_LOGIC_VECTOR(3 downto 0);
    signal Cout : STD_LOGIC;

begin

    UUT: adder_subtractor_4bit
        port map (
            A    => A,
            B    => B,
            M    => M,
            S    => S,
            Cout => Cout
        );
    stim_proc: process
    begin

        M <= '0';

        -- Test 1: 0 + 0 = 0, Cout = 0
        A <= "0000"; B <= "0000"; wait for 20 ns;
        -- Expected: S = 0000, Cout = 0

        -- Test 2: 3 + 4 = 7, Cout = 0
        A <= "0011"; B <= "0100"; wait for 20 ns;
        -- Expected: S = 0111, Cout = 0

        -- Test 3: 7 + 8 = 15, Cout = 0
        A <= "0111"; B <= "1000"; wait for 20 ns;
        -- Expected: S = 1111, Cout = 0

        -- Test 4: 9 + 6 = 15, Cout = 0
        A <= "1001"; B <= "0110"; wait for 20 ns;
        -- Expected: S = 1111, Cout = 0

        -- Test 7: 5 + 0 = 5, Cout = 0
        A <= "0101"; B <= "0000"; wait for 20 ns;
        -- Expected: S = 0101, Cout = 0

        M <= '1';

        -- Test 9: 5 - 3 = 2, no borrow (Cout = 1)
        A <= "0101"; B <= "0011"; wait for 20 ns;
        -- Expected: S = 0010, Cout = 1

        -- Test 10: 7 - 7 = 0, no borrow (Cout = 1)
        A <= "0111"; B <= "0111"; wait for 20 ns;
        -- Expected: S = 0000, Cout = 1

        -- Test 11: 15 - 1 = 14, no borrow (Cout = 1)
        A <= "1111"; B <= "0001"; wait for 20 ns;
        -- Expected: S = 1110, Cout = 1

        -- Test 16: 8 - 4 = 4, no borrow (Cout = 1)
        A <= "1000"; B <= "0100"; wait for 20 ns;
        -- Expected: S = 0100, Cout = 1

        -- End simulation
        wait;
    end process;

end Behavioral;