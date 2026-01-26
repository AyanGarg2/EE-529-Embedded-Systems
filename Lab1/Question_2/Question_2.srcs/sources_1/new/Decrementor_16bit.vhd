library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decrementor_16bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0);
        Y    : out STD_LOGIC_VECTOR(15 downto 0);
        Bout : out STD_LOGIC
    );
end Decrementor_16bit;

architecture Structural of Decrementor_16bit is

    component FA_16bit
        Port (
            A    : in  STD_LOGIC_VECTOR(15 downto 0);
            B    : in  STD_LOGIC_VECTOR(15 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(15 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    constant ALL_ONES : STD_LOGIC_VECTOR(15 downto 0) := (others => '1');

begin

    FA_DEC : FA_16bit
        port map (
            A    => A,
            B    => ALL_ONES,
            Cin  => '0',
            SUM  => Y,
            Cout => Bout
        );

end Structural;
