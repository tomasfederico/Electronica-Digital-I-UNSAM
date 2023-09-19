library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity contadorbinario_tb is
	generic (N:integer:=15);
end;

architecture contadorbinario_tb_arq of contadorbinario_tb is
	signal clk: std_logic:= '0';
	signal rst: std_logic :='1';
	signal q: std_logic_vector (N downto 0); --cuando es un vector asi no se como declararlo en el test bench. No se si funcionara de esta forma
	signal reset_bcd: std_logic;


begin
		rst <= '0' after 50 ns;
		clk <= not clk after 1 ns;
	
		bloque: entity work.ContadorBINARIO port map (clk,rst,q,reset_bcd);
		
end;
