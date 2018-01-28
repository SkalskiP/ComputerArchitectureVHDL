--==============================================================================
-- File: 	graphic_card.vhd
-- Author:	Piotr Skalski
--==============================================================================
--  
--  A - Whole Horizontal Signal
--  B - Horizontal Sync Pulse
--  C - Horizontal Front Porch
--  D - Horizontal Active Video
--  E - Horizontal Back Porch
--
--  O - Whole Vertical Signal
--  P - Vertical Sync Pulse
--  Q - Vertical Front Porch
--  R - Vertical Active Video
--  S - Vertical Back Porch
--
--  =====================================
--  |  signals  |  time [ms]  |   clk   |
--  -------------------------------------
--  |     A     |    26.4     |   1056  |
--  |     B     |     3.2     |   128   |
--  |     C     |     2.2     |    88   |
--  |     D     |    20.0     |   800   |
--  |     E     |     1.0     |    40   |	
--  |     O     |    16579    |   628   | * 1056
--  |     P     |     106     |    4    | * 1056
--  |     Q     |     607     |   23    | * 1056
--  |     R     |    15840    |   600   | * 1056
--  |     S     |     26      |    1    | * 1056
--  =====================================
--
--  40MH - clock frequency
--  1 / 40MH = 25ns - single clock tick time
--  26400ns / 25ns = 1056
--  800x600 - display resolution
--
--==============================================================================

entity GRAPH is
    port(
        clk: in std_logic;
        rst: in std_logic;
        v_sync: out std_logic;
        h_sync: out std_logic;
        video: out std_logic_vector(2 downto 0)
    );
end GRAPH;

architecture arch_GRAPH of GRAPH is
signal x: std_logic_vector (10 downto 0)    -- 11 bits to hold numbers up to 1056
signal y: std_logic_vector (9 downto 0)     -- 10 bits to hold numbers up to 628
begin
    process(clk, rst) begin
        if(rst = '1') then
            x <= (others => '0');
            y <= (others => '0');
        elsif(rising_edge(clk)) then
            x <= x + 1;
            if(x = 1055) then
                x <= (others => '0')
                y <= y + 1;
                if(y = 627) then
                    y <= (others => '0');
                end if;
            end if;
        end if;
    end process;

    h_sync <= '1' when x <= 928 else '0';   -- A - B = 1056 - 128 = 928
    v_sync <= '1' when y <= 624 else '0';   -- O - P = 628 - 4 = 624


    video <= "100" when x >= 88+200 and x < 88+400 and y >= 23 and y <= 623
        else "010" when x >= 88 and x < 88+200 and y >= 23 and y <= 623
        else "001" when x >= 88+400 and x < 88+600 and y>= 23 and y <= 623
        else "000"

end arch_GRAPH;

-- examples: http://web.mit.edu/6.111/www/s2004/NEWKIT/vga.shtml
-- info: https://eewiki.net/pages/viewpage.action?pageId=15925278
-- info: http://www.eng.ucy.ac.cy/theocharides/Courses/ECE664/VGA.pdf