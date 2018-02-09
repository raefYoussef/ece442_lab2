----------------------------------------------------------------------------------
-- Company: JHU Masters
-- Engineer: Raef Youssef
-- 
-- Create Date: 02/08/2018 08:05:23 PM
-- Design Name: 
-- Module Name: seg7_encoder - behavioral
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

entity seg7_encoder is
	port ( 
		i_hex_char		: in	std_logic_vector(3 downto 0);	-- hex digit	
		o_seg7_char		: out	std_logic_vector(7 downto 0)	-- active low
	);
end seg7_encoder;

architecture behavioral of seg7_encoder is
begin

	-- Mapping: {DP, CG, CF, CE, CD, CC, CB, CA}

	with i_hex_char select 
	o_seg7_char <=
		"11000000" when x"0" ,
		"11111001" when x"1" ,
		"10100100" when x"2" ,
		"10110000" when x"3" ,
		"10011001" when x"4" ,
		"10010010" when x"5" ,
		"10000010" when x"6" ,
		"11111000" when x"7" ,
		"10000000" when x"8" ,
		"10010000" when x"9" ,
		"10001000" when x"A" ,
		"10000011" when x"B" ,
		"11000110" when x"C" ,
		"10100001" when x"D" ,
		"10000110" when x"E" ,
		"10001110" when others;

end behavioral;