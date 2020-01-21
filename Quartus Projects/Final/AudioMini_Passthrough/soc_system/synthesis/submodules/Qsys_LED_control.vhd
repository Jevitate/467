library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity Qsys_LED_control is
	port(
			clk					: in std_logic;
			reset_n				: in std_logic;
			avs_s1_address 	: in std_logic_vector(1 downto 0);
			avs_s1_write 		: in std_logic;
			avs_s1_writedata 	: std_logic_vector(31 downto 0);
			avs_s1_read 		: in std_logic;
			avs_s1_readdata	: out std_logic_vector(31 downto 0);
			switches 			: in std_logic_vector(3 downto 0);
			pushbutton 			: in std_logic;
			LEDs 					: out std_logic_vector(7 downto 0)
		 );
end entity;
	
	
architecture Qsys_arch of Qsys_LED_control is


	signal Register0 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal Register1 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(50000000,32));
	signal Register2 : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0,32));
	signal Register3 : std_logic_vector(31 downto 0) := "00000000000000000000000000010000";

	
	component LED_control port(
        clk            : in  std_logic;                         -- system clock
        reset          : in  std_logic;                         -- system reset
        PB             : in  std_logic;                         -- Pushbutton to change state  
        SW             : in  std_logic_vector(3 downto 0);      -- Switches that determine next state
        HS_LED_control : in  std_logic;                         -- Software is in control when asserted (=1)
        SYS_CLKs_sec   : in  std_logic_vector(31 downto 0);     -- Number of system clock cycles in one second
        Base_rate      : in  std_logic_vector(7 downto 0);      -- base transition time in seconds, fixed-point data type (8,4)
        LED_reg        : in  std_logic_vector(7 downto 0);      -- LED register
        LED            : out std_logic_vector(7 downto 0)       -- LEDs on the DE10-Nano board
    );
	end component;
	
	
	begin
	
	
	
	process(clk) is
		begin
		
		if(rising_edge(clk) and avs_s1_read = '1') then
			
			case avs_s1_address is
				
				when "00" => avs_s1_readdata <= Register0;
				when "01" => avs_s1_readdata <= Register1;
				when "10" => avs_s1_readdata <= Register2;
				when "11" => avs_s1_readdata <= Register3;
				when others => avs_s1_readdata <= (others => '0');
				
			end case;
		end if;
	end process;
	
	process(clk) is
		begin
		
		if(rising_edge(clk) and avs_s1_write = '1') then
			
			case avs_s1_address is
			
				when "00" => Register0 <= avs_s1_writedata;
				when "01" => Register1 <= avs_s1_writedata;
				when "10" => Register2 <= avs_s1_writedata;
				when "11" => Register3 <= avs_s1_writedata;
				when others => null;
				
			end case;
		end if;
	end process;
	
	LD1 : LED_control port map(
		clk => clk,
		reset => reset_n,
		PB => pushbutton,
		SW => switches,
		HS_LED_control => Register0(0),
		SYS_CLKs_sec => Register1,
		Base_rate => Register3(7 downto 0),
		LED_reg => Register2(7 downto 0),
		LED => LEDs);
		
	
	
	
end architecture;


