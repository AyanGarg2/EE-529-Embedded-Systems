library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library std;
use std.env.all;


entity top_2a_tb is
end top_2a_tb;

architecture Behavioral of top_2a_tb is

    -- DUT signals
    signal a    : STD_LOGIC_VECTOR(15 downto 0);
    signal b    : STD_LOGIC_VECTOR(15 downto 0);
    signal ctrl : STD_LOGIC_VECTOR(1 downto 0);
    signal y    : STD_LOGIC_VECTOR(15 downto 0);
    signal cout : STD_LOGIC;

    -- DUT declaration
    component top_2a
        Port (
            a    : in  STD_LOGIC_VECTOR(15 downto 0);
            b    : in  STD_LOGIC_VECTOR(15 downto 0);
            ctrl : in  STD_LOGIC_VECTOR(1 downto 0);
            y    : out STD_LOGIC_VECTOR(15 downto 0);
            cout : out STD_LOGIC
        );
    end component;

begin

    -- Instantiate DUT
    DUT : top_2a
        port map (
            a    => a,
            b    => b,
            ctrl => ctrl,
            y    => y,
            cout => cout
        );

    -- Stimulus process
    stim_proc : process
    begin

        -- -------------------------
        -- ctrl = "00" → a + b
        -- -------------------------
        a    <= x"000A";   -- 10
        b    <= x"0005";   -- 5
        ctrl <= "00";
        wait for 10 ns;

        -- -------------------------
        -- ctrl = "01" → a - b
        -- -------------------------
        a    <= x"000A";   -- 10
        b    <= x"0005";   -- 5
        ctrl <= "01";
        wait for 10 ns;

        a    <= x"000F";   -- 15
        b    <= x"0000";   -- don't care
        ctrl <= "10";
        wait for 10 ns;

        a    <= x"0001";
        ctrl <= "11";
        wait for 10 ns;

        stop;
    end process;

end Behavioral;
