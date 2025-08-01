library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SmartTrafficLight_tb is
end SmartTrafficLight_tb;

architecture Behavioral of SmartTrafficLight_tb is

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

    signal clk          : STD_LOGIC := '0';
    signal reset        : STD_LOGIC := '1';
    signal ped_button   : STD_LOGIC := '0';
    signal red_light    : STD_LOGIC;
    signal yellow_light : STD_LOGIC;
    signal green_light  : STD_LOGIC;
    signal ped_signal   : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate DUT
    uut: SmartTrafficLight
        port map (
            clk          => clk,
            reset        => reset,
            ped_button   => ped_button,
            red_light    => red_light,
            yellow_light => yellow_light,
            green_light  => green_light,
            ped_signal   => ped_signal
        );

    -- Clock generation
    clk_process : process
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
        -- Initial reset
        wait for 20 ns;
        reset <= '0';

        -- Let normal traffic run
        wait for 600 ns;

        -- First pedestrian button press
        ped_button <= '1';
        wait for 30 ns;
        ped_button <= '0';

        -- Wait for the PED_WAIT and PED_CROSS sequence
        wait for 800 ns;

        -- Second pedestrian button press
        ped_button <= '1';
        wait for 20 ns;
        ped_button <= '0';

        wait for 800 ns;

        -- Simulation end
        wait;
    end process;

end Behavioral;
