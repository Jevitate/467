library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity shift_left_2leds is
	port(clk	:	in std_logic;
		  reset	:	in std_logic;
		  LED		: out std_logic_vector(6 downto 0)); 
end entity;

architecture shift_left_arch of shift_left_2leds is

	signal shifter : BIT_vector(6 downto 0) := "1100000";

	begin

	
	process(clk,reset)
	
		begin
		
		if(reset = '0') then
			LED <= "0011000";
		elsif rising_edge(clk) then
			LED <= to_stdlogicvector(shifter);
			shifter <= shifter rol 1;
		end if;
	end process;





end architecture;