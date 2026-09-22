library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Se encarga de controlar el orden de prioridad del sistema de alarmas.
entity deco is
    Port (
        sensor       : in  std_logic_vector(2 downto 0); 
        boton : in  std_logic;
        modo         : out std_logic_vector(2 downto 0) 
    );
end deco;

architecture Behavioral of deco is
begin
-- Orden de prioridad: Fuego > Agua > Gas > Timbre
    process(sensor, boton)
    begin
        if sensor(2) = '1' then 
            modo <= "001";
        elsif sensor(0) = '1' then
            modo <= "010";
        elsif sensor(1) = '1' then
            modo <= "011";
        elsif boton = '1' then
            modo <= "100";
        else 
            modo <= "000";
        end if;
    end process;
end Behavioral;
