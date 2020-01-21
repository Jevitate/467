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
       
       
       
begin

		LED(3 downto 0) <= SW(3 downto 0);
		LED(7 downto 4) <= "0000";
       -- Add code to connect four switches to four LEDs



end architecture DE10_arch;
