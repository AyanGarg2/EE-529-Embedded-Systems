library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity overflow_detect is
    generic (
        N : integer := 8   
    );
    port (
        a       : in  signed(N-1 downto 0);
        b       : in  signed(N-1 downto 0);
        sum : in  signed(N downto 0);  
        ovf     : out std_logic            
    );
end overflow_detect;

architecture Behavioral of overflow_detect is
begin

    ovf <= '1' when
           (a(N-1) = b(N-1)) and (sum(N-1) /= a(N-1))
           else '0';

end Behavioral;
