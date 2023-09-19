-- Flip-flop D de 1 bit

library IEEE;
use IEEE.std_logic_1164.all;

-- Definicion --
entity ffd is
	port(
		clk: in std_logic;
		rst: in std_logic;
		set: in std_logic;
		ena: in std_logic;
		D: in std_logic;
		Q: out std_logic;
		NQ: out std_logic
	);
end;

-- Arquitectura --
architecture ffd_arq of ffd is
	
	signal qaux: std_logic; 
	
begin
	process( clk, rst, set)
	begin
		if rst = '1' then
			qaux <= '0';
		elsif set = '1' then
			qaux <= '1';
		elsif rising_edge(clk) then
			if ena = '1' then
				qaux <= D;
			end if;
		end if;
	end process;
	Q <= qaux;
	NQ <= not qaux;
end;