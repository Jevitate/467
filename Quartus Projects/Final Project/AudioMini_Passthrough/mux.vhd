library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity mux is
	port(
	clock				: in std_logic;
	reset				: in std_logic;
	switches			: in std_logic_vector(3 downto 0);
	ZNF				: in std_logic_vector(2 downto 0);
	MUX_ALU_Result	: in std_logic_vector(63 downto 0);
	A					: in std_logic_vector(31 downto 0);
	B					: in std_logic_vector(31 downto 0);
	LEDs 				: out std_logic_vector(7 downto 0)
	);
end entity;


architecture mux_arch of mux is

	
	--switches, 3-2, 00 -> 1 2 3 4

	--switches, 1-0, 00 -> 1 2 3 4
	
	signal control_data : std_logic_vector(31 downto 0);

	begin
	
	
		process(clock) is
	
		begin
		
		if(rising_edge(clock)) then
			
			case switches(3 downto 2) is
				
				when "00" => control_data <= A;
				when "01" => control_data <= B;
				when "10" => control_data <= MUX_ALU_Result(31 downto 0);
				when "11" => control_data <= MUX_ALU_Result(63 downto 32);
				when others => LEDs <= (others => '0');
				
			end case;
		end if;
	end process;
	
	process(clock) is
	
		begin
		
		if(rising_edge(clock)) then
			
			case switches(1 downto 0) is
			
				when "00" => LEDs <= control_data(7 downto 0);
				when "01" => LEDs <= control_data(15 downto 8);
				when "10" => LEDs <= control_data(23 downto 16);
				when "11" => LEDs <= control_data(31 downto 24);
				when others => LEDs <= (others => '0');
				
			end case;
		end if;
	end process;
	
	
end architecture;


