library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SDRAM_4kb is
    Port (
        CLK         : in  STD_LOGIC;
        nRST        : in  STD_LOGIC;
        ADDR        : in  STD_LOGIC_VECTOR(10 downto 0);
        WnR         : in  STD_LOGIC;
        nAS         : in  STD_LOGIC;
        nLBE        : in  STD_LOGIC_VECTOR(3 downto 0);
        DIN         : in  STD_LOGIC_VECTOR(31 downto 0);
        DOUT        : out STD_LOGIC_VECTOR(31 downto 0);
        nDTACK      : out STD_LOGIC
    );
end SDRAM_4kb;

architecture Behavioral of SDRAM_4kb is
    
    type state_type is (IDLE, ACTIVE, READ_CMD, READ_WAIT, READ_DATA, WRITE_CMD, WRITE_DATA, PRECHARGE);
    signal current_state, next_state : state_type;
    
    type memory_array is array (0 to 1023) of STD_LOGIC_VECTOR(31 downto 0);
    signal sdram_memory : memory_array := (others => (others => '0'));
    
    signal internal_addr : integer range 0 to 1023;
    signal data_reg : STD_LOGIC_VECTOR(31 downto 0);
    signal dtack_reg : STD_LOGIC;
    signal wait_counter : integer range 0 to 7;
    signal latched_addr : integer range 0 to 1023;
    signal latched_data : STD_LOGIC_VECTOR(31 downto 0);
    signal latched_lbe : STD_LOGIC_VECTOR(3 downto 0);
    
begin

    internal_addr <= to_integer(unsigned(ADDR(10 downto 2))) when to_integer(unsigned(ADDR(10 downto 2))) < 1024 else 0;
    
    process(CLK, nRST)
    begin
        if nRST = '0' then
            current_state <= IDLE;
            wait_counter <= 0;
            dtack_reg <= '1';
            data_reg <= (others => '0');
            latched_addr <= 0;
            latched_data <= (others => '0');
            latched_lbe <= (others => '1');
        elsif rising_edge(CLK) then
            current_state <= next_state;
            
            case current_state is
                when IDLE =>
                    dtack_reg <= '1';
                    wait_counter <= 0;
                    if nAS = '0' then
                        latched_addr <= internal_addr;
                        latched_data <= DIN;
                        latched_lbe <= nLBE;
                    end if;
                    
                when ACTIVE =>
                    wait_counter <= 0;
                    
                when WRITE_CMD =>
                    wait_counter <= 0;
                    
                when WRITE_DATA =>
                    for i in 0 to 3 loop
                        if latched_lbe(i) = '0' then
                            sdram_memory(latched_addr)(i*8+7 downto i*8) <= latched_data(i*8+7 downto i*8);
                        end if;
                    end loop;
                    dtack_reg <= '0';
                    
                when READ_CMD =>
                    wait_counter <= 0;
                    
                when READ_WAIT =>
                    if wait_counter < 2 then
                        wait_counter <= wait_counter + 1;
                    end if;
                    
                when READ_DATA =>
                    data_reg <= sdram_memory(latched_addr);
                    dtack_reg <= '0';
                    
                when PRECHARGE =>
                    dtack_reg <= '1';
                    
                when others =>
                    null;
            end case;
        end if;
    end process;
    
    process(current_state, nAS, WnR, wait_counter)
    begin
        next_state <= current_state;
        
        case current_state is
            when IDLE =>
                if nAS = '0' then
                    next_state <= ACTIVE;
                end if;
                
            when ACTIVE =>
                if WnR = '0' then
                    next_state <= WRITE_CMD;
                else
                    next_state <= READ_CMD;
                end if;
                
            when WRITE_CMD =>
                next_state <= WRITE_DATA;
                
            when WRITE_DATA =>
                next_state <= PRECHARGE;
                
            when READ_CMD =>
                next_state <= READ_WAIT;
                
            when READ_WAIT =>
                if wait_counter >= 2 then
                    next_state <= READ_DATA;
                end if;
                
            when READ_DATA =>
                next_state <= PRECHARGE;
                
            when PRECHARGE =>
                if nAS = '1' then
                    next_state <= IDLE;
                end if;
                
            when others =>
                next_state <= IDLE;
        end case;
    end process;
    
    DOUT <= data_reg;
    nDTACK <= dtack_reg;

end Behavioral;