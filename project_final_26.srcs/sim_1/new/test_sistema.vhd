library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Esta es el archivo de testeo que comprueba el comportamiento de todo el sistema, tanto en modo físico como en modo simulación
entity test_sistema is
end test_sistema;

architecture behavior of test_sistema is

    component sistema is
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
    end component;

    signal clk_tb             : std_logic := '0';
    signal pulsador_tb        : std_logic := '0';
    signal sensor_tb          : std_logic_vector(2 downto 0) := "000";
    signal sw_sim_tb          : std_logic_vector(2 downto 0) := "000";
    signal modo_simulacion_tb : std_logic := '0';
    
    signal altavoz_tb         : std_logic;
    signal led_rgb_tb         : std_logic_vector(2 downto 0);
    signal vgaRed_tb          : std_logic_vector(3 downto 0);
    signal vgaGreen_tb        : std_logic_vector(3 downto 0);
    signal vgaBlue_tb         : std_logic_vector(3 downto 0);
    signal Hsync_tb           : std_logic;   
    signal Vsync_tb           : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    UUT: sistema port map (
        clk             => clk_tb,
        pulsador        => pulsador_tb,
        sensor          => sensor_tb,
        sw_sim          => sw_sim_tb,
        modo_simulacion => modo_simulacion_tb,
        altavoz         => altavoz_tb,
        led_rgb         => led_rgb_tb,
        vgaRed          => vgaRed_tb,
        vgaGreen        => vgaGreen_tb,
        vgaBlue         => vgaBlue_tb,
        Hsync           => Hsync_tb,
        Vsync           => Vsync_tb
    );

    clk_process :process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD/2;
        clk_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;

    stim_proc: process
    begin
        -- Estado inicial de reposo
        pulsador_tb <= '0';
        sensor_tb <= "000";
        sw_sim_tb <= "000";
        modo_simulacion_tb <= '0';
        wait for 2 ms; 
        
        -- Prueba Alarma Física de Gas
        sensor_tb <= "001"; 
        wait for 2 ms;
        sensor_tb <= "000";
        wait for 1 ms;
        
        -- Prueba Alarma Física de Inundación
        sensor_tb <= "010"; 
        wait for 2 ms;
        sensor_tb <= "000";
        wait for 1 ms;
        
        -- Cambio al modo simulación
        modo_simulacion_tb <= '1';
        sw_sim_tb <= "100"; -- Simula el fuego
        wait for 2 ms;
        modo_simulacion_tb <= '0';
        sw_sim_tb <= "000";
        wait for 1 ms;
        
        -- Prueba del pulsador manual o timbre
        pulsador_tb <= '1';
        wait for 20 ms;
        pulsador_tb <= '0';
        
        wait;
    end process;

end behavior;