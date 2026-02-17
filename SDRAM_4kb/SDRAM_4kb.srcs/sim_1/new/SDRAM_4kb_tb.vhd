library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SDRAM_4KB_tb is
end SDRAM_4KB_tb;

architecture Behavioral of SDRAM_4KB_tb is
    
    component SDRAM_4kb is
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
    end component;
    
    signal CLK         : STD_LOGIC := '0';
    signal nRST        : STD_LOGIC := '0';
    signal ADDR        : STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
    signal WnR         : STD_LOGIC := '1';
    signal nAS         : STD_LOGIC := '1';
    signal nLBE        : STD_LOGIC_VECTOR(3 downto 0) := (others => '1');
    signal DIN         : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal DOUT        : STD_LOGIC_VECTOR(31 downto 0);
    signal nDTACK      : STD_LOGIC;
    
    constant CLK_PERIOD : time := 10 ns;
    
begin
    
    UUT: SDRAM_4kb
        port map (
            CLK => CLK,
            nRST => nRST,
            ADDR => ADDR,
            WnR => WnR,
            nAS => nAS,
            nLBE => nLBE,
            DIN => DIN,
            DOUT => DOUT,
            nDTACK => nDTACK
        );
    
    CLK_process: process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    STIM_process: process
    begin
        
        nRST <= '0';
        wait for 50 ns;
        nRST <= '1';
        wait for 50 ns;
        
        wait for CLK_PERIOD;
        
        ADDR <= "00000000000";
        DIN <= X"12345678";
        WnR <= '0';
        nLBE <= "0000";
        nAS <= '0';
        wait for CLK_PERIOD * 5;
        nAS <= '1';
        wait for CLK_PERIOD * 2;
        
        ADDR <= "00000000100";
        DIN <= X"AABBCCDD";
        WnR <= '0';
        nLBE <= "0000";
        nAS <= '0';
        wait for CLK_PERIOD * 5;
        nAS <= '1';
        wait for CLK_PERIOD * 2;
        
        ADDR <= "00000001000";
        DIN <= X"DEADBEEF";
        WnR <= '0';
        nLBE <= "0000";
        nAS <= '0';
        wait for CLK_PERIOD * 5;
        nAS <= '1';
        wait for CLK_PERIOD * 2;
        
        ADDR <= "00000001100";
        DIN <= X"CAFEBABE";
        WnR <= '0';
        nLBE <= "1100";
        nAS <= '0';
        wait for CLK_PERIOD * 5;
        nAS <= '1';
        wait for CLK_PERIOD * 2;
        
        ADDR <= "00000000000";
        WnR <= '1';
        nAS <= '0';
        wait for CLK_PERIOD * 5;
        nAS <= '1';
        wait for CLK_PERIOD * 2;
        
        ADDR <= "00000000100";
        WnR <= '1';
        nAS <= '0';
        wait for CLK_PERIOD * 5;
        nAS <= '1';
        wait for CLK_PERIOD * 2;
        
        ADDR <= "00000001000";
        WnR <= '1';
        nAS <= '0';
        wait for CLK_PERIOD * 5;
        nAS <= '1';
        wait for CLK_PERIOD * 2;
        
        ADDR <= "00000001100";
        WnR <= '1';
        nAS <= '0';
        wait for CLK_PERIOD * 5;
        nAS <= '1';
        wait for CLK_PERIOD * 2;
        
        ADDR <= "11111111100";
        DIN <= X"FFFFFFFF";
        WnR <= '0';
        nLBE <= "0000";
        nAS <= '0';
        wait for CLK_PERIOD * 5;
        nAS <= '1';
        wait for CLK_PERIOD * 2;
        
        ADDR <= "11111111100";
        WnR <= '1';
        nAS <= '0';
        wait for CLK_PERIOD * 5;
        nAS <= '1';
        wait for CLK_PERIOD * 2;
        
        wait for 100 ns;
        
        assert false report "Simulation completed successfully" severity note;
        wait;
        
    end process;

end Behavioral;