library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch_to_7seg is
    Port (
        SW  : in  STD_LOGIC_VECTOR(3 downto 0);
        SEG : out STD_LOGIC_VECTOR(7 downto 0) 
    );
end switch_to_7seg;

architecture Behavioral of switch_to_7seg is
begin
    process(SW)
    begin
        SEG(7) <= '0'; 
        case SW is
            when "0000" => SEG(6 downto 0) <= "0111111"; -- 0: abcdef on,  g off
            when "0001" => SEG(6 downto 0) <= "0000110"; -- 1: bc on
            when "0010" => SEG(6 downto 0) <= "1011011"; -- 2: abdeg on
            when "0011" => SEG(6 downto 0) <= "1001111"; -- 3: abcdg on
            when "0100" => SEG(6 downto 0) <= "1100110"; -- 4: bcfg on
            when "0101" => SEG(6 downto 0) <= "1101101"; -- 5: acdfg on
            when "0110" => SEG(6 downto 0) <= "1111101"; -- 6: acdefg on
            when "0111" => SEG(6 downto 0) <= "0000111"; -- 7: abc on
            when "1000" => SEG(6 downto 0) <= "1111111"; -- 8: all on
            when "1001" => SEG(6 downto 0) <= "1101111"; -- 9: abcdfg on
            when "1010" => SEG(6 downto 0) <= "1110111"; -- A: abcefg on
            when "1011" => SEG(6 downto 0) <= "1111100"; -- b: cdefg on
            when "1100" => SEG(6 downto 0) <= "0111001"; -- C: adef on
            when "1101" => SEG(6 downto 0) <= "1011110"; -- d: bcdeg on
            when "1110" => SEG(6 downto 0) <= "1111001"; -- E: adefg on
            when "1111" => SEG(6 downto 0) <= "1110001"; -- F: aefg on
            when others => SEG(6 downto 0) <= "0000000";
        end case;
    end process;
end Behavioral;
