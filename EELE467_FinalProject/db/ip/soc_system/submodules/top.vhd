library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;



entity top is
	port(
		clock					: in std_logic;
		reset					: in std_logic;
		switches				: in std_logic_vector(3 downto 0);
		
		avs_s1_address		: in std_logic_vector(2 downto 0);
		avs_s1_write		: in std_logic;
		avs_s1_writedata	: in std_logic_vector(31 downto 0);
		avs_s1_read			: in std_logic;
		avs_s1_readdata	: out std_logic_vector(31 downto 0);
		
		LEDs				: out std_logic_vector(7 downto 0)
		);

	
end entity;

architecture top_arch of top is 

	signal Register0 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal Register1 : std_logic_Vector(31 downto 0) := std_logic_Vector(to_unsigned(0,32));
	signal Register2 : std_logic_Vector(31 downto 0) := std_logic_Vector(to_unsigned(0,32));
	signal Register3 : std_logic_Vector(31 downto 0) := std_logic_Vector(to_unsigned(0,32));
	signal Register4 : std_logic_Vector(31 downto 0) := std_logic_Vector(to_unsigned(0,32));
	signal Register5 : std_logic_Vector(31 downto 0) := std_logic_Vector(to_unsigned(0,32));
	signal Register6 : std_logic_Vector(31 downto 0) := std_logic_Vector(to_unsigned(0,32));
	
	signal op_control : std_logic;
	signal RegisterA : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal RegisterB : std_logic_Vector(31 downto 0) := std_logic_Vector(to_unsigned(0,32));
	signal Register_OP_Control : std_logic_Vector(31 downto 0) := std_logic_Vector(to_unsigned(0,32));
	
	component alu port(
	A					: in signed(31 downto 0);
	B					: in signed(31 downto 0);
	ALU_Control		: in std_logic_vector(2 downto 0);
	ZNF_one			: out std_logic_vector(2 downto 0);
	ZNF_two			: out std_logic_vector(2 downto 0);
	ALU_Result		: out std_logic_vector(63 downto 0)
	);
	end component;
	
	
	component mux port(
	clock				: in std_logic;
	switches			: in std_logic_vector(3 downto 0);
	ZNF				: in std_logic_vector(2 downto 0);
	MUX_ALU_Result	: in std_logic_vector(63 downto 0);
	A					: in std_logic_vector(31 downto 0);
	B					: in std_logic_vector(31 downto 0);
	LEDs 				: out std_logic_vector(7 downto 0)
	);
	end component;
	
	
	
	begin
	
	
	process(clock) is
	
		begin
		
		if(rising_edge(clock) and avs_s1_read = '1') then
			
			case avs_s1_address is
				
				when "000" => avs_s1_readdata <= Register0;
				when "001" => avs_s1_readdata <= Register1;
				when "010" => avs_s1_readdata <= Register2;
				when "011" => avs_s1_readdata <= Register3;
				when "100" => avs_s1_readdata <= Register4;
				when "101" => avs_s1_readdata <= Register5;
				when "110" => avs_s1_readdata <= Register6;
				when others => avs_s1_readdata <= (others => '0');
				
			end case;
		end if;
	end process;
	
	process(clock) is
	
		begin
		
		if(rising_edge(clock) and avs_s1_write = '1') then
			
			case avs_s1_address is
			
				when "000" => 
				Register0 <= avs_s1_writedata;
				op_control <= '0';
				when "001" => 
				Register1 <= avs_s1_writedata;
				op_control <= '0';
				when "010" => 
					Register2 <= avs_s1_writedata;
					op_control <= '1';
				when others => null;
				
			end case;
		end if;
	end process;	
	
	
	
	process(clock) is
	
		begin
		
		
		
		if(rising_edge(clock) and Register2 = 6) then
			RegisterA <= Register1;
			RegisterB <= Register0;
			Register_OP_Control <= x"00000000";
			
		elsif(rising_edge(clock)) then
			RegisterA <= Register0;
			RegisterB <= Register1;
			if(op_control = '1') then
				Register_OP_Control <= Register2;
			elsif(op_control = '0') then
				Register_OP_Control <= X"00000000";
			end if;
			
		end if;
		
	
	end process;
	
	
	
		ALU_1:	alu port map(
			A => signed(RegisterA),
			B => signed(RegisterB),
			ALU_Control => Register_OP_Control(2 downto 0),
			ZNF_one => Register5(2 downto 0),
			ZNF_two => Register6(2 downto 0),
			ALU_Result(31 downto 0) => Register3,
			ALU_Result(63 downto 32) => Register4);	
	
		MUX_1 : mux port map(
			clock => clock,
			switches => switches,
			A => RegisterA,
			B => RegisterB,
			ZNF => Register5(2 downto 0),
			MUX_ALU_Result(63 downto 32) => Register4,
			MUX_ALU_Result(31 downto 0) => Register3,
			LEDs => LEDs
			);
		
	
end architecture;

