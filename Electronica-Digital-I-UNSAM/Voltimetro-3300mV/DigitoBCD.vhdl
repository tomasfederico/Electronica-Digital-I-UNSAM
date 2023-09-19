-- Digito BCD --

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Definicion --

entity digitoBCD is
	port(
		clk,ena,rst	: in std_logic;
		flag 		: out std_logic;
		Q 		: out std_logic_vector(3 downto 0)
	);
end;

-- Arquitectura --

architecture digitoBCD_arq of digitoBCD is

	signal d_aux,q_aux : std_logic_vector(3 downto 0);

begin 
		-- FFD --
		ffd0 : entity work.ffd port map ( clk, rst, '0', ena, d_aux(0), q_aux(0));
		ffd1 : entity work.ffd port map ( clk, rst, '0', ena, d_aux(1), q_aux(1));
		ffd2 : entity work.ffd port map ( clk, rst, '0', ena, d_aux(2), q_aux(2));
		ffd3 : entity work.ffd port map ( clk, rst, '0', ena, d_aux(3), q_aux(3));
		
		-- Conexiones entre FFD --
		d_aux(0) <= (not q_aux(0));
		d_aux(1) <= ((not q_aux(3) and not q_aux(1) and q_aux(0)) or (q_aux(1) and not q_aux(0)));
		d_aux(2) <= ((q_aux(2) and (not q_aux(1))) or (q_aux(1) and q_aux(0) and (not q_aux(2))) or (q_aux(2) and (not q_aux(0))));
		d_aux(3) <= ((q_aux(3) and (not q_aux(0))) or (q_aux(0) and q_aux(1) and q_aux(2)));
		
		-- Salidas --
		Q <= q_aux; -- El numero BCD --
		
		flag <= (q_aux(0) and q_aux(3)); -- Este flag sirve para activar luego otro BCD --
		
end;

