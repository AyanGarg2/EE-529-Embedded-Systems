library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Subtractor_16bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0);
        B    : in  STD_LOGIC_VECTOR(15 downto 0);
        D    : out STD_LOGIC_VECTOR(15 downto 0);
        Bout : out STD_LOGIC
    );
end Subtractor_16bit;

architecture Structural of Subtractor_16bit is

    component FA_16bit
        Port (
            A    : in  STD_LOGIC_VECTOR(15 downto 0);
            B    : in  STD_LOGIC_VECTOR(15 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(15 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    signal B_inv : STD_LOGIC_VECTOR(15 downto 0);

begin

    -- 1's complement of B
    B_inv <= not B;

    -- A + (~B) + 1
    FA_SUB : FA_16bit
        port map (
            A    => A,
            B    => B_inv,
            Cin  => '1',
            SUM  => D,
            Cout => Bout
        );

end Structural;
