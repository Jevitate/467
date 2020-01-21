library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity up_down_counter is 
	port(
		up_down_clk : in std_logic;
		up_down_reset : in std_logic;
		up_down : in std_logic;
		count_out : out std_logic_vector(6 downto 0));

end entity;


architecture up_down_counter_arch of up_down_counter is

	signal direction : integer;
	signal counter : integer := 0;
	begin
	
		process(up_down)
			begin
				
				if(up_down = '1') then
					direction <= 1;
				else
					direction <= -1;
				end if;
		end process;

		process(up_down_clk,up_down_reset)
		
			begin
				if(rising_edge(up_down_clk)) then
					if up_down_reset = '0' then
						counter <= 0;
					else
						counter <= counter + direction;
					end if;
				end if;
			count_out <= std_logic_vector(to_unsigned(counter,7));
		end process;


end architecture;