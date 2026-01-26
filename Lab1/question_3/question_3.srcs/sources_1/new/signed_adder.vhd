library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity signed_adder is
    generic (
        N : integer := 8   
    );
    port (
        a   : in  signed(N-1 downto 0);
        b   : in  signed(N-1 downto 0);
        sum : out signed(N downto 0)  
    );
end signed_adder;

architecture Behavioral of signed_adder is
begin
    sum <= resize(a, N+1) + resize(b, N+1);
end Behavioral;