library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Archivo que evita que una sola pulsación cuente como varias por error
entity button is
    Port ( 
        clk: in std_logic;
        x: in std_logic;
        z: out std_logic
    );
end button;

architecture Behavioral of button is
constant LIMITE_TIEMPO: integer := 1000000;

signal contador: integer range 0 to LIMITE_TIEMPO := 0;
signal estado: std_logic := '0';

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if x /= estado then
                if contador = LIMITE_TIEMPO then
                    estado <= x;
                    contador <= 0;
                else
                    contador <= contador + 1;
                end if;
            else
                contador <= 0;
            end if;
        end if;
    end process;
    z <= estado;
end Behavioral;