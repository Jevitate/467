--! @file
--! 
--! @author Raymond Weber
--! @author Ross Snider


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

LIBRARY altera;
USE altera.altera_primitives_components.all;


entity DE10_Top_Level is
	port(
		----------------------------------------
		--  CLOCK Inputs
		----------------------------------------
		FPGA_CLK1_50  :  in std_logic;										
		FPGA_CLK2_50  :  in std_logic;										
		FPGA_CLK3_50  :  in std_logic;										

		----------------------------------------
		--  Push Button Inputs (signal name = KEY) - vector with 2 inputs
		--  The KEY inputs produce a '0' when pressed (asserted)
		--  and produce a '1' in the rest state
		--  a better label for KEY would be Push_Button_n 
		----------------------------------------
		KEY : in std_logic_vector(1 downto 0);								-- Pushbuttons on the DE10

		----------------------------------------
		--  Switch Inputs (SW) - 4 inputs
		----------------------------------------
		SW  : in std_logic_vector(3 downto 0);								-- Slide Switches on the DE10

		----------------------------------------
		--  LED Outputs - 8 outputs
		----------------------------------------
		LED : out std_logic_vector(7 downto 0);							-- LEDs on the DE10

		----------------------------------------
		--  GPIO
		----------------------------------------
		GPIO_0 : inout std_logic_vector(35 downto 0);					-- The 40 pin header on the   top  of the DE10 board
		GPIO_1 : inout std_logic_vector(35 downto 0)					   -- The 40 pin header on the bottom of the DE10 board 
		
	);
end entity DE10_Top_Level;


architecture DE10_arch of DE10_Top_Level is
       
		 
	component LED_control is
		port	(
        clk            : in  std_logic;                         -- system clock
        reset          : in  std_logic;                         -- system reset
        PB             : in  std_logic;                         -- Pushbutton to change state  
        SW             : in  std_logic_vector(3 downto 0);      -- Switches that determine next state
        HS_LED_control : in  std_logic;                         -- Software is in control when asserted (=1)
        SYS_CLKs_sec   : in  std_logic_vector(31 downto 0);     -- Number of system clock cycles in one second
        Base_rate      : in  std_logic_vector(7 downto 0);      -- base transition time in seconds, fixed-point data type
        LED_reg        : in  std_logic_vector(7 downto 0);      -- LED register
        LED            : out std_logic_vector(7 downto 0));		  -- LEDs on the DE10-Nano board
		 
	end component;
	
       
begin
		--LED(3 downto 0) <= SW(3 downto 0);
		--LED(7 downto 4) <= "0000";
      -- Add code to connect four switches to four LEDs

		LED1: LED_control port map(
			clk => FPGA_CLK1_50,
			reset => KEY(1),
			PB => KEY(0),
			SW => SW,
			HS_LED_control => '0',
			SYS_CLKs_sec => std_logic_vector(to_unsigned(50000000, 32)),
			Base_rate => "00010000",
			LED_reg(7 downto 0) => "10101010",
			LED => LED);

end architecture DE10_arch;
