entity ps2_keyboard is
    port(
        rst: in std_logic;                          -- Reset
        clk_120: in std_logic;                      -- System clock used to perform sampling
        clk_ps2:: in std_logic;                     -- Clock signal from PS/2 keybord
        data_ps2: in std_logic;                     -- Data signal from PS/2 keybord
        code_ps2: out std_logic_vector(7 downto 0)  -- Code received from PS/2
    );
end ps2_keyboard;

architecture logic of ps2_keyboard is
    signal count: std_logic_vector(3 downto 0);             -- Count number of bits received from PS/2
    signal ps2_word: std_logic_vector(10 downto 0);         -- Stores the ps2 data word
    signal smpl_clk: std_logic_vector(4 downto 0);          -- Sampling clock
    signal smpl_data: std_logic_vector(4 downto 0);         -- Sampling data
begin
    process(rst, clk_120) begin
        if(rst = '1') then
            -- Reseting values of all signals
            count <= (others => '0');
            ps2_word <= (others => '0');
            smpl_clk <= (others => '0');
            smpl_data <= (others => '0');
        elsif(rising_edge(clk)) then
            smpl_clk <= clk_ps2 & smpl_clk(4 downto 1);
            smpl_data <= data_ps2 & smpl_data(4 downto 1);
            if(smpl_clk(0) = '1' and smpl_clk(1) = '1' and smpl_clk(2) + smpl_clk(3) + smpl_clk(4) < 2)
            
            end if;
        end if;
    end process;
end logic;