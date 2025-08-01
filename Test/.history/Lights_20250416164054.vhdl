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
        ped_signal  : out STD_LOGIC
    );
end Lights;

architecture Behavioral of Lights is
    type state_type is (RED, GREEN, YELLOW);
    signal current_state, next_state : state_type;
    signal counter : integer := 0;
    constant TIMEOUT : integer := 50;
begin

    -- State machine
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= RED;
            counter <= 0;
        elsif rising_edge(clk) then
            if ped_button = '0' then
                if counter < TIMEOUT then
                    counter <= counter + 1;
                else
                    current_state <= next_state;
                    counter <= 0;
                end if;
            else
                current_state <= RED; -- Force RED if button is pressed
                counter <= 0;
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
            when others => next_state <= RED;
        end case;
    end process;

    -- Output logic
    process(current_state, ped_button)
    begin
        red_light    <= '0';
        yellow_light <= '0';
        green_light  <= '0';
        ped_signal   <= '0';

        if ped_button = '1' then
            red_light  <= '1';
            ped_signal <= '1';
        else
            case current_state is
                when RED =>
                    red_light <= '1';
                when GREEN =>
                    green_light <= '1';
                when YELLOW =>
                    yellow_light <= '1';
                when others =>
                    null;
            end case;
        end if;
    end process;

end Behavioral;
