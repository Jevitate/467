library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity clk_changer is
	port(
		changer_clk : in std_logic;
		changer_cycles : in std_logic_vector(31 downto 0);
		changer_base : in std_logic_vector(7 downto 0);
		changed_clk : out std_logic);
end entity;


architecture clk_changer_arch of clk_changer is


	signal total_cycles : unsigned(39 downto 0);
	signal toggle_clk : std_logic := '0';
	signal counter : integer := 0;
	signal conversion : unsigned(34 downto 0);
	
	begin
	
	
	total_cycles <= unsigned(changer_cycles) * unsigned(changer_base);
	conversion <= total_cycles(39 downto 5);
	
	process(changer_clk)
		begin
		
		if(rising_edge(changer_clk)) then
			if(counter = conversion) then
				changed_clk <= toggle_clk;
				toggle_clk <= not(toggle_clk);
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
	
end architecture;