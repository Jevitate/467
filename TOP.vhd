library IEEE;
use ieee.std_logic_1164.all;

entity state_machine is
	Port(	clk:	IN STD_LOGIC;
 		reset:	IN STD_LOGIC;
		in1:	IN STD_LOGIC;
		out1:	OUT STD_LOGIC);
END state_machine;


architecture state_machine_arch of state_machine is 
	
	type State_Type is (A, B, C);
	signal current_state, next_state : State_Type;

	begin

	STATE_MEMORY : process(clk, reset)
	
		begin
			
			if(reset = '0') then
				current_state <= A;
			elsif(rising_edge(clk)) then
				current_state <= next_state;
			end if;
		end process;

	NEXT_STATE_LOGIC : process(current_state, in1)

		begin
			
			case(current_state) is
				when A => if(in1 = '1') then
						next_state <= B;
					  else
						next_state <= A;
					  end if;
				when B => if(in1 = '1') then
						next_state <= C;
					  else
						next_state <= B;
					  end if;
				when C => next_state <= A;
			end case;
		end process;

	OUT_LOGIC : process(current_state)
		
		begin
		
			case(current_state) is
				when A => out1 <= '0';
				when B => out1 <= '0';
				when C => out1 <= '1';
			end case;
		end process;
end architecture;



