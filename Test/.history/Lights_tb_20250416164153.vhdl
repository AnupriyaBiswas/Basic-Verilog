library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Lights_tb is
end Lights_tb;

architecture Behavioral of Lights_tb is
    -- Component declaration
    component Lights
        Port (
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            ped_button  : in  STD_LOGIC;
            red_light   : out STD_LOGIC;
            yellow_light: out STD_LOGIC;
            green_light : out STD_LOGIC;
            ped_request : out STD_LOGIC;
            ped_signal  : out STD_LOGIC
        );
    end component;

    -- Signals
    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '1';
    signal ped_button  : STD_LOGIC := '0';
    signal red_light   : STD_LOGIC;
    signal yellow_light: STD_LOGIC;
    signal green_light : STD_LOGIC;
    signal ped_request : STD_LOGIC;
    signal ped_signal  : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Lights
    uut: Lights
    Port Map (
        clk         => clk,
        reset       => reset,
        ped_button  => ped_button,
        red_light   => red_light,
        yellow_light=> yellow_light,
        green_light => green_light,
        ped_request => ped_request,  -- <-- THIS WAS MISSING
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
        -- Initial reset
        wait for 20 ns;
        reset <= '0';

        -- Wait for RED -> GREEN -> YELLOW
        wait for 600 ns;

        -- Pedestrian presses button during RED
        ped_button <= '1';
        wait for 20 ns;
        ped_button <= '0';

        -- Wait through PED_WAIT -> PED_CROSS
        wait for 300 ns;
        library IEEE;
        use IEEE.STD_LOGIC_1164.ALL;
        use IEEE.NUMERIC_STD.ALL;
        
        entity Lights_tb is
        end Lights_tb;
        
        architecture Behavioral of Lights_tb is
            signal clk         : std_logic := '0';
            signal reset       : std_logic := '0';
            signal ped_button  : std_logic := '0';
        
            signal red_light   : std_logic;
            signal yellow_light: std_logic;
            signal green_light : std_logic;
            signal ped_signal  : std_logic;
        
            constant CLK_PERIOD : time := 5 ns;
        
            component Lights
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
            uut: Lights
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
        
        -- Pedestrian presses button again to exit PED_CROSS
        ped_button <= '1';
        wait for 20 ns;
        ped_button <= '0';

        -- Wait to observe normal cycle continuing
        wait for 600 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
