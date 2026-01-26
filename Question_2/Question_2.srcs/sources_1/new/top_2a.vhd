library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_2a is
    Port (
        a    : in  STD_LOGIC_VECTOR(15 downto 0);
        b    : in  STD_LOGIC_VECTOR(15 downto 0);
        ctrl : in  STD_LOGIC_VECTOR(1 downto 0);
        y    : out STD_LOGIC_VECTOR(15 downto 0);
        cout : out STD_LOGIC
    );
end top_2a;

architecture Structural of top_2a is

    -- Components
    component FA_16bit
        Port (
            A    : in  STD_LOGIC_VECTOR(15 downto 0);
            B    : in  STD_LOGIC_VECTOR(15 downto 0);
            Cin  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(15 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    component Incrementor_16bit
        Port (
            A    : in  STD_LOGIC_VECTOR(15 downto 0);
            Y    : out STD_LOGIC_VECTOR(15 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    component Decrementor_16bit
        Port (
            A    : in  STD_LOGIC_VECTOR(15 downto 0);
            Y    : out STD_LOGIC_VECTOR(15 downto 0);
            Bout : out STD_LOGIC
        );
    end component;

    -- Internal signals
    signal add_ab, sub_ab, inc_a, dec_a : STD_LOGIC_VECTOR(15 downto 0);
    signal c_add, c_sub, c_inc, c_dec   : STD_LOGIC;
    signal b_inv                        : STD_LOGIC_VECTOR(15 downto 0);

begin

    -- Invert B for subtraction
    b_inv <= not b;

    -- a + b
    ADD1 : FA_16bit
        port map (
            A    => a,
            B    => b,
            Cin  => '0',
            SUM  => add_ab,
            Cout => c_add
        );

    -- a - b = a + (~b) + 1
    ADD2 : FA_16bit
        port map (
            A    => a,
            B    => b_inv,
            Cin  => '1',
            SUM  => sub_ab,
            Cout => c_sub
        );

    -- a + 1
    INC1 : Incrementor_16bit
        port map (
            A    => a,
            Y    => inc_a,
            Cout => c_inc
        );

    -- a - 1
    DEC1 : Decrementor_16bit
        port map (
            A    => a,
            Y    => dec_a,
            Bout => c_dec
        );

    -- Output selection (4:1 MUX)
    process(ctrl, add_ab, sub_ab, inc_a, dec_a,
            c_add, c_sub, c_inc, c_dec)
    begin
        case ctrl is
            when "00" =>
                y    <= add_ab;
                cout <= c_add;

            when "01" =>
                y    <= sub_ab;
                cout <= c_sub;

            when "10" =>
                y    <= inc_a;
                cout <= c_inc;

            when others =>  -- "11"
                y    <= dec_a;
                cout <= c_dec;
        end case;
    end process;

end Structural;
