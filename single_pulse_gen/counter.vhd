--------------------------------------------------
-- Count from 0 to max_count
-- Velat Kilic
--------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity counter is
	Generic (
		n : positive := 32
	);
	Port (
		clk     : in std_logic;
		rst     : in std_logic;
		enable  : in std_logic;
		cnt_max : in unsigned(n-1 downto 0);
		cnt     : out unsigned(n-1 downto 0)
	);
end counter;

architecture Behavioral of counter is
	signal cnt_sig : unsigned(n-1 downto 0);
	signal clear   : std_logic;
begin
	
	process(clk, rst)
	begin
		if (rst = '1') then
			cnt_sig <= (others => '0');
		elsif rising_edge(clk) then
			if (clear = '0' and enable = '1') then
				cnt_sig <= cnt_sig + 1;
			else
				cnt_sig <= (others => '0');
			end if;
		end if;
	end process;
	clear <= '1' when (cnt_sig = cnt_max) else '0';
	cnt <= cnt_sig;

end Behavioral;
