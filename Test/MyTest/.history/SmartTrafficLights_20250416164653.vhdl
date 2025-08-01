library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SmartTrafficLight is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        ped_button  : in  STD_LOGIC;
        red_light   : out STD_LOGIC;
        yellow_light: out STD_LOGIC;
        green_light : out STD_LOGIC;
        ped_signal  : out STD_LOGIC
    );
end SmartTrafficLight;

architecture Behavioral of SmartTrafficLight is
    type state_type is (RED, GREEN, YELLOW, PED_CROSS);
    signal current_state, next_state : state_type;
    signal counter : integer := 0;
    constant TIMEOUT : integer := 50;
    constant PED_TIME : integer := 40;  -- crossing time
begin

    -- Sequential process
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= RED;
            counter <= 0;
        elsif rising_edge(clk) then
            -- Immediate interrupt for pedestrian
            if ped_button = '1' and current_state /= PED_CROSS then
                current_state <= PED_CROSS;
                counter <= 0;
            else
                if (current_state = PED_CROSS and counter < PED_TIME) or
                   (current_state /= PED_CROSS and counter < TIMEOUT) then
                    counter <= counter + 1;
                else
                    current_state <= next_state;
                    counter <= 0;
                end if;
            end if;
        end if;
    end process;

    -- State transitions
    process(current_state)
    begin
        case current_state is
            when RED    => next_state <= GREEN;
            when GREEN  => next_state <= YELLOW;
            when YELLOW => next_state <= RED;
            when PED_CROSS => next_state <= RED;
            when others => next_state <= RED;
        end case;
    end process;

    -- Output logic
    process(current_state)
    begin
        red_light    <= '0';
        yellow_light <= '0';
        green_light  <= '0';
        ped_signal   <= '0';

        case current_state is
            when RED =>
                red_light <= '1';
            when GREEN =>
                green_light <= '1';
            when YELLOW =>
                yellow_light <= '1';
            when PED_CROSS =>
                red_light   <= '1';
                ped_signal  <= '1';  -- Show pedestrian is walking
            when others =>
                null;
        end case;
    end process;

end Behavioral;
