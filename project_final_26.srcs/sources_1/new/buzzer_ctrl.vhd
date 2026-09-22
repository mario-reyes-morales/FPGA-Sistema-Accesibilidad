library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Controlador del altavoz, encargado de crear los distintos sonidos
entity buzzer_ctrl is
    Port (
        clk     : in  std_logic;
        modo    : in  std_logic_vector(2 downto 0);
        clk_1hz : in  std_logic;
        clk_2hz : in  std_logic;
        clk_4hz : in  std_logic;
        altavoz : out std_logic
    );
end buzzer_ctrl;

architecture Behavioral of buzzer_ctrl is
    component motor_universal is
        Port ( clk : in std_logic; limite : in natural range 0 to 120000; tick : out std_logic );
    end component;

    signal limite_audio : natural range 0 to 120000 := 0;
    signal tick_audio   : std_logic;
    signal enable_audio : std_logic;
    signal onda_cuadrada: std_logic := '0';

begin
    MOTOR_AUDIO: motor_universal port map ( 
        clk    => clk, 
        limite => limite_audio, 
        tick   => tick_audio 
    );

    process(clk)
    begin
        if rising_edge(clk) then
            if tick_audio = '1' then
                onda_cuadrada <= not onda_cuadrada;
            end if;
        end if;
    end process;
-- Le da un tono distinto a cada peligro segun el nivel de prioridad
    process(modo, clk_1hz)
    begin
        case modo is
            when "001" =>
                if clk_1hz = '1' then
                    limite_audio <= 25000;
                else
                    limite_audio <= 40000;
                end if;
            when "010" =>
                limite_audio <= 113635;
            when "011" =>
                limite_audio <= 50000;
            when "100" =>
                limite_audio <= 15000;
            when others =>
                limite_audio <= 0;
        end case;
    end process;
-- Hace que el sonido sea continuo o intermitente según la alarma
    with modo select
        enable_audio <= '1'                   when "001",
                        clk_2hz               when "010",
                        (clk_4hz and clk_1hz) when "011",
                        '1'                   when "100",
                        '0'                   when others;
                        
    altavoz <= onda_cuadrada when (enable_audio = '1' and modo /= "000") else '0';
end Behavioral;