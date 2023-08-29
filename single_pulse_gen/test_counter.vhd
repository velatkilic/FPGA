library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity test_counter is
end test_counter;

architecture testbench  of test_counter is
	signal clk       : std_logic;
	signal rst       : std_logic;
	signal enable    : std_logic;
	signal cnt_max   : unsigned(7 downto 0);
	signal cnt       : unsigned(7 downto 0);
begin

	pulse_gen_dut : entity counter
					generic map (n => 8)
					port map (
						clk       => clk,
						rst       => rst,
						enable    => enable,
						cnt_max   => cnt_max,
						cnt       => cnt
					);

	process
	begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;
	
	rst <= '0', '1' after 20 ns, '0' after 100 ns;
	
	cnt_max <= to_unsigned(10, 8);
	
	enable <= '1', '0' after 200 ns, '1' after 400 ns;

end testbench ;
