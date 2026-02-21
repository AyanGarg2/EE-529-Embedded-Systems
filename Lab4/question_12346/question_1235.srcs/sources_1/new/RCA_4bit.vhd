library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_4bit is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0);
        Cin   : in  STD_LOGIC;
        SUM   : out STD_LOGIC_VECTOR(3 downto 0);
        Cout  : out STD_LOGIC
    );
end RCA_4bit;

architecture structural of RCA_4bit is

    component FA
        Port (
            A     : in  STD_LOGIC;
            B     : in  STD_LOGIC;
            Cin   : in  STD_LOGIC;
            SUM   : out STD_LOGIC;
            Cout  : out STD_LOGIC
        );
    end component;

    signal C : STD_LOGIC_VECTOR(3 downto 0);

begin

    FA0: FA
        port map (
            A    => A(0),
            B    => B(0),
            Cin  => Cin,
            SUM  => SUM(0),
            Cout => C(0)
        );

    FA1: FA
        port map (
            A    => A(1),
            B    => B(1),
            Cin  => C(0),
            SUM  => SUM(1),
            Cout => C(1)
        );

    FA2: FA
        port map (
            A    => A(2),
            B    => B(2),
            Cin  => C(1),
            SUM  => SUM(2),
            Cout => C(2)
        );


    FA3: FA
        port map (
            A    => A(3),
            B    => B(3),
            Cin  => C(2),
            SUM  => SUM(3),
            Cout => C(3)
        );

    Cout <= C(3);

end structural;
