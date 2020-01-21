library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity PB_condition is
	port(clk		: in std_logic;
		  reset	: in std_logic;
		  PB_in	: in std_logic;
		  PB_out	: out std_logic);

end entity;


architecture PB_condition_arch of PB_condition is


	signal counter : integer := 0;
	signal sync : std_logic;
	signal PB_push : std_logic;
	signal PB_db : std_logic;
	signal pbout : std_logic;
	
	


	begin
	
	
	process(clk)
	
	begin
		if(rising_edge(clk)) then
			counter <= counter +1;
			PB_push <= PB_db;
				if(counter = 1500000) then
					counter <= 0;
					if(rising_edge(clk) and PB_in = '0') then
						PB_db <= PB_in;
					end if;
				end if;
		end if;
	end process;
	
	
	process(clk) 
	
	begin
		
		if(PB_db = '0' and PB_push = '0') then
			pbout <= '1';
		elsif(PB_db = '0' and PB_push = '1') then
			pbout <= '0';
		end if;
	end process;
	

	process(clk)
	
	begin
	
		if(rising_edge(clk)) then
			sync <= pbout;
			PB_out <= sync;
		end if;
	end process;

end architecture;

