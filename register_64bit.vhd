entity REG is
    port(
        a: out std_logic_vector(63 downto 0);       -- Output register value
        b: in std_logic_vector(63 downto 0);        -- Input register value
        clk: in std_logic;                          -- Clock
        rst: in std_logic);                         -- Reset
end REG;

architecture arch_REG of REG is
begin
    process(clk, rst) begin
        if (rst = '1') then                         -- Counter reset
            a <= (other => '0')
        elsif(rising_edge(clk)) then
            a <= b;                                 -- Load new register value
        end if;
    end process;
end arch_REG;

-- example: https://en.wikibooks.org/wiki/VHDL_for_FPGA_Design/4-Bit_Shift_Register