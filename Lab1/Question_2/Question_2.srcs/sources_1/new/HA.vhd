library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HA is
    Port (
        A     : in  STD_LOGIC;
        B     : in  STD_LOGIC;
        SUM   : out STD_LOGIC;
        CARRY : out STD_LOGIC
    );
end HA;

architecture Behavioral of HA is
begin
    SUM   <= A xor B;
    CARRY <= A and B;
end Behavioral;
