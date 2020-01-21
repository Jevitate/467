library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity user_pattern is
	port(clk	:	in std_logic;
		  reset	:	in std_logic;
		  LED		: out std_logic_vector(6 downto 0)); 
end entity;

architecture user_pattern_arch of user_pattern is

	signal shifter : BIT_vector(6 downto 0) := "0001000";
	signal top_piece : BIT_vector(3 downto 0) := shifter(6 downto 3);
	signal bottom_piece : BIT_vector(3 downto 0) := shifter(3 downto 0);
	
	begin

	
	process(clk,reset)
	
		begin
		
		if(reset = '0') then
			LED <= "1000000";
		elsif rising_edge(clk) then

			top_piece <= top_piece rol 1;
			bottom_piece <= bottom_piece ror 1;
			LED(6 downto 3) <= to_stdlogicvector(top_piece);
			LED(3 downto 0) <= to_stdlogicvector(bottom_piece);
			--LED <= to_stdlogicvector(top_piece) & to_stdlogicvector(bottom_piece);
		end if;
	end process;





end architecture;
