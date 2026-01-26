library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        SUM  : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end FA;

architecture Structural of FA is
    component HA
        Port (
            A     : in  STD_LOGIC;
            B     : in  STD_LOGIC;
            SUM   : out STD_LOGIC;
            CARRY : out STD_LOGIC
        );
    end component;

    signal S1, C1, C2 : STD_LOGIC;

begin

    HA1: HA
        port map (
            A     => A,
            B     => B,
            SUM   => S1,
            CARRY => C1
        );

    HA2: HA
        port map (
            A     => S1,
            B     => Cin,
            SUM   => SUM,
            CARRY => C2
        );

    Cout <= C1 or C2;

end Structural;
