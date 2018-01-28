entity DEC_2TO4 is
    port(
        a : out std_logic_vector(3 downto 0);
        sel : in std_logic_vector(1 downto 0));
end DEC_2TO4;

architecture arch_DEC_2TO4 of DEC_2TO4 is
begin
-- a <= "0001" when sel = "00" else
-- "0010" when sel = "01" else
-- "0100" when sel = "10" else
-- "1000";
process(a)    
begin
case a is
    when "00" => sel <= "0001";
    when "01" => sel <= "0010";
    when "10" => sel <= "0100";
    when "11" => sel <= "1000";
end case;
end process;
end arch_DEC_2TO4;

-- example: https://allaboutfpga.com/vhdl-code-for-2-to-4-decoder/