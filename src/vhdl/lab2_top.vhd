----------------------------------------------------------------------------------
-- Company: JHU Masters
-- Engineer: Raef Youssef
-- 
-- Create Date: 02/07/2018 10:58:44 PM
-- Design Name: 
-- Module Name: lab2_top - behavioral
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

entity lab2_top is
	port ( 
		--Clock
		I_CLK100MHZ		: in	std_logic;
		
		--Push Buttons
		I_BTNC			: in	std_logic;
		
		--Switches (16 Switches)
		I_SW			: in 	std_logic_vector(15 downto 0);
		
		--LEDs (16 LEDs)
		O_LED			: out	std_logic_vector(15 downto 0);
		
		--Seg7 Display Signals
		O_SEG7_CATH		: out	std_logic_vector(7 downto 0);
		O_SEG7_AN		: out	std_logic_vector(7 downto 0)
	);
end lab2_top;

architecture behavioral of lab2_top is
	
	component char_controller is
		port ( 
			i_clk100		: in 	std_logic;				-- 100 MHz
			i_arst			: in 	std_logic;	
			i_duration		: in 	unsigned(31 downto 0);	-- Multiple of 10ns	
			i_hex_char		: in 	std_logic_vector(3 downto 0)	:= (others => '0');
			o_hex_chars		: out	hex_chars_t(7 downto 0) 			
		);
	end component;
	
	component seg7_controller is
		port ( 
			i_clk			: in	std_logic;
			i_arst			: in	std_logic;
			i_en			: in	std_logic					:= '1';
			i_hex_chars		: in 	hex_chars_t(7 downto 0)		:= (others => (others => '0'));
			o_seg7_cathode	: out 	std_logic_vector(7 downto 0);
			o_seg7_anaode	: out 	std_logic_vector(7 downto 0)
		);
	end component;
	
	signal seg7_hex_chars	: hex_chars_t(7 downto 0);
		
begin
	
	O_LED	<= I_SW;
	
	seg7_controller_inst: seg7_controller 
		port map ( 
			i_clk			=> I_CLK100MHZ,
			i_arst			=> I_BTNC,
			i_hex_chars		=> seg7_hex_chars,
			o_seg7_cathode	=> O_SEG7_CATH,
			o_seg7_anaode	=> O_SEG7_AN
		);

	char_controller_inst: char_controller 
		port map ( 
			i_clk100		=> I_CLK100MHZ,
			i_arst			=> I_BTNC,
			i_duration		=> x"05F5E100",
			i_hex_char		=> I_SW(3 downto 0),
			o_hex_chars		=> seg7_hex_chars 			
		);
	
end behavioral;
