entity MULT_4TO1 is
    port (
        a : in std_logic_vector(3 downto 0);      -- Inputs
        b : out std_logic;                        -- Output
        sel : in std_logic_vector(1 downto 0));   -- Select input
end MULT_4TO1;

architecture arch_MULT_4TO1 of MULT_4TO1 is
begin
    b <= a(0) when (sel = "00") else
        a(1) when (sel = "01") else
        a(2) when (sel = "10") else
        a(3) when (sel = "11") else a(0);
end arch_MULT_4TO1;

-- example: https://startingelectronics.org/software/VHDL-CPLD-course/tut4-multiplexers/