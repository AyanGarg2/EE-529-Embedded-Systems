library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_lab1 is
end tb_lab1;

architecture Behavioral of tb_lab1 is

    component lab1
        Port (
            x1  : in  std_logic;
            x2  : in  std_logic;
            sel : in  std_logic_vector(1 downto 0);
            y1  : out std_logic;
            y2  : out std_logic
        );
    end component;

    signal x1  : std_logic := '0';
    signal x2  : std_logic := '0';
    signal sel : std_logic_vector(1 downto 0) := "00";
    signal y1  : std_logic;
    signal y2  : std_logic;

begin

    uut: lab1
        port map (
            x1  => x1,
            x2  => x2,
            sel => sel,
            y1  => y1,
            y2  => y2
        );

    stim_proc: process
    begin

        x1 <= '0'; x2 <= '1'; sel <= "00";
        wait for 10 ns;

        sel <= "01";
        wait for 10 ns;

        sel <= "10";
        wait for 10 ns;

        sel <= "11";
        wait for 10 ns;

                assert false
        report "Simulation completed successfully"
        severity failure;
        
    end process;

end Behavioral;

