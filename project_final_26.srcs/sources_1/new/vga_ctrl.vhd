library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Archivo principal de la pantalla el cual la recorre, forma las letras y los colores.
entity vga_ctrl is
    Port (
        clk      : in  std_logic;
        modo     : in  std_logic_vector (2 downto 0);
        vgaRed   : out std_logic_vector (3 downto 0);
        vgaGreen : out std_logic_vector (3 downto 0);
        vgaBlue  : out std_logic_vector (3 downto 0);
        Hsync    : out std_logic;
        Vsync    : out std_logic
    );
end vga_ctrl;

architecture Structural of vga_ctrl is
    component vga is
        Port ( clk : in std_logic; hsync : out std_logic; vsync : out std_logic;
               video_on : out std_logic; pixel_x : out integer; pixel_y : out integer);
    end component;

    component vga_font_engine is
        Port ( pixel_x : in integer; pixel_y : in integer; modo : in std_logic_vector(2 downto 0);
               pixel_activo : out std_logic);
    end component;

    component vga_color_mapper is
        Port ( modo : in std_logic_vector(2 downto 0); pixel_activo : in std_logic; video_on : in std_logic;
               vgaRed : out std_logic_vector(3 downto 0); vgaGreen : out std_logic_vector(3 downto 0); vgaBlue : out std_logic_vector(3 downto 0));
    end component;

    signal sig_video_on : std_logic;
    signal sig_pix_x, sig_pix_y : integer;
    signal sig_pixel_activo : std_logic;

begin
-- Recorrido
    SYNC_UNIT: vga port map (
        clk => clk, hsync => Hsync, vsync => Vsync, 
        video_on => sig_video_on, pixel_x => sig_pix_x, pixel_y => sig_pix_y
    );
--Letras
    TEXT_UNIT: vga_font_engine port map (
        pixel_x => sig_pix_x, pixel_y => sig_pix_y, modo => modo, pixel_activo => sig_pixel_activo
    );
--Colores
    COLOR_UNIT: vga_color_mapper port map (
        modo => modo, pixel_activo => sig_pixel_activo, video_on => sig_video_on,
        vgaRed => vgaRed, vgaGreen => vgaGreen, vgaBlue => vgaBlue
    );
end Structural;
