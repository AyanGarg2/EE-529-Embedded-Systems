library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA_16bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0);
        B    : in  STD_LOGIC_VECTOR(15 downto 0);
        Cin  : in  STD_LOGIC;
        SUM  : out STD_LOGIC_VECTOR(15 downto 0);
        Cout : out STD_LOGIC
    );
end FA_16bit;

architecture Structural of FA_16bit is

    component FA
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    signal C : STD_LOGIC_VECTOR(16 downto 0);

begin

    C(0) <= Cin;

    GEN_FA : for i in 0 to 15 generate
        FA_i : FA
            port map (
                A    => A(i),
                B    => B(i),
                Cin  => C(i),
                SUM  => SUM(i),
                Cout => C(i+1)
            );
    end generate;

    Cout <= C(16);

end Structural;
