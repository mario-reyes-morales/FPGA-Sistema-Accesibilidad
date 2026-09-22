library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Divisor de frecuencia para crear distintos ritmos para los parpadeos de las luces y los sonidos.
entity relojes_tres is
    Port ( 
        clk     : in  STD_LOGIC;
        clk_1hz : out STD_LOGIC;
        clk_2hz : out STD_LOGIC;
        clk_4hz : out STD_LOGIC 
    );
end relojes_tres;

architecture Behavioral of relojes_tres is
    signal c_1hz : integer := 0;
    signal c_2hz : integer := 0;
    signal c_4hz : integer := 0;
    
    signal state_1hz : STD_LOGIC := '0';
    signal state_2hz : STD_LOGIC := '0';
    signal state_4hz : STD_LOGIC := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if c_1hz = 50000000 then 
                state_1hz <= not state_1hz;
                c_1hz <= 0;
            else
                c_1hz <= c_1hz + 1;
            end if;

            if c_2hz = 25000000 then
                state_2hz <= not state_2hz;
                c_2hz <= 0;
            else
                c_2hz <= c_2hz + 1;
            end if;

            if c_4hz = 12500000 then
                state_4hz <= not state_4hz;
                c_4hz <= 0;
            else
                c_4hz <= c_4hz + 1;
            end if;
        end if;
    end process;

    clk_1hz <= state_1hz;
    clk_2hz <= state_2hz;
    clk_4hz <= state_4hz;
    
end Behavioral;