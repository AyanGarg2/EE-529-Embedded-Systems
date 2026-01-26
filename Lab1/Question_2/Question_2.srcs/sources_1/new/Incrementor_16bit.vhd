library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Incrementor_16bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0);
        Y    : out STD_LOGIC_VECTOR(15 downto 0);
        Cout : out STD_LOGIC
    );
end Incrementor_16bit;

architecture Structural of Incrementor_16bit is

    component FA_16bit
        Port (
            A    : in  STD_LOGIC_VECTOR(15 downto 0);
            B    : in  STD_LOGIC_VECTOR(15 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(15 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    constant ZERO : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

begin

    FA_INC : FA_16bit
        port map (
            A    => A,
            B    => ZERO,
            Cin  => '1',
            SUM  => Y,
            Cout => Cout
        );

end Structural;
