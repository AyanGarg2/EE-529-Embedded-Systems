library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab1 is
    Port (
        x1  : in  std_logic;
        x2  : in  std_logic;
        sel : in  std_logic_vector(1 downto 0);
        y1  : out std_logic;
        y2  : out std_logic
    );
end lab1;

architecture Behavioral of lab1 is
begin
    process(x1, x2, sel)
    begin
        case sel is
            when "00" =>
                y1 <= x1;
                y2 <= x2;

            when "01" =>
                y1 <= x2;
                y2 <= x1;

            when "10" =>
                y1 <= x1;
                y2 <= x1;
                
             when others =>
                y1 <= x2;
                y2 <= x2;   
        end case;
    end process;
end Behavioral;

