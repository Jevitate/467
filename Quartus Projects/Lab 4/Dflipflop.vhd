library ieee;
use ieee.std_logic_1164.all;

entity Dflipflop is
	port	(clock	: in std_logic;
			 reset	: in std_logic;
			 D			: in std_logic;
			 Q, Qn	: out std_logic);
end entity;


architecture Dflipflop_arch of Dflipflop is

	begin
	
	D_FLIP_FLOP	:	process(clock, reset)
		
		begin
		
		if(reset = '0') then
			Q <= '0'; 
			Qn <= '1';
		elsif(rising_edge(clock)) then
			Q <= D; 
			Qn <= not D;
		end if;
	end process;
	
end architecture;

