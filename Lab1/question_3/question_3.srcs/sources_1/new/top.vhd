library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    generic (
        N : integer := 8
    );
    port (
        a   : in  signed(N-1 downto 0);
        b   : in  signed(N-1 downto 0);
        y   : out signed(N-1 downto 0)
    );
end top;

architecture Structural of top is
    signal sum  : signed(N downto 0);
    signal ovf      : std_logic;
    signal sat_val  : signed(N-1 downto 0);
    signal sum_norm : signed(N-1 downto 0);

begin

    adder_inst : entity work.signed_adder
        generic map ( N => N )
        port map (
            a   => a,
            b   => b,
            sum => sum
        );

    sum_norm <= sum(N-1 downto 0);

    ovf_inst : entity work.overflow_detect
        generic map ( N => N )
        port map (
            a       => a,
            b       => b,
            sum => sum,
            ovf     => ovf
        );


    sat_val <= to_signed( 2**(N-1)-1, N ) when a(N-1) = '0' else
               to_signed(-2**(N-1),   N );


    mux_inst : entity work.mux
        generic map ( N => N )
        port map (
            d0  => sum_norm,   
            d1  => sat_val,     
            sel => ovf,
            y   => y
        );

end Structural;
