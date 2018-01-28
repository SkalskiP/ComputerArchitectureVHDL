entity ALU is
    port(
        a: in std_logic_vector(63 downto 0);        -- First input number
        b: in std_logic_vector(63 downto 0);        -- Second input number
        c: out std_logic_vector(63 downto 0);       -- Output number
        sel: in std_logic_vector(2 downto 0));      -- Select input
end ALU;

architecture arch_ALU of ALU is
begin
    process(a, b, sel) begin
        case sel is
            when "000" =>
                c <= a + b;                         -- Addition
            when "001" =>
                c <= a - b;                         -- Subtraction
            when "010" =>
                c <= a + 1;                         -- Add 1
            when "011" =>                           
                c <= a - 1;                         -- Subtract 1
            when "100" =>
                c <= a and b;                       -- And gate
            when "101" =>
                c <= a or b;                        -- Or gate
            when "110" =>
                c <= not a;                         -- Not gate
            when "111" =>
                c <= a(0) & A(63 downto 1);         -- Bit shift
        end case;
    end process;
end arch_ALU;

-- note: We assume that operations such as adding and subtracting are in the attached libraries 

-- example: https://allaboutfpga.com/vhdl-code-for-4-bit-alu/
-- example: https://github.com/plorefice/vhdl-simple-processor/blob/master/src/alu.vhd