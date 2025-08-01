library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SmartTrafficLight_tb1 is
end SmartTrafficLight_tb1;

architecture Behavioral of SmartTrafficLight_tb1 is
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

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset system
        reset <= '1';
        wait for 2 ns;
        reset <= '0';

        -- Let normal cycle run a bit (RED -> GREEN -> YELLOW -> RED)
        wait for 400 ns;

        -- Pedestrian presses button during RED
        ped_button <= '1';
        wait for 10 ns;
        ped_button <= '0';

        -- Wait for pedestrian crossing sequence
        wait for 400 ns;

        -- Another normal cycle
        wait for 400 ns;

        wait;
    end process;

end Behavioral;
