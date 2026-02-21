library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_CLA_4bit is
end tb_CLA_4bit;

architecture Behavioral of tb_CLA_4bit is

    component CLA_4bit
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

    UUT: CLA_4bit
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
        A <= "0000"; B <= "0000"; wait for 20 ns;
        A <= "0001"; B <= "0001"; wait for 20 ns;
        A <= "0011"; B <= "0100"; wait for 20 ns;
        A <= "0110"; B <= "1001"; wait for 20 ns;
        A <= "0111"; B <= "1000"; wait for 20 ns;
        A <= "1000"; B <= "1000"; wait for 20 ns;
        A <= "1111"; B <= "0001"; wait for 20 ns;
        A <= "1111"; B <= "1111"; wait for 20 ns;
        A <= "0101"; B <= "0000"; wait for 20 ns;
        A <= "0001"; B <= "1111"; wait for 20 ns;

        wait;
    end process;

end Behavioral;