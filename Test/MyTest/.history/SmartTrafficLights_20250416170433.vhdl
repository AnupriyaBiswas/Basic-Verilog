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
    signal ped_req     : std_logic := '0';

    constant TIMEOUT        : integer := 50;
    constant PED_CROSS_TIME : integer := 30;
begin

    -- Clocked Process
    process(clk, reset)
begin
    if reset = '1' then
        current_state <= RED;
        counter <= 0;
        ped_req <= '0';

    elsif rising_edge(clk) then
        -- If button is pressed, immediately enter PED_CROSS
        if ped_button = '1' and current_state /= PED_CROSS then
            current_state <= PED_CROSS;
            counter <= 0;
            ped_req <= '1';

        -- Normal state timing logic
        elsif (current_state = PED_CROSS and counter >= PED_CROSS_TIME) or
              (current_state /= PED_CROSS and counter >= TIMEOUT) then
            current_state <= next_state;
            counter <= 0;

            if current_state = PED_CROSS then
                ped_req <= '0';
            end if;

        else
            counter <= counter + 1;
        end if;
    end if;
end process;


    -- Next State Logic
    process(current_state, ped_req)
    begin
        case current_state is
            when RED =>
                if ped_req = '1' then
                    next_state <= PED_CROSS;
                else
                    next_state <= GREEN;
                end if;

            when GREEN =>
                if ped_req = '1' then
                    next_state <= PED_CROSS;
                else
                    next_state <= YELLOW;
                end if;

            when YELLOW =>
                if ped_req = '1' then
                    next_state <= PED_CROSS;
                else
                    next_state <= RED;
                end if;

            when PED_CROSS =>
                next_state <= RED;

            when others =>
                next_state <= RED;
        end case;
    end process;

    -- Output Logic
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
                red_light <= '1';
                ped_signal <= '1';

            when others =>
                null;
        end case;
    end process;

end Behavioral;
