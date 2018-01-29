entity ps2_keyboard is
    port(
        rst: in std_logic;                          -- Reset
        clk_120: in std_logic;                      -- System clock used to perform sampling
        klaw_clk:: in std_logic;                    -- Clock signal from PS/2 keybord
        klaw_dane: in std_logic;                    -- Data signal from PS/2 keybord
        dane_wyj: out std_logic_vector(7 downto 0)  -- Code received from PS/2
    );
end ps2_keyboard;

architecture logic of ps2_keyboard is
    signal licznik: std_logic_vector(3 downto 0);       -- Count number of bits received from PS/2
    signal dane: std_logic_vector(10 downto 0);         -- Stores the ps2 data word
    signal probki_clk: std_logic_vector(4 downto 0);    -- Sampling clock
    signal probki_dane: std_logic_vector(4 downto 0);   -- Sampling data
begin
    process(rst, clk_120) begin
        if(rst = '1') then
            -- Reseting values of all signals
            count <= (others => '0');
            ps2_word <= (others => '0');
            smpl_clk <= (others => '0');
            smpl_data <= (others => '0');
        elsif(rising_edge(clk_120)) then
            probki_clk <= klaw_clk & probki_clk(4 downto 1);
            probki_dane <= klaw_dane & probki_dane(4 downto 1);
            if(probki_clk(0) = '1' and probki_clk(1) = '1' and probki_clk(2) + probki_clk(3) + probki_clk(4) < 2) then
                licznik <= licznik + 1;
                if(probki_dane(0)+probki_dane(1)+probki_dane(2)+probki_dane(3)+probki_dane(4) > 2) then
                    dane <= '1' & dane(10 downto 1);
                else
                    dane <= '0' & dane(10 downto 1);
                end if;
                if(licznik = 10) then
                    licznik <= (others => '0');
                    dane_wyj <= dane(9 downto 2)
                end if;
            end if;
        end if;
    end process;
end logic;