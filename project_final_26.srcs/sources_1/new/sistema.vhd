library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Archivo principal que conecta los archivos del proyecto y gestiona el modo de pruebas
entity sistema is
    Port (
        clk             : in  std_logic;
        pulsador        : in  std_logic;
        sensor          : in  std_logic_vector (2 downto 0);
        sw_sim          : in  std_logic_vector (2 downto 0);
        modo_simulacion : in  std_logic;
        altavoz         : out std_logic;
        led_rgb         : out std_logic_vector (2 downto 0);
        vgaRed          : out std_logic_vector (3 downto 0);
        vgaGreen        : out std_logic_vector (3 downto 0);
        vgaBlue         : out std_logic_vector (3 downto 0);
        Hsync           : out std_logic;
        Vsync           : out std_logic
    );
end sistema;

architecture Structural of sistema is

    component relojes_tres is
        Port ( clk : in STD_LOGIC; clk_1hz : out STD_LOGIC; clk_2hz : out STD_LOGIC; clk_4hz : out STD_LOGIC );
    end component;

    component button is
        Port ( clk : in std_logic; x : in std_logic; z : out std_logic );
    end component;

    component deco is
        Port ( sensor : in std_logic_vector(2 downto 0); boton : in std_logic; modo : out std_logic_vector(2 downto 0) );
    end component;

    component buzzer_ctrl is
        Port ( clk : in std_logic; modo : in std_logic_vector(2 downto 0); clk_1hz, clk_2hz, clk_4hz : in std_logic; altavoz : out std_logic );
    end component;

    component rgb_ctrl is
        Port ( modo : in std_logic_vector(2 downto 0); clk_1hz, clk_2hz, clk_4hz : in std_logic; led_rgb : out std_logic_vector (2 downto 0) );
    end component;

    component vga_ctrl is
        Port ( clk : in std_logic; modo : in std_logic_vector(2 downto 0); vgaRed, vgaGreen, vgaBlue : out std_logic_vector (3 downto 0); Hsync, Vsync : out std_logic );
    end component;

    signal clean_btn : std_logic;
    signal mode_sig  : std_logic_vector(2 downto 0);
    signal sensor_elegido, sensor_sync_1, sensor_sync_2 : std_logic_vector(2 downto 0);
    signal sig_clk_1hz, sig_clk_2hz, sig_clk_4hz : std_logic;

begin
    --Selección entre sensores físicos o interruptores de simulación
    sensor_elegido <= sw_sim when (modo_simulacion = '1') else sensor;

    process(clk)
    begin
    --Pasa la señal por dos etapas para que el sensor no provoque errores en la placa
        if rising_edge(clk) then
            sensor_sync_1 <= sensor_elegido;
            sensor_sync_2 <= sensor_sync_1;
        end if;
    end process;

    RELOJES: relojes_tres port map ( clk => clk, clk_1hz => sig_clk_1hz, clk_2hz => sig_clk_2hz, clk_4hz => sig_clk_4hz );
    BTN: button port map ( clk => clk, x => pulsador, z => clean_btn );
    DECODER: deco port map ( sensor => sensor_sync_2, boton => clean_btn, modo => mode_sig );
    SISTEMA_AUDIO: buzzer_ctrl port map ( clk => clk, modo => mode_sig, clk_1hz => sig_clk_1hz, clk_2hz => sig_clk_2hz, clk_4hz => sig_clk_4hz, altavoz => altavoz );
    SISTEMA_RGB: rgb_ctrl port map ( modo => mode_sig, clk_1hz => sig_clk_1hz, clk_2hz => sig_clk_2hz, clk_4hz => sig_clk_4hz, led_rgb => led_rgb );
    SISTEMA_DISPLAY: vga_ctrl port map ( clk => clk, modo => mode_sig, vgaRed => vgaRed, vgaGreen => vgaGreen, vgaBlue => vgaBlue, Hsync => Hsync, Vsync => Vsync );
end Structural;