library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity test_variable_pulse_gen is
end test_variable_pulse_gen;

architecture testbench  of test_variable_pulse_gen is
	signal clk       : std_logic;
	signal rst       : std_logic;
	signal start     : std_logic;
	signal delay     : unsigned(7 downto 0);
	signal duration  : unsigned(7 downto 0);
	signal pulse_out : std_logic;
begin

	dut: entity variable_pulse_gen
		 generic map (n => 8)
		 port map (
		  	clk       => clk,
		  	rst       => rst,
		  	start     => start,
		  	delay     => delay,
		  	duration  => duration,
			pulse_out => pulse_out
		 );

	process
	begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;
	
	rst <= '0', '1' after 20 ns, '0' after 100 ns;
	
	start <= '0', '1' after 400 ns, '0' after 420 ns;
	
	delay <= to_unsigned(10, 8);
	
	duration <= to_unsigned(3, 8);

end testbench ;
