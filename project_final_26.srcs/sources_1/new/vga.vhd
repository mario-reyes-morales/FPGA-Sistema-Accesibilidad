library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Adaptador que sirve para frenar la velocidad de la placa para que sea compatible con la pantalla
entity vga is
    Port (
        clk       : in  std_logic;
        hsync     : out std_logic;
        vsync     : out std_logic;
        video_on  : out std_logic;
        pixel_x   : out integer;
        pixel_y   : out integer
    );
end vga;

architecture Structural of vga is
    component motor_universal is
        Port ( clk : in std_logic; limite : in natural range 0 to 120000; tick : out std_logic );
    end component;
    component vga_sync is
        Port ( clk : in std_logic; ce_25MHz : in std_logic; hsync : out std_logic; vsync : out std_logic;
               video_on : out std_logic; pixel_x : out integer; pixel_y : out integer);
    end component;
    signal tick_25MHz : std_logic;
begin
    MOTOR_DISPLAY: motor_universal port map (clk => clk, limite => 3, tick => tick_25MHz);
    
    SYNC_UNIT: vga_sync port map (
        clk       => clk, 
        ce_25MHz  => tick_25MHz, 
        hsync     => hsync, 
        vsync     => vsync, 
        video_on  => video_on,  
        pixel_x   => pixel_x, 
        pixel_y   => pixel_y
    );
end Structural;