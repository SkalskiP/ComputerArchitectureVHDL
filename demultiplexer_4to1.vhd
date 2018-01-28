entity DEMULT_4TO1 is
    port (
        a : in std_logic;                       -- Input
        b : out std_logic_vector(3 downto 0);   -- Outputs
        sel : in std_logic_vector(1 downto 1)); -- Select input
end DEMULT_4TO1;

architecture arch_DEMULT_4TO1 of DEMULT_4TO1 is
begin
    b <= "000" & a when (sel = "00") else
        "00" & a & "0" when (sel = "01") else
        "0" & a & "00" when (sel = "10") else
        a & "000";
end arch_DEMULT_4TO1;