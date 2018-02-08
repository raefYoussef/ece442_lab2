----------------------------------------------------------------------------------
-- Company: JHU Masters
-- Engineer: Raef Youssef
-- 
-- Create Date: 02/07/2018 11:15:32 PM
-- Design Name: 
-- Module Name: seg7_controller - behavioral
-- Project Name: lab2
-- Target Devices: Nexys 4 DDR (Artix-7 XC7A100T-1CSG324C)
-- Tool Versions: Vivado 2017.2
-- Description: 7 Segment Display Controller
-- 
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.lab2_pkg.all;

entity seg7_controller is
	port ( 
		i_clk			: in	std_logic;
		i_arst			: in	std_logic;
		i_en			: in	std_logic					:= '1';
		i_chars			: in 	char_array_t(7 downto 0)	:= (others => (others => '0'));
		o_lcd_cathode	: out 	std_logic_vector(7 downto 0);
		o_lcd_anaode	: out 	std_logic_vector(7 downto 0)
	);
end seg7_controller;

architecture behavioral of seg7_controller is

	signal curr_index	: unsigned(2 downto 0);
	signal next_index	: unsigned(2 downto 0);
	
begin

	-- index reg
	process (i_clk, i_arst) begin
		if i_arst = '1' then
			curr_index	<= (others => '0');
		elsif rising_edge(i_clk) then
			curr_index	<= next_index;
		end if;
	end process;

	-- cathode & anaode
	process (curr_index) begin
		
		
		if i_en = '1' then
			next_index	<= curr_index + 1;
		else
			next_index	<= curr_index;
		end if;
		
		
	end process;
	
end behavioral;
