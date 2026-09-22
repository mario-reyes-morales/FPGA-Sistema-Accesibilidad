library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Diccionario de letras encargado de guardar como se dibujan cada una en la pantalla
entity vga_font_engine is
    Port (
        pixel_x      : in  integer;
        pixel_y      : in  integer;
        modo         : in  std_logic_vector(2 downto 0);
        pixel_activo : out std_logic
    );
end vga_font_engine;

architecture Behavioral of vga_font_engine is

    type char_matrix is array (0 to 6) of std_logic_vector(4 downto 0);
    type font_array is array (0 to 16) of char_matrix;

    constant FONT : font_array := (
        0  => ("01110", "10001", "10001", "11111", "10001", "10001", "10001"),
        1  => ("01110", "10001", "10000", "10000", "10000", "10001", "01110"),
        2  => ("11110", "10001", "10001", "10001", "10001", "10001", "11110"),
        3  => ("11111", "10000", "10000", "11110", "10000", "10000", "11111"),
        4  => ("01110", "10001", "10000", "10011", "10001", "10001", "01110"),
        5  => ("11111", "00100", "00100", "00100", "00100", "00100", "11111"),
        6  => ("10000", "10000", "10000", "10000", "10000", "10000", "11111"),
        7  => ("10001", "11011", "10101", "10001", "10001", "10001", "10001"),
        8  => ("10001", "11001", "10101", "10011", "10001", "10001", "10001"),
        9  => ("01110", "10001", "10001", "10001", "10001", "10001", "01110"),
        10 => ("11110", "10001", "10001", "11110", "10100", "10010", "10001"),
        11 => ("01111", "10000", "10000", "01110", "00001", "00001", "11110"),
        12 => ("11111", "00100", "00100", "00100", "00100", "00100", "00100"),
        13 => ("10001", "10001", "10001", "10001", "10001", "10001", "01110"),
        14 => ("11110", "10001", "10001", "11110", "10001", "10001", "11110"),
        15 => ("00000", "00000", "00000", "00000", "00000", "00000", "00000"),
        16 => ("00000", "00000", "00000", "00000", "00000", "00000", "00000")
    );

    type string_type is array (0 to 16) of integer range 0 to 16;
    
    constant STR_OK     : string_type := (11, 5, 11, 12, 3, 7, 0, 15, 1, 9, 10, 10, 3, 1, 12, 9, 15); 
    constant STR_FUEGO  : string_type := (0, 6, 3, 10, 12, 0, 15, 5, 8, 1, 3, 8, 2, 5, 9, 15, 15);
    constant STR_HUMO   : string_type := (0, 6, 3, 10, 12, 0, 15, 4, 0, 11, 15, 15, 15, 15, 15, 15, 15);
    constant STR_AGUA   : string_type := (0, 6, 3, 10, 12, 0, 15, 5, 8, 13, 8, 2, 0, 1, 5, 9, 8);
    constant STR_TIMBRE : string_type := (12, 5, 7, 14, 10, 3, 15, 7, 0, 8, 13, 0, 6, 15, 15, 15, 15);
    
-- Elige qué palabra mostrar y enciende los píxeles correctos según la alarma
begin
    process(pixel_x, pixel_y, modo)
        variable char_pos_x : integer;
        variable col, row   : integer;
        variable char_val   : integer;
    begin
        pixel_activo <= '0';
        
        if pixel_x >= 48 and pixel_x < 592 then
            char_pos_x := (pixel_x - 48) / 32;
            col := ((pixel_x - 48) mod 32) / 4;

            if pixel_y >= 200 and pixel_y < 256 then
                row := (pixel_y - 200) / 8;
                
                case modo is
                    when "001" => char_val := STR_FUEGO(char_pos_x);
                    when "010" => char_val := STR_HUMO(char_pos_x);
                    when "011" => char_val := STR_AGUA(char_pos_x);
                    when "100" => char_val := STR_TIMBRE(char_pos_x);
                    when "000" => char_val := STR_OK(char_pos_x);
                    when others=> char_val := 15; 
                end case;

                if col < 5 and row < 7 then 
                    pixel_activo <= FONT(char_val)(row)(4 - col); 
                end if;
            end if;
        end if;
    end process;
end Behavioral;