library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_subtractor_4bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(3 downto 0);
        B    : in  STD_LOGIC_VECTOR(3 downto 0);
        M    : in  STD_LOGIC;          
        S    : out STD_LOGIC_VECTOR(3 downto 0);
        Cout : out STD_LOGIC           
    );
end adder_subtractor_4bit;

architecture structural of adder_subtractor_4bit is

    component RCA_4bit
        Port (
            A    : in  STD_LOGIC_VECTOR(3 downto 0);
            B    : in  STD_LOGIC_VECTOR(3 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(3 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    signal B_xor : STD_LOGIC_VECTOR(3 downto 0);

begin

    B_xor <= B xor (M & M & M & M);

    U1: RCA_4bit
        port map (
            A    => A,
            B    => B_xor,
            Cin  => M,
            SUM  => S,
            Cout => Cout
        );

end structural;