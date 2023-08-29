--------------------------------------------------
-- Generate a single pulse with a variable start time and duration
-- Velat Kilic
--------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity variable_pulse_gen is
	Generic (
		n : positive := 32
	);
	Port (
		clk       : in std_logic;
		rst       : in std_logic;
		start     : in std_logic; 				-- start signal
		delay     : in unsigned(n-1 downto 0);  -- delay amount
		duration  : in unsigned(n-1 downto 0);  -- pulse duration amount
		pulse_out : out std_logic 				-- output pulse
	);
end variable_pulse_gen;

architecture Behavioral of variable_pulse_gen is
	type state_type is (idle_state, delay_state, pulse_state);
	signal fsm : state_type;

	signal delay_cnt        : unsigned(n-1 downto 0);
	signal delay_cnt_enb    : std_logic;
	signal duration_cnt     : unsigned(n-1 downto 0);
	signal duration_cnt_enb : std_logic;
begin
	-- counter for delay timing
	cnt1: entity counter
		  generic map (n => n)
		  port map (
			  clk       => clk,
			  rst       => rst,
			  enable    => delay_cnt_enb,
			  cnt_max   => delay,
			  cnt       => delay_cnt
		  );
	delay_cnt_enb <= '1' when (fsm = delay_state) else '0';
	
	-- counter for pulse duration
	cnt2: entity counter
		  generic map (n => n)
		  port map (
		  	  clk       => clk,
		  	  rst       => rst,
			  enable    => duration_cnt_enb,
		  	  cnt_max   => duration,
		  	  cnt       => duration_cnt
		  );
	duration_cnt_enb <= '1' when (fsm = pulse_state) else '0';
	
	-- Finite state machine: idle, delay, pulse
	process(clk, rst)
	begin
		if (rst = '1') then 
			fsm <= idle_state;
		elsif rising_edge(clk) then
			case fsm is
				when idle_state  =>
					if (start = '1') then
						fsm <= delay_state;
					else
						fsm <= idle_state;
					end if;
				when delay_state =>
					if (delay_cnt = delay - 1) then
						fsm <= pulse_state;
					else
						fsm <= delay_state;
					end if;
				when pulse_state =>
					if (duration_cnt = duration - 1) then
						fsm <= idle_state;
					else
						fsm <= pulse_state;
					end if;
			end case;
		end if;
	end process;
	
	-- output
	pulse_out <= '1' when (fsm = pulse_state) else '0';

end Behavioral;
