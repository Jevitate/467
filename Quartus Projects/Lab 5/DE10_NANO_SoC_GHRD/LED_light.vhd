library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity LED_light is
	port(clk : in std_logic;
		  SW  : in  std_logic_vector(3 downto 0); 
		  LED : out std_logic_vector(7 downto 0));

end entity;



architecture LED_light_arch of LED_light is


	signal counter : integer := 0;
	


	begin
	
	process(clk)
	
	begin
	
	if(rising_edge(clk)) then
		counter <= counter + 1;
		LED(6 downto 0) <= "000" & SW;
		if(counter = 50000000) then
			counter <= 0;
		end if;
	end if;
	
	end process;
end architecture;


