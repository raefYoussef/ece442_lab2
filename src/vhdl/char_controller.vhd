----------------------------------------------------------------------------------
-- Company: JHU Masters
-- Engineer: Raef Youssef
-- 
-- Create Date: 02/08/2018 08:36:31 PM
-- Design Name: 
-- Module Name: char_controller - behavioral
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

library work;
use work.lab2_pkg.all;

entity char_controller is
	port ( 
		i_clk100		: in 	std_logic;				-- 100 MHz
		i_arst			: in 	std_logic;	
		i_duration		: in 	unsigned(31 downto 0);	-- Multiple of 10ns	
		i_hex_char		: in 	std_logic_vector(3 downto 0)	:= (others => '0');
		o_hex_chars		: out	hex_chars_t(7 downto 0) 			
	);
end char_controller;

architecture behavioral of char_controller is
	
	component pulse_generator is
		port ( 
			i_clk		: in	std_logic;
			i_arst		: in 	std_logic;
			i_width		: in 	unsigned(31 downto 0);
			o_pulse		: out 	std_logic
		);
	end component;
	
	signal pulse			: std_logic;
	signal curr_shift_reg	: hex_chars_t(7 downto 0);
	signal next_shift_reg	: hex_chars_t(7 downto 0);
	
begin

	pulse_generator_inst: pulse_generator
		port map ( 
			i_clk		=> i_clk100 ,
			i_arst		=> i_arst,
			i_width		=> i_duration,
			o_pulse		=> pulse
		);

	-- shift register reg
	process (i_clk100, i_arst) begin
		if i_arst = '1' then
			curr_shift_reg	<= (others => (others => '0'));
		elsif rising_edge(i_clk100) then
			curr_shift_reg	<= next_shift_reg;
		end if; 
	end process;
	
	-- shift register comb
	process (pulse, i_hex_char, curr_shift_reg) begin
		
		o_hex_chars		<= curr_shift_reg;
		next_shift_reg	<= curr_shift_reg;
		
		if pulse = '1' then
			next_shift_reg(0)			<= i_hex_char;
			next_shift_reg(7 downto 1)	<= curr_shift_reg(6 downto 0);
		end if;
	end process;
	
end behavioral;
