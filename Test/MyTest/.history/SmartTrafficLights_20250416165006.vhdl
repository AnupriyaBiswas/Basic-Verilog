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
    signal counter     : integer := 0;
    signal ped_request : std_logic := '0';

    constant TIMEOUT   : integer := 50;  -- Normal light duration
    constant PED_TIME  : integer := 30;  -- Pedestrian crossing time

begin

    -- State register and counter
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= RED;
            counter <= 0;
            ped_request <= '0';
        elsif rising_edge(clk) then
            -- Register pedestrian request
            if ped_button = '1' then
                ped_request <= '1';
            end if;

            -- Timer and state updates
            if current_state = PED_CROSS then
                if counter < PED_TIME then
                    counter <= counter + 1;
                else
                    current_state <= RED;
                    counter <= 0;
                    ped_request <= '0';  -- Clear request after crossing
                end if;
            elsif counter < TIMEOUT then
                counter <= counter + 1;
            else
                current_state <= next_state;
                counter <= 0;
            end if;
        end if;
    end process;

    -- State transitions
    process(current_state, ped_request)
    begin
        case current_state is
            when RED =>
                if ped_request = '1' then
                    next_state <= PED_CROSS;
                else
                    next_state <= GREEN;
                end if;

            when GREEN =>
                next_state <= YELLOW;

            when YELLOW =>
                next_state <= RED;

            when PED_CROSS =>
                next_state <= RED;

            when others =>
                next_state <= RED;
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
                red_light  <= '1';
                ped_signal <= '1';

            when others =>
                null;
        end case;
    end process;

end Behavioral;
