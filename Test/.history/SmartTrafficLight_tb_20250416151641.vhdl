library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SmartTrafficLight_tb is
end SmartTrafficLight_tb;

architecture Behavioral of SmartTrafficLight_tb is
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '0';
    signal ped_button  : std_logic := '0';

    signal red_light   : std_logic;
    signal yellow_light: std_logic;
    signal green_light : std_logic;
    signal ped_signal  : std_logic;

    constant CLK_PERIOD : time := 5 ns;

    component SmartTrafficLight
        Port (
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            ped_button  : in  STD_LOGIC;

            red_light   : out STD_LOGIC;
            yellow_light: out STD_LOGIC;
            green_light : out STD_LOGIC;
            ped_signal  : out STD_LOGIC
        );
    end component;

begin
    uut: SmartTrafficLight
        port map (
            clk         => clk,
            reset       => reset,
            ped_button  => ped_button,
            red_light   => red_light,
            yellow_light=> yellow_light,
            green_light => green_light,
            ped_signal  => ped_signal
        );

    -- Clock generation
    clk_process :process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD/2;
            clk <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    -- Stimulus and monitoring process
    stim_proc: process
        procedure print_status(time_now : time) is
        begin
            report "Time: " & time'image(time_now) &
                   " | reset=" & std_logic'image(reset) &
                   " | ped_button=" & std_logic'image(ped_button) &
                   " || red=" & std_logic'image(red_light) &
                   ", yellow=" & std_logic'image(yellow_light) &
                   ", green=" & std_logic'image(green_light) &
                   ", ped_signal=" & std_logic'image(ped_signal);
        end procedure;
    begin
        report "Time | reset | ped_button || red | yellow | green | ped_signal";

        -- Reset
        reset <= '1';
        wait for 2 ns;
        reset <= '0';
        print_status(now);

        -- Normal cycle
        wait for 250 ns;
        print_status(now);

        -- Pedestrian presses button
        ped_button <= '1';
        wait for 10 ns;
        ped_button <= '0';
        print_status(now);

        -- Wait to observe PED_WAIT and PED_CROSS
        wait for 300 ns;
        print_status(now);

        -- Another normal cycle
        wait for 300 ns;
        print_status(now);

        wait;
    end process;

end Behavioral;