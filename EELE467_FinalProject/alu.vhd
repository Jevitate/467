library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity alu is 
	port(
	A					: in signed(31 downto 0);
	B					: in signed(31 downto 0);
	ALU_Control		: in std_logic_vector(2 downto 0);
	
	ZNF_one			: out std_logic_vector(2 downto 0);
	ZNF_two			: out std_logic_vector(2 downto 0);
	ALU_Result		: out std_logic_vector(63 downto 0)
	);
end entity;


architecture alu_arch of alu is

	signal sum_signed		: signed(32 downto 0);
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
					sum_signed <= signed('0' & A) + signed('0' & B);
					ALU_Result(31 downto 0) <= std_logic_vector(sum_signed(31 downto 0));
					
									-- 0000 -> 0ZNF -- 
					
									-- Zero Flag --
					
					if(sum_signed(31 downto 0) = 0) then
						ZNF_one(2) <= '1';
					else
						ZNF_one(2) <= '0';
					end if;
					
									-- Negative Flag --
					
					ZNF_one(1) <= sum_signed(31);
						
									-- Overflow Flag/Carry Flag, Uses both registers --
					
					ZNF_one(0) <= sum_signed(32);
----------------------------------------------------------------------------------------------------					
						
				when "010" =>
				
									-- Sub --
									
					ALU_Result <= std_logic_vector(to_unsigned(0, 64));
					sum_signed <= signed('0' & A) - signed('0' & B);
					ALU_Result(31 downto 0) <= std_logic_vector(sum_signed(31 downto 0));
					
									-- 0000 -> 0ZNF --
					
									-- Zero Flag --
					
					if(sum_signed(31 downto 0) = 0) then
						ZNF_one(2) <= '1';
					else
						ZNF_one(2) <= '0';
					end if;
					
									-- Negative Flag --
					
					ZNF_one(1) <= sum_signed(31);
						
									-- Overflow Flag/Carry Flag, Uses both registers -- 
					
					ZNF_one(0) <= sum_signed(32);
					
----------------------------------------------------------------------------------------------------				
				when "011" =>
				
									-- Multiply A*B --	
									
					ALU_Result <= std_logic_vector(to_unsigned(0, 64));
					mult_unsigned <= (signed(A) * signed(B));
					ALU_Result <= std_logic_vector(mult_unsigned);
				
									-- Zero Flag --
					
					if(mult_unsigned = 0) then
						ZNF_one(2) <= '1';
					else
						ZNF_one(2) <= '0';
					end if;
					
									-- Negative Flag --
					
					ZNF_one(1) <= mult_unsigned(63);
						
									-- Overflow Flag/Carry Flag, Uses both registers -- 
					
					if((unsigned(mult_unsigned(63 downto 32)) > 0) and (unsigned(mult_unsigned(31 downto 0)) > 0)) then
						ZNF_one(0) <= '1';
					else
						ZNF_one(0) <= '0';
					end if;
				
----------------------------------------------------------------------------------------------------				
				when "100" =>
				
									-- Decrement B --
					ALU_Result <= std_logic_vector(to_unsigned(0, 64));				
					dummy_B <= std_logic_Vector(B - 1);
					ALU_Result(31 downto 0) <= dummy_B;
					
									-- Zero Flag --
					
					if(dummy_B = 0) then
						ZNF_one(2) <= '1';
					else
						ZNF_one(2) <= '0';
					end if;
					
									-- Negative Flag --
					
					ZNF_one(1) <= dummy_B(31);
						
									-- Overflow Flag/Carry Flag, Uses both registers -- 
									
					ZNF_one(0) <= '0';
				
					
----------------------------------------------------------------------------------------------------				
				when "101" =>
				
									-- Move A into Result --
					ALU_Result <= std_logic_vector(to_unsigned(0, 64));				
					dummy_A <= std_logic_vector(A);
					ALU_Result(31 downto 0) <= dummy_A;
					
									-- Zero Flag --
					
					if(dummy_A = 0) then
						ZNF_one(2) <= '1';
					else
						ZNF_one(2) <= '0';
					end if;
					
									-- Negative Flag --
					
					ZNF_one(1) <= dummy_A(31);
						
									-- Overflow Flag/Carry Flag, Uses both registers -- 
									
					ZNF_one(0) <= '0';
	
----------------------------------------------------------------------------------------------------				
				when "110" =>
				
									-- Swap A <-> B --

									
									
									
----------------------------------------------------------------------------------------------------				
				when "111" => 
				
									-- Custom --
									-- XOR Odd bits, A, B --
					dummy_A <= std_logic_vector(A);					
					dummy_B <= std_logic_vector(B);					
					dummy_A <= std_logic_vector(A) XOR x"AAAAAAAA";
					dummy_B <= std_logic_vector(B) XOR x"AAAAAAAA";
					ALU_Result(63 downto 32) <= dummy_B;
					ALU_Result(31 downto 0) <= dummy_A;
				
									-- Zero Flag --
					
					if(dummy_A = 0) then
						ZNF_one(2) <= '1';
					else
						ZNF_one(2) <= '0';
					end if;
					
					if(dummy_B = 0) then
						ZNF_two(2) <= '1';
					else
						ZNF_two(2) <= '0';
					end if;					
					
									-- Negative Flag --
					
					ZNF_one(1) <= dummy_A(31);
					ZNF_two(1) <= dummy_B(31);
						
									-- Overflow Flag/Carry Flag, Uses both registers -- 
									
					ZNF_one(0) <= '0';
					ZNF_two(0) <= '0';
				
----------------------------------------------------------------------------------------------------				
				when others =>
				
									-- Catch Case --
				
			end case;
	end process;
	
end architecture;

