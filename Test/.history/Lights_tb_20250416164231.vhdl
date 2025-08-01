library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SmartTrafficLight_tb is
end SmartTrafficLight_tb;

architecture Behavioral of SmartTrafficLight_tb is

    -- Component Declaration
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

    -- Signals for simulation
    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '1';
    signal ped_button  : STD_LOGIC := '0';
    signal red_light   : STD_LOGIC;
    signal yellow_light: STD_LOGIC;
    signal green_light : STD_LOGIC;
    signal ped_signal  : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the traffic light
    uut: SmartTrafficLight
        Port Map (
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
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        -- Hold reset
        wait for 20 ns;
        reset <= '0';

        -- Run normal cycle
        wait for 400 ns;

        -- Pedestrian presses the button
        ped_button <= '1';
        wait for 50 ns;
        ped_button <= '0';

        -- Wait for system to return to normal cycle
        wait for 500 ns;

        -- Press button again
        ped_button <= '1';
        wait for 30 ns;
        ped_button <= '0';

        -- Run a bit more
        wait for 500 ns;

        wait;
    end process;

end Behavioral;
