--==============================================================================
-- File: 	procesor_64bit.vhd
-- Author:	Piotr Skalski
--==============================================================================
--  
--  List of orders:
--  1. MEM -> A
--  2. MEM -> B
--  3. C -> MEM
--  4. A + B -> C
--  5. A or B -> C
--  6. A and B -> C
--  7. not A -> C
--  8. bit shift of A -> C
--  9. unconditional jump
--  10. conditional jump
--
--==============================================================================

entity processor is
    port(
        rst: in std_logic;
        clk: in std_logic;
        p_prog_adr: out std_logic_vector(63 downto 0);
        p_prog_dane: in std_logic_vector(63 downto 0);
        p_danych_adr1: out std_logic_vector(63 downto 0);
        p_danych_dane1: in std_logic_vector(63 downto 0);
        p_danych_adr2: out std_logic_vector(63 downto 0);
        p_danych_dane2: out std_logic_vector(63 downto 0);
        p_danych_zapisz: out std_logic
    );
end processor;

architecture logic of processor is
signal A, B, C, L_ROZK, R_ROZK, R_ARG: std_logic_vector(63 downto 0);
signal cykl: std_logic_vector(3 downto 0);
begin
    process(clk, rst) begin
        if(rst = '1') then
            p_prog_adr <= (others => '0');
            p_danych_adr1 <= (others => '0');
            p_danych_adr2 <= (others => '0');
            p_danych_dane2 <= (others => '0');
            p_danych_zapisz <= (others => '0');
            A <= (others => '0');
            B <= (others => '0');
            C <= (others => '0');
            L_ROZK <= (others => '0');
            R_ROZK <= (others => '0');
            R_ARG <= (others => '0');
            cykl <= (others => '0');
        elsif(rising_edge(clk)) then
            cykl <= cykl + 1;
            if(cykl = 0) then
                R_ROZK <= p_prog_dane;
                L_ROZK <= L_ROZK + 1;
                p_prog_adr <= L_ROZK + 1;
                p_danych_zapisz <= '0';
            elsif (R_ROZK = 1) then                 -- MEM -> A
                if (cykl = 1) then
                    p_danych_adr1 <= p_prog_dane;
                elsif (cykl = 2) then
                    L_ROZK <= L_ROZK + 1;
                    p_prog_adr <= L_ROZK + 1;
                    A <= p_danych_dane1;
                    cykl <= (others => '0');
                end if;
            elsif (R_ROZK = 3) then                 -- C -> MEM
                if (cykl = 1) then
                    p_danych_adr2 <= p_prog_dane;
                    p_danych_dane2 <= C;
                elsif(cykl = 2) then
                    L_ROZK <= L_ROZK + 1;
                    p_prog_adr <= L_ROZK + 1;
                    p_danych_zapisz <= '1';
                    cykl <= (others => '0');
                end if;
            elsif (R_ROZK = 4) then                 -- A + B -> C
                C <= A + B;
                cykl <= (others => '0');
            elsif (R_ROZK = 8) then                 -- bit shift of A -> C
                C <= A(0) & A(63 downto 1);
                cykl <= (others => '0');
            elsif (R_ROZK = 9) then                 -- unconditional jump
                if (cykl = 1) then
                    R_ARG <= p_prog_dane;
                elsif (cykl = 2) then
                    p_prog_adr <= R_ARG;
                    L_ROZK <= R_ARG;
                    cykl <= (others => '0');
                end if;
            elsif (R_ROZK = 10) then                -- conditional jump
                if (cykl = 1) then
                    if (C = 0) then
                        cykl <= (others => '0');
                        L_ROZK <= L_ROZK + 1;
                        p_prog_adr <= L_ROZK + 1;
                    end if;
                    R_ARG <= p_prog_dane;
                elsif (cykl = 2) then
                    p_prog_adr <= R_ARG;
                    L_ROZK <= R_ARG;
                    cykl <= (others => '0');
                end if;
            end if;
        end if;
    end process;
end logic;