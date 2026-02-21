-- Testbench for 4-bit Ripple Carry Adder (RCA)
-- Tests: normal addition, carry propagation, overflow, zero, boundary values

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_RCA_4bit is
end tb_RCA_4bit;

architecture Behavioral of tb_RCA_4bit is

    component RCA_4bit
        Port (
            A    : in  STD_LOGIC_VECTOR(3 downto 0);
            B    : in  STD_LOGIC_VECTOR(3 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(3 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    signal A    : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal B    : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal Cin  : STD_LOGIC := '0';
    signal SUM  : STD_LOGIC_VECTOR(3 downto 0);
    signal Cout : STD_LOGIC;

begin

    UUT: RCA_4bit
        port map (
            A    => A,
            B    => B,
            Cin  => Cin,
            SUM  => SUM,
            Cout => Cout
        );

    stim_proc: process
    begin

        -- ============================================================
        -- Cin = 0 tests
        -- ============================================================
        Cin <= '0';

        -- Test 1: 0 + 0 = 0, Cout = 0
        A <= "0000"; B <= "0000"; wait for 20 ns;
        -- Expected: SUM = 0000, Cout = 0

        -- Test 2: 1 + 1 = 2, Cout = 0
        A <= "0001"; B <= "0001"; wait for 20 ns;
        -- Expected: SUM = 0010, Cout = 0

        -- Test 3: 3 + 4 = 7, Cout = 0
        A <= "0011"; B <= "0100"; wait for 20 ns;
        -- Expected: SUM = 0111, Cout = 0

        -- Test 4: 6 + 9 = 15, Cout = 0
        A <= "0110"; B <= "1001"; wait for 20 ns;
        -- Expected: SUM = 1111, Cout = 0

        -- Test 5: 7 + 8 = 15, Cout = 0
        A <= "0111"; B <= "1000"; wait for 20 ns;
        -- Expected: SUM = 1111, Cout = 0

        -- Test 6: 8 + 8 = 16 (overflow), Cout = 1
        A <= "1000"; B <= "1000"; wait for 20 ns;
        -- Expected: SUM = 0000, Cout = 1

        -- Test 7: 15 + 1 = 16 (overflow), Cout = 1
        A <= "1111"; B <= "0001"; wait for 20 ns;
        -- Expected: SUM = 0000, Cout = 1

        -- Test 8: 15 + 15 = 30 (overflow), Cout = 1
        A <= "1111"; B <= "1111"; wait for 20 ns;
        -- Expected: SUM = 1110, Cout = 1

        -- Test 9: 5 + 0 = 5 (identity), Cout = 0
        A <= "0101"; B <= "0000"; wait for 20 ns;
        -- Expected: SUM = 0101, Cout = 0

        -- Test 10: Carry propagation across all bits: 1 + 15 = 16
        A <= "0001"; B <= "1111"; wait for 20 ns;


        wait;
    end process;

end Behavioral;