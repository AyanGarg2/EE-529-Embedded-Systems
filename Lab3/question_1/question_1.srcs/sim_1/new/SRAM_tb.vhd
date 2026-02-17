library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_SRAM_6116 is
end tb_SRAM_6116;

architecture Behavioral of tb_SRAM_6116 is
    -- Component Declaration
    component SRAM_6116
        Port (
            Address : in  STD_LOGIC_VECTOR (10 downto 0);
            IO      : inout STD_LOGIC_VECTOR (7 downto 0);
            CS_n    : in  STD_LOGIC;
            OE_n    : in  STD_LOGIC;
            WE_n    : in  STD_LOGIC
        );
    end component;
    
    -- Signals
    signal Address : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
    signal IO      : STD_LOGIC_VECTOR(7 downto 0)  := (others => 'Z');
    signal CS_n    : STD_LOGIC := '1';
    signal OE_n    : STD_LOGIC := '1';
    signal WE_n    : STD_LOGIC := '1';
    
    -- Timing Constants from IDT6116 Datasheet (45ns grade)
    constant T_RC  : time := 45 ns; -- Read Cycle Time
    constant T_AA  : time := 45 ns; -- Access Time
    constant T_WP  : time := 25 ns; -- Write Pulse Width
    constant T_WC  : time := 45 ns; -- Write Cycle Time
    constant T_AS  : time := 0 ns;  -- Address Setup Time
    constant T_WR  : time := 5 ns;  -- Write Recovery Time
    
begin
    -- Instantiate UUT
    uut: SRAM_6116 port map (
        Address => Address,
        IO      => IO,
        CS_n    => CS_n,
        OE_n    => OE_n,
        WE_n    => WE_n
    );
    
    -- Stimulus Process
    stim_proc: process
    begin		
        -- Initial wait
        wait for 100 ns;
        
        report "Starting Write Cycle to Address 0x010 with Data 0x3C";
        
        -- ========== WRITE CYCLE ==========
        Address <= "00000010000";  -- Address 0x010 (16 decimal)
        CS_n    <= '0';            -- Select Chip
        OE_n    <= '1';            -- Disable Output during write
        WE_n    <= '1';            -- Keep WE high initially
        
        wait for T_AS;             -- Address Setup Time
        
        WE_n    <= '0';            -- Start Write Pulse
        IO      <= "00111100";     -- Drive Data 0x3C onto bus
        
        wait for T_WP;             -- Hold for Write Pulse Width (25ns)
        
        WE_n    <= '1';            -- End Write Pulse (data is captured here)
        
        wait for T_WR;             -- Write Recovery Time
        
        IO      <= (others => 'Z'); -- Release data bus
        CS_n    <= '1';            -- Deselect chip
        
        wait for 50 ns;            -- Gap between operations
        
        report "Starting Read Cycle from Address 0x010";
        
        -- ========== READ CYCLE ==========
        Address <= "00000010000";  -- Same Address 0x010
        CS_n    <= '0';            -- Select Chip
        OE_n    <= '0';            -- Enable Output
        WE_n    <= '1';            -- Read Mode (WE must be high)
        
        wait for T_AA;             -- Wait for data to be valid (45ns)
        
        report "Data read should be available now";
        
        wait for T_RC - T_AA;      -- Complete the read cycle
        
        -- End Read Cycle
        OE_n    <= '1';            -- Disable Output
        CS_n    <= '1';            -- Deselect Chip
        
        wait for 100 ns;
        
        report "Testing Write and Read to different address";
        
        -- ========== WRITE TO ADDRESS 0x020 ==========
        Address <= "00000100000";  -- Address 0x020 (32 decimal)
        CS_n    <= '0';
        OE_n    <= '1';
        WE_n    <= '0';
        IO      <= "10101010";     -- Data 0xAA
        
        wait for T_WP;
        
        WE_n    <= '1';            -- End write pulse
        wait for T_WR;
        IO      <= (others => 'Z');
        CS_n    <= '1';
        
        wait for 50 ns;
        
        -- ========== READ FROM ADDRESS 0x020 ==========
        Address <= "00000100000";
        CS_n    <= '0';
        OE_n    <= '0';
        WE_n    <= '1';
        
        wait for T_AA;
        wait for T_RC - T_AA;
        
        OE_n    <= '1';
        CS_n    <= '1';
        
        wait for 100 ns;
        
        report "Simulation Complete";
        wait;
    end process;
    
end Behavioral;