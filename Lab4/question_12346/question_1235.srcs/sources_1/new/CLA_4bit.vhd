library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA_4bit is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0);
        Cin   : in  STD_LOGIC;
        SUM   : out STD_LOGIC_VECTOR(3 downto 0);
        Cout  : out STD_LOGIC
    );
end CLA_4bit;

architecture structural of CLA_4bit is

    component FA
        Port (
            A     : in  STD_LOGIC;
            B     : in  STD_LOGIC;
            Cin   : in  STD_LOGIC;
            SUM   : out STD_LOGIC;
            Cout  : out STD_LOGIC
        );
    end component;

    signal P, G : STD_LOGIC_VECTOR(3 downto 0);
    signal C : STD_LOGIC_VECTOR(4 downto 0);

begin
    C(0) <= Cin;
    P <= A xor B;
    G <= A and B;

    C(1) <= G(0) or (P(0) and C(0));

    C(2) <= G(1) or 
            (P(1) and G(0)) or
            (P(1) and P(0) and C(0));

    C(3) <= G(2) or
            (P(2) and G(1)) or
            (P(2) and P(1) and G(0)) or
            (P(2) and P(1) and P(0) and C(0));

    C(4) <= G(3) or
            (P(3) and G(2)) or
            (P(3) and P(2) and G(1)) or
            (P(3) and P(2) and P(1) and G(0)) or
            (P(3) and P(2) and P(1) and P(0) and C(0));

    FA0: FA port map(A(0), B(0), C(0), SUM(0), open);
    FA1: FA port map(A(1), B(1), C(1), SUM(1), open);
    FA2: FA port map(A(2), B(2), C(2), SUM(2), open);
    FA3: FA port map(A(3), B(3), C(3), SUM(3), open);

    Cout <= C(4);

end structural;
