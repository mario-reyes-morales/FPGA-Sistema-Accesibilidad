library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Generador de pulsos con frecuencias modificables
entity motor_universal is
    Port ( 
        clk     : in  std_logic;
        limite  : in  natural range 0 to 120000;
        tick    : out std_logic
    );
end motor_universal;

architecture behavior of motor_universal is
    signal contador : natural range 0 to 120000 := 0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if limite = 0 then
                contador <= 0;
                tick <= '0';
            elsif contador >= limite then  
                contador <= 0;
                tick <= '1';
            else
                contador <= contador + 1;
                tick <= '0';
            end if;
        end if;
    end process;
end behavior;
