entity CWL is
    port(
        a: inout std_logic_vector(63 downto 0);     -- Input and output for the counter
        b: in std_logic_vector(63 downto 0);        -- Parallel load for the counter
        mode: in std_logic;                         -- Mode switch 
        clk: in std_logic;                          -- Clock
        rst: in std_logic);                         -- Reset
end CWL;

architecture arch_CWL of CWL is
begin
    process(clk, rst) begin
        if (rst = '1') then                         -- Counter reset
            a <= (others => '0')
        elsif(rising_edge(clk)) then
            if (load = '1') then                    -- Load counter value from parallel input
                a <= b;
            else
                a <= a + 1;                         -- Value of counter increased by one
            end if;
        end if;
    end process;
end arch_CWL;

-- example: http://www.asic-world.com/examples/vhdl/up_counter_with_load.html