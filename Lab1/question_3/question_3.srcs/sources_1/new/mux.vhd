library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux is
    generic (
        N : integer := 8
    );
    port (
        d0  : in  signed(N-1 downto 0);
        d1  : in  signed(N-1 downto 0);
        sel : in  std_logic;
        y   : out signed(N-1 downto 0)
    );
end mux;

architecture Behavioral of mux is
begin
    y <= d0 when sel = '0' else d1;
end Behavioral;

