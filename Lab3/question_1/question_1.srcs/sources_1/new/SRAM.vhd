library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SRAM_6116 is
    Port (
        Address : in  STD_LOGIC_VECTOR (10 downto 0);
        IO      : inout STD_LOGIC_VECTOR (7 downto 0);
        CS_n    : in  STD_LOGIC;
        OE_n    : in  STD_LOGIC;
        WE_n    : in  STD_LOGIC
    );
end SRAM_6116;

architecture Behavioral of SRAM_6116 is
    type memory_array is array (0 to 2047) of STD_LOGIC_VECTOR(7 downto 0);
    signal ram_block : memory_array := (others => (others => '0'));
    signal addr_int : integer range 0 to 2047;
    
    -- Timing parameters from 6116 datasheet (45ns grade)
    constant T_AA : time := 45 ns;  -- Address Access Time
    constant T_OHA : time := 10 ns; -- Output Hold from Address Change
    constant T_OHZ : time := 10 ns; -- Output Disable Time
    
begin
    -- Convert address to integer
    addr_int <= to_integer(unsigned(Address));
    
    -- Write Process: Captures data on rising edge of WE_n
    write_proc: process(WE_n, CS_n)
    begin
        if CS_n = '0' and rising_edge(WE_n) then
            ram_block(addr_int) <= IO;
        end if;
    end process;
    
    -- Read Process: Outputs data with timing delay
    read_proc: process(CS_n, OE_n, WE_n, Address)
        variable current_addr : integer range 0 to 2047;
    begin
        current_addr := to_integer(unsigned(Address));
        
        if CS_n = '0' and OE_n = '0' and WE_n = '1' then
            -- Read operation: output data with access time delay
            IO <= ram_block(current_addr) after T_AA;
        else
            -- Tri-state the output
            IO <= (others => 'Z') after T_OHZ;
        end if;
    end process;
    
end Behavioral;