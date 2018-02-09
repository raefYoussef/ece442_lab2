----------------------------------------------------------------------------------
-- Company: JHU Masters
-- Engineer: Raef Youssef
-- 
-- Create Date: 02/08/2018 08:05:23 PM
-- Design Name: 
-- Module Name: pulse_generator - behavioral
-- Project Name:  
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulse_generator is
  port ( 
  	i_clk		: in	std_logic;
  	i_arst		: in 	std_logic;
  	i_width		: in 	std_logic_vector(31 downto 0);
  	o_pulse		: out 	std_logic
  );
end pulse_generator;

architecture behavioral of pulse_generator is

	signal curr_cntr	: unsigned(31 downto 0);
	signal next_cntr	: unsigned(31 downto 0);
	
begin
	
	process (i_clk, i_arst) begin
		if i_arst = '1' then
			curr_cntr	<= (others => '0');
		elsif rising_edge(i_clk) then
			curr_cntr	<= next_cntr;
		end if;
	end process;
	
	process (curr_cntr, i_width) begin
		
		o_pulse		<= '0';
		next_cntr	<= curr_cntr + 1;
		
		if (curr_cntr = unsigned(i_width)) then
			o_pulse		<= '1';
			next_cntr	<= (others => '0'); 	
		end if;
	end process;
	
end behavioral;
