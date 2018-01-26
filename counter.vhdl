entity COUNTER is
port(
    clk: in std_logic;                          -- Clock
    rst: in std_logic;                          -- Restet
    a: inout std_logic_vector(3 downto 0));     -- Output
end COUNTER;

architecture arch_COUNTER of COUNTER is
begin
    process(clk, rst) begin
        if (rst = '1') then
            -- a <= '0000';
            a <= (others => '0');
        elsif (rising_edge(clk)) then 
            a <= a + 1;
        end if;
    end process;
end arch_COUNTER;

-- example: http://www.asic-world.com/examples/vhdl/simple_counter.html