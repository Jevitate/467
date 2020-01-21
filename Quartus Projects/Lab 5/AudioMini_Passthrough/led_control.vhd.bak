library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;



entity LED_control is
    port(
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
end entity LED_control;



architecture LED_control_arch of LED_control is 
	
	signal light_em_up : std_logic_vector(6 downto 0);
	signal light_em_up_left_2leds : std_logic_vector(6 downto 0);
	signal light_em_up_up : std_logic_vector(6 downto 0);
	signal light_em_up_down : std_logic_vector(6 downto 0);
	signal light_em_up_user : std_logic_vector(6 downto 0);
	
	signal base_rate_clk : std_logic;
	signal base_rate_clkx2 : std_logic;
	signal base_rate_clkx4 : std_logic;
	signal base_ratex2 : std_logic_vector(7 downto 0);
	signal base_ratex4 : std_logic_vector(7 downto 0);
	signal button : std_logic := '0';
	signal toggle : std_logic := '0';
	
	signal control : std_logic;
	signal flag : std_logic;
	signal counter_flag : std_logic := '0';
	signal counter : integer := 0;
	
	type state_type is(s0, s1, s2, s3, s4, s5);
	signal current_state, next_state, LED_state : state_type;
	
	
	component PB_condition is
		port(
		  clk		: in std_logic;
		  reset	: in std_logic;
		  PB_in	: in std_logic;
		  PB_out	: out std_logic);
	end component;
	
	component clk_changer is
		port(
		changer_clk : in std_logic;
		changer_cycles : in std_logic_vector(31 downto 0);
		changer_base : in std_logic_vector(7 downto 0);
		changed_clk : out std_logic);
	end component;
	
	component shift_right_leds is
		port(
		  clk		:	in std_logic;
		  reset	:	in std_logic;
		  LED		: out std_logic_vector(6 downto 0));
	end component;
	
	component shift_left_2leds is
		port(
		  clk		:	in std_logic;
		  reset	:	in std_logic;
		  LED		: out std_logic_vector(6 downto 0));
	end component;
		  
	component up_down_counter is
		port(
		up_down_clk : in std_logic;
		up_down_reset : in std_logic;
		up_down : in std_logic;
		count_out : out std_logic_vector(6 downto 0));
	end component;
	
	component user_pattern is
		port(
		  clk	   :	in std_logic;
		  reset	:	in std_logic;
		  LED		: out std_logic_vector(6 downto 0)); 
	end component;
	
		  
	begin
	
	base_ratex2 <= "0" & Base_rate(7 downto 1);
	base_ratex4 <= "00" & Base_rate(7 downto 2);

		Debouce_Button : PB_condition port map(
			clk => clk,
			reset => reset,
			PB_in => PB,
			PB_out => button);
			
		clk_change_1x : clk_changer port map(
			changer_clk => clk,
			changer_cycles => SYS_CLKs_sec,
			changer_base => Base_rate,
			changed_clk => base_rate_clk);
			
		clk_change_2x : clk_changer port map(
			changer_clk => clk,
			changer_cycles => SYS_CLKs_sec,
			changer_base => base_ratex2,
			changed_clk => base_rate_clkx2);
			
		clk_change_4x : clk_changer port map(
			changer_clk => clk,
			changer_cycles => SYS_CLKs_sec,
			changer_base => base_ratex4,
			changed_clk => base_rate_clkx4);
			
		shifter_right : shift_right_leds port map(
			clk => base_rate_clkx2,
			reset => reset,
			LED => light_em_up);
			
		shifter_left_2 : shift_left_2leds port map(
			clk => base_rate_clkx4,
			reset => reset,
			LED => light_em_up_left_2leds);
		
		upcount : up_down_counter port map(
			up_down_clk => base_rate_clk,
			up_down_reset => reset,
			up_down => '1',
			count_out => light_em_up_up);
			
	   downcount : up_down_counter port map(
			up_down_clk => base_rate_clkx4,
			up_down_reset => reset,
			up_down => '0',
			count_out => light_em_up_down);
			
		somekindathing : user_pattern port map(
			clk => base_rate_clkx2,
			reset => reset,
			LED => light_em_up_user);
			
	process(base_rate_clk)
		begin
			if(HS_LED_control = '1') then
				control <= '0';
			elsif(rising_edge(base_rate_clk) and HS_LED_control = '0') then
				LED(7) <= toggle;
				toggle <= not(toggle);
			end if;
	end process;
	
	process(clk,button)
		begin
		
			if(button = '0') then
				counter <= 0;
				counter_flag <= '0';
			elsif(rising_edge(clk)) then
				counter <= counter + 1;
				if(counter = 50000000) then
					counter_flag <= '1';
					counter <= 0;
				end if;
			end if;
	end process;
	
	STATE_MEMORY  :  process(clk)
		
		begin
			if(rising_edge(clk)) then
				current_state <= next_state;
			end if;
	end process;
	
	
	
	NEXT_STATE_LOGIC  :  process(SW, button, reset)
		
		begin
			
			if(button = '0') then
				next_state <= s5;
				flag <= '1';
			end if;
					
			if(counter_flag = '1' and flag = '1') then
				if(SW = "0000") then
					next_state <= s0;
					LED_state <= s0;
					flag <= '0';
				elsif(SW = "0001") then
					next_state <= s1;
					LED_state <= s1;
					flag <= '0';
				elsif(SW = "0010") then
					next_state <= s2;
					LED_state <= s2;
					flag <= '0';
				elsif(SW = "0011") then
					next_state <= s3;
					LED_state <= s3;
					flag <= '0';
				elsif(SW = "0100") then
					next_state <= s4;
					LED_state <= s4;
					flag <= '0';
				else
					next_state <= LED_state;
					flag <= '0';
				end if;
			end if;

	
				
	end process;

	
	OUT_PUT_LOGIC  :  process(next_state, HS_LED_control)
		
		begin
			if(HS_LED_control = '1') then
				LED(6 downto 0) <= LED_reg(6 downto 0);
			else
				case(next_state) is
					when s0 =>
						LED(6 downto 0) <= light_em_up;
					when s1 => 
						LED(6 downto 0) <= light_em_up_left_2leds;
					when s2 =>
						LED(6 downto 0) <= light_em_up_up;
					when s3 =>
						LED(6 downto 0) <= light_em_up_down;
					when s4 =>
						LED(6 downto 0) <= light_em_up_user;
					when s5 =>
						LED(6 downto 0) <= "000" & SW;
					when others =>
						LED(6 downto 0) <= "1101101";
				end case;
			end if;
	end process;

end architecture;


