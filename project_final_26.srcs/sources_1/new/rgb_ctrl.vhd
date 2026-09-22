library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Controla el color y la velocidad a la que parpadea la luz LED.
entity rgb_ctrl is
    Port (
        modo    : in  std_logic_vector(2 downto 0);
        clk_1hz : in  std_logic;
        clk_2hz : in  std_logic;
        clk_4hz : in  std_logic;
        led_rgb : out std_logic_vector(2 downto 0)
    );
end rgb_ctrl;

architecture Dataflow of rgb_ctrl is
    signal color_base : std_logic_vector(2 downto 0);
    signal enable_led : std_logic;
begin
--Seleccion del color dependiendo del tipo de alarma
    with modo select
        color_base <= "001" when "001",
                      "011" when "010",
                      "100" when "011",
                      "111" when "100",
                      "000" when others;
--Regula la velocidad de parapadeo dependiendo del tipo de alarma
    with modo select
        enable_led <= clk_4hz               when "001",
                      clk_2hz               when "010",
                      (clk_4hz and clk_1hz) when "011",
                      '1'                   when "100",
                      '0'                   when others;

    led_rgb <= color_base when (enable_led = '1') else "000";

end Dataflow;
