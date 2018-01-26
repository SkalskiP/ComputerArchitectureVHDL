entity JKFF is
    port(
        J: in std_logic;            -- J input
        K: in std_logic;            -- K input
        RST: in std_logic;          -- Reset
        CLK: in std_logic;          -- Clock
        Q: inout std_logic);        -- Output
end JKFF;

architecture arch_JKFF of JKFF is
begin
    process(J,K,CLK,RST)
    begin
        if(RST='1') then
        Q <= '0';
        elsif (rising_edge(CLK)) then
            if(J = '1' and K='0') then
                Q <= '1';
            elsif(J = '0' and K ='1') then
                Q <= '0';
            elsif(J = '1' and K = '1') then
                Q <= not Q;
            end if;
        end if;
    end process;
end arch_JKFF;