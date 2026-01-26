library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_2b is
    Port (
        a    : in  STD_LOGIC_VECTOR(15 downto 0);
        b    : in  STD_LOGIC_VECTOR(15 downto 0);
        ctrl : in  STD_LOGIC_VECTOR(1 downto 0);
        y    : out STD_LOGIC_VECTOR(15 downto 0);
        cout : out STD_LOGIC
    );
end top_2b;

architecture Structural of top_2b is

    component FA_16bit
        Port (
            A    : in  STD_LOGIC_VECTOR(15 downto 0);
            B    : in  STD_LOGIC_VECTOR(15 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(15 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    signal B_sel : STD_LOGIC_VECTOR(15 downto 0);
    signal Cin   : STD_LOGIC;

begin

    process(ctrl, a, b)
    begin
        case ctrl is
            when "00" =>           -- a + b
                B_sel <= b;
                Cin   <= '0';

            when "01" =>           -- a - b
                B_sel <= not b;
                Cin   <= '1';

            when "10" =>           -- a + 1
                B_sel <= (others => '0');
                Cin   <= '1';

            when others =>         -- "11" → a - 1
                B_sel <= (others => '1');
                Cin   <= '0';
        end case;
    end process;

    ADDER : FA_16bit
        port map (
            A    => a,
            B    => B_sel,
            Cin  => Cin,
            SUM  => y,
            Cout => cout
        );

end Structural;
