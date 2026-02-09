library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity q1_structural is
    port (
        clk   : in  std_logic;
        reset : in  std_logic;
        w     : in  std_logic;
        z     : out std_logic
    );
end q1_structural;

architecture structural of q1_structural is

    signal s0,s1,s2,s3,s4,s5,s6,s7,s8 : std_logic;
    signal d0,d1,d2,d3,d4,d5,d6,d7,d8 : std_logic;

begin

    d0 <= '1' when reset = '1' else '0';

    d1 <= (s0 and not w) or (s5 and not w) or (s6 and not w) or
          (s7 and not w) or (s8 and not w);

    d2 <= s1 and not w;
    d3 <= s2 and not w;
    d4 <= (s3 and not w) or (s4 and not w);

    d5 <= (s0 or s1 or s2 or s3 or s4) and w;
    d6 <= s5 and w;
    d7 <= s6 and w;
    d8 <= (s7 and w) or (s8 and w);

    z <= s4 or s8;

    FF0 : entity work.DFF port map (D => d0, clk => clk, reset => '0',   Q => s0);
    FF1 : entity work.DFF port map (D => d1, clk => clk, reset => reset, Q => s1);
    FF2 : entity work.DFF port map (D => d2, clk => clk, reset => reset, Q => s2);
    FF3 : entity work.DFF port map (D => d3, clk => clk, reset => reset, Q => s3);
    FF4 : entity work.DFF port map (D => d4, clk => clk, reset => reset, Q => s4);
    FF5 : entity work.DFF port map (D => d5, clk => clk, reset => reset, Q => s5);
    FF6 : entity work.DFF port map (D => d6, clk => clk, reset => reset, Q => s6);
    FF7 : entity work.DFF port map (D => d7, clk => clk, reset => reset, Q => s7);
    FF8 : entity work.DFF port map (D => d8, clk => clk, reset => reset, Q => s8);

end structural;
