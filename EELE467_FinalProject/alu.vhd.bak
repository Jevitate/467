library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity alu is 
	port(
	A					: in signed(31 downto 0);
	B					: in signed(31 downto 0);
	ALU_Control		: in std_logic_vector(2 downto 0);
	
	ZNF				: out std_logic_vector(2 downto 0);
	ALU_Result		: out std_logic_vector(63 downto 0)
	);
end entity;


architecture alu_arch of alu is

	signal sum_unsigned		: unsigned(32 downto 0);
	signal mult_unsigned		: signed(63 downto 0);
	signal dummy_A				: std_logic_vector(31 downto 0);
	signal dummy_B				: std_logic_vector(31 downto 0);
	signal dummy_out			: std_logic_Vector(63 downto 0);
	
	begin
	
	ALU_Process : process(ALU_Control)
	
		begin
		
			case ALU_Control is
				
				when "000" => 
				
									-- Nothing Happens --
----------------------------------------------------------------------------------------------------				
				when "001" =>
					
										-- Sum --
					
					ALU_Result <= std_logic_vector(to_unsigned(0, 64));
					sum_unsigned <= unsigned('0' & A) + unsigned('0' & B);
					ALU_Result(32 downto 0) <= std_logic_vector(sum_unsigned);
					
									-- 0000 -> 0ZNF -- 
					
									-- Zero Flag --
					
					if(sum_unsigned(31 downto 0) = 0) then
						ZNF(2) <= '1';
					else
						ZNF(2) <= '0';
					end if;
					
									-- Negative Flag --
					
					ZNF(1) <= sum_unsigned(31);
						
									-- Overflow Flag/Carry Flag, Uses both registers --
					
					ZNF(0) <= sum_unsigned(32);
----------------------------------------------------------------------------------------------------					
						
				when "010" =>
				
									-- Sub --
									
					ALU_Result <= std_logic_vector(to_unsigned(0, 64));
					sum_unsigned <= unsigned('0' & A) - unsigned('0' & B);
					ALU_Result(32 downto 0) <= std_logic_vector(sum_unsigned);
					
									-- 0000 -> 0ZNF --
					
									-- Zero Flag --
					
					if(sum_unsigned(31 downto 0) = 0) then
						ZNF(2) <= '1';
					else
						ZNF(2) <= '0';
					end if;
					
									-- Negative Flag --
					
					ZNF(1) <= sum_unsigned(31);
						
									-- Overflow Flag/Carry Flag, Uses both registers -- 
					
					ZNF(0) <= sum_unsigned(32);
					
----------------------------------------------------------------------------------------------------				
				when "011" =>
				
									-- Multiply A*B --	
									
					ALU_Result <= std_logic_vector(to_unsigned(0, 64));
					mult_unsigned <= (signed(A) * signed(B));
					ALU_Result <= std_logic_vector(mult_unsigned);
				
									-- Zero Flag --
					
					if(mult_unsigned = 0) then
						ZNF(2) <= '1';
					else
						ZNF(2) <= '0';
					end if;
					
									-- Negative Flag --
					
					ZNF(1) <= mult_unsigned(63);
						
									-- Overflow Flag/Carry Flag, Uses both registers -- 
					
					if((unsigned(mult_unsigned(63 downto 32)) > 0) and (unsigned(mult_unsigned(31 downto 0)) > 0)) then
						ZNF(0) <= '1';
					else
						ZNF(0) <= '0';
					end if;
				
----------------------------------------------------------------------------------------------------				
				when "100" =>
				
									-- Decrement B --
					ALU_Result <= std_logic_vector(to_unsigned(0, 64));				
					dummy_B <= std_logic_Vector(B - 1);
					ALU_Result(31 downto 0) <= dummy_B;
					
									-- Zero Flag --
					
					if(dummy_B = 0) then
						ZNF(2) <= '1';
					else
						ZNF(2) <= '0';
					end if;
					
									-- Negative Flag --
					
					ZNF(1) <= dummy_B(31);
						
									-- Overflow Flag/Carry Flag, Uses both registers -- 
									
					ZNF(0) <= '0';
				
					
----------------------------------------------------------------------------------------------------				
				when "101" =>
				
									-- Move A into Result --
					ALU_Result <= std_logic_vector(to_unsigned(0, 64));				
					dummy_A <= std_logic_vector(A);
					ALU_Result(31 downto 0) <= dummy_A;
					
									-- Zero Flag --
					
					if(dummy_A = 0) then
						ZNF(2) <= '1';
					else
						ZNF(2) <= '0';
					end if;
					
									-- Negative Flag --
					
					ZNF(1) <= dummy_A(31);
						
									-- Overflow Flag/Carry Flag, Uses both registers -- 
									
					ZNF(0) <= '0';
	
----------------------------------------------------------------------------------------------------				
				when "110" =>
				
									-- Swap A <-> B --
				--dummy_A <= std_logic_vector(A);
				--dummy_B <= std_logic_vector(B);
				--dummy_out(63 downto 32) <= dummy_B;
				--dummy_out(31 downto 0)  <= dummy_A;
				--ALU_Result <= dummy_out;
				--A <= signed(dummy_out(63 downto 32));
				--B <= signed(dummy_out(31 downto 0));
				
----------------------------------------------------------------------------------------------------				
				when "111" => 
				
									-- Custom --
----------------------------------------------------------------------------------------------------				
				when others =>
				
									-- Catch Case --
				
			end case;
	end process;
	
end architecture;

