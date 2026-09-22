library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Decide de qué color se pintan las letras y el fondo
entity vga_color_mapper is
    Port (
        modo         : in  std_logic_vector(2 downto 0);
        pixel_activo : in  std_logic;
        video_on     : in  std_logic;
        vgaRed       : out std_logic_vector(3 downto 0);
        vgaGreen     : out std_logic_vector(3 downto 0);
        vgaBlue      : out std_logic_vector(3 downto 0)
    );
end vga_color_mapper;

architecture Dataflow of vga_color_mapper is
begin
    process(modo, pixel_activo, video_on)
    begin
        vgaRed <= "0000"; vgaGreen <= "0000"; vgaBlue <= "0000";

        if video_on = '1' then
            if pixel_activo = '1' then
                case modo is
                    when "001" => vgaRed <= "1111";
                    when "010" => vgaRed <= "1111"; vgaGreen <= "1111";
                    when "011" => vgaBlue <= "1111";
                    when "100" => vgaRed <= "1111"; vgaBlue <= "1111";
                    when "000" => vgaGreen <= "1111";
                    when others=> null;
                end case;
            end if;
        end if;
    end process;
end Dataflow;
