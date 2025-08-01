library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Lights is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        ped_button  : in  STD_LOGIC;

        red_light   : out STD_LOGIC;
        yellow_light: out STD_LOGIC;
        green_light : out STD_LOGIC;
        ped_request : out STD_LOGIC; -- added to waveform
        ped_signal  : out STD_LOGIC
    );
end Lights;

architecture Behavioral of Lights is
    type state_type is (RED, GREEN, YELLOW, PED_WAIT, PED_CROSS);
    signal current_state, next_state : state_type;
    signal counter : integer := 0;
    signal ped_req_latch : STD_LOGIC := '0'; -- internal latch for ped_request

    constant TIMEOUT : integer := 50;
begin

    -- State Register Process
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= RED;
            counter <= 0;
            ped_req_latch <= '0';
        elsif rising_edge(clk) then
            -- Latch ped_request on button press in RED or PED_CROSS
            if ped_button = '1' then
                if current_state = RED or current_state = PED_CROSS then
                    ped_req_latch <= '1';
                end if;
            end if;

            -- State transition timing
            if current_state = PED_CROSS then
                -- Wait until button is pressed again to exit PED_CROSS
                if ped_button = '1' then
                    current_state <= next_state;
                    ped_req_latch <= '1'; -- re-latch during PED_CROSS exit
                end if;
            elsif counter < TIMEOUT then
                counter <= counter + 1;
            else
                current_state <= next_state;
                counter <= 0;

                -- Clear ped_request latch only after PED_CROSS
                if current_state = PED_CROSS then
                    ped_req_latch <= '0';
                end if;
            end if;
        end if;
    end process;

    -- Next State Logic
    process(current_state, ped_req_latch)
    begin
        case current_state is
            when RED =>
                if ped_req_latch = '1' then
                    next_state <= PED_WAIT;
                else
                    next_state <= GREEN;
                end if;

            when GREEN =>
                next_state <= YELLOW;

            when YELLOW =>
                next_state <= RED;

            when PED_WAIT =>
                next_state <= PED_CROSS;

            when PED_CROSS =>
                next_state <= RED; -- will only change when button is pressed

            when others =>
                next_state <= RED;
        end case;
    end process;

    -- Output Logic
    process(current_state, ped_req_latch)
    begin
        -- Default off
        red_light    <= '0';
        yellow_light <= '0';
        green_light  <= '0';
        ped_signal   <= '0';
        ped_request  <= '0';

        case current_state is
            when RED =>
                red_light <= '1';

            when GREEN =>
                green_light <= '1';

            when YELLOW =>
                yellow_light <= '1';

            when PED_WAIT =>
                red_light    <= '1';
                ped_request  <= '1'; -- request is active

            when PED_CROSS =>
                red_light    <= '1';
                ped_request  <= '1'; -- still active
                ped_signal   <= '1'; -- walk signal active

            when others =>
                null;
        end case;
    end process;

end Behavioral;
