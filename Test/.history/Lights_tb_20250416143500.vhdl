library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SmartTrafficLight_tb is
-- no ports
end SmartTrafficLight_tb;

architecture sim of SmartTrafficLight_tb is

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

    -- Signals to connect to DUT
    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '1';
    signal ped_button  : STD_LOGIC := '0';
    signal red_light   : STD_LOGIC;
    signal yellow_light: STD_LOGIC;
    signal green_light : STD_LOGIC;
    signal ped_signal  : STD_LOGIC;

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the DUT
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
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial reset
        wait for 20 ns;
        reset <= '0';
        
        -- Normal cycle: RED -> GREEN -> YELLOW -> RED
        wait for 1 ms;

        -- Pedestrian presses button during RED
        ped_button <= '1';
        wait for 20 ns;
        ped_button <= '0';

        -- Wait for system to process pedestrian request
        wait for 5 ms;

        -- End simulation
        wait for 5 ms;
        assert false report "End of Simulation" severity failure;
    end process;

end sim;
