library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EDO_DRAM is
    generic (
        ADDR_WIDTH : integer := 12;  
        DATA_WIDTH : integer := 8    
    );
    port (

        ras_n      : in  std_logic;  
        cas_n      : in  std_logic;  
        we_n       : in  std_logic;  
        address    : in  std_logic_vector(ADDR_WIDTH/2 - 1 downto 0);
        data       : inout std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
end EDO_DRAM;

architecture Behavioral of EDO_DRAM is
    
    type memory_array is array (0 to 2**ADDR_WIDTH - 1) of 
         std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal mem : memory_array := (others => (others => '0'));
    
    signal row_addr    : std_logic_vector(ADDR_WIDTH/2 - 1 downto 0);
    signal col_addr    : std_logic_vector(ADDR_WIDTH/2 - 1 downto 0);
    signal full_addr   : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal edo_latch   : std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal data_valid  : std_logic := '0';
    signal row_active  : std_logic := '0';
    signal prev_cas_n  : std_logic := '1';
    
begin
    
    full_addr <= row_addr & col_addr;
    
    process(ras_n)
    begin
        if falling_edge(ras_n) then
            row_addr <= address;
            row_active <= '1';
        elsif rising_edge(ras_n) then
            row_active <= '0';
        end if;
    end process;
    
    process(cas_n, ras_n)
    begin
        if row_active = '1' then
            if falling_edge(cas_n) then
                col_addr <= address;
                
                if we_n = '1' then
                    edo_latch <= mem(to_integer(unsigned(full_addr)));
                    data_valid <= '1';
                else
                    mem(to_integer(unsigned(full_addr))) <= data;
                    data_valid <= '0';
                end if;
                
            elsif rising_edge(cas_n) then
                null;  
            end if;
        end if;
        
        if rising_edge(ras_n) then
            data_valid <= '0';
        end if;
    end process;
    
    data <= edo_latch when (data_valid = '1' and we_n = '1') else 
            (others => 'Z');
    
    process(cas_n)
    begin
        prev_cas_n <= cas_n;
    end process;

end Behavioral;