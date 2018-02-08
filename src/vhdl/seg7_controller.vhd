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
		i_oe			: in	std_logic					:= '1';
		i_hex_chars		: in 	hex_chars_t(7 downto 0)		:= (others => (others => '0'));
		o_lcd_cathode	: out 	std_logic_vector(7 downto 0);
		o_lcd_anaode	: out 	std_logic_vector(7 downto 0)
	);
end seg7_controller;

architecture behavioral of seg7_controller is

	component seg7_encoder
		port (
			i_hex_char		: in	std_logic_vector(3 downto 0);	-- hex digit	
			o_seg7_char		: out	std_logic_vector(7 downto 0)	-- active low
		);
	end component;

	signal curr_index	: unsigned(2 downto 0);
	signal next_index	: unsigned(2 downto 0);
	signal mux_hex_char	: std_logic_vector(3 downto 0);

begin

	-- regs
	process (i_clk, i_arst) begin
		if i_arst = '1' then
			curr_index	<= (others => '0');
		elsif rising_edge(i_clk) then
			curr_index	<= next_index;
		end if;
	end process;

	-- comb
	process (curr_index) begin
		
		mux_hex_char	<= i_hex_chars(to_integer(curr_index));

		-- index switching
		if i_en	= '1' then			
			next_index	<= curr_index + 1;
		else	
			next_index	<= curr_index;
		end if;
		
		-- anodes
		if i_oe = '1' then 
			-- anode decoder (active low)
			case(curr_index) is
				when "000"	=> o_lcd_anaode	<= "1111_1110";  
				when "001"	=> o_lcd_anaode	<= "1111_1101";
				when "010"	=> o_lcd_anaode	<= "1111_1011";
				when "011"	=> o_lcd_anaode	<= "1111_0111";
				when "100"	=> o_lcd_anaode	<= "1110_1111";
				when "101"	=> o_lcd_anaode	<= "1101_1111";
				when "110"	=> o_lcd_anaode	<= "1011_1111";
				when "111"	=> o_lcd_anaode	<= "0111_1111";
			end case;
		else
			-- turn off displays
			o_lcd_anaode	<= "1111_1111";
		end if;
	end process;
	
	-- decoder
	seg7_encoder: seg7_encoder_inst 
		port map (
			i_hex_char		<= mux_hex_char,	
			o_seg7_char		<= o_lcd_cathode
		);

end behavioral;
