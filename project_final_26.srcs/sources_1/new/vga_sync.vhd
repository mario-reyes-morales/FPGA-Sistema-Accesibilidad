library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Motor el cual le indica al monitor en qué coordenada exacta tiene que pintar
entity vga_sync is
    Port ( clk       : in  std_logic;
           ce_25MHz  : in  std_logic;
           hsync     : out std_logic;
           vsync     : out std_logic;
           video_on  : out std_logic;
           pixel_x   : out integer;
           pixel_y   : out integer);
end vga_sync;

architecture Behavioral of vga_sync is
    constant HD : integer := 640;
    constant HF : integer := 16;
    constant HB : integer := 48;
    constant HR : integer := 96;
    constant VD : integer := 480;
    constant VF : integer := 10;
    constant VB : integer := 33;
    constant VR : integer := 2;

    signal h_count_reg : integer range 0 to 799 := 0;
    signal v_count_reg : integer range 0 to 524 := 0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if ce_25MHz = '1' then
                if h_count_reg = (HD + HF + HB + HR - 1) then
                    h_count_reg <= 0;
                    if v_count_reg = (VD + VF + VB + VR - 1) then
                        v_count_reg <= 0;
                    else
                        v_count_reg <= v_count_reg + 1;
                    end if;
                else
                    h_count_reg <= h_count_reg + 1;
                end if;
            end if;
        end if;
    end process;

    hsync <= '0' when (h_count_reg >= (HD + HF)) and (h_count_reg <= (HD + HF + HR - 1)) else '1';
    vsync <= '0' when (v_count_reg >= (VD + VF)) and (v_count_reg <= (VD + VF + VR - 1)) else '1';
    video_on <= '1' when (h_count_reg < HD) and (v_count_reg < VD) else '0';
    
    pixel_x <= h_count_reg;
    pixel_y <= v_count_reg;
end Behavioral;