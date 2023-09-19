-- Contador BCD de 5 digitos --

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Definicion --

entity contadorBCD is
	port(
		clk, ena, rst: in std_logic;
		BCD_OUT: out std_logic_vector(19 downto 0) -- Salida como vector de 20 digitos (5 x 4 = 20 binarios)
	   );
end;

-- Arquitectura --

architecture contadorBCD_arq of contadorBCD is

	signal Q0, Q1, Q2, Q3, Q4 : std_logic_vector (3 downto 0); -- Cada Q es un digito del BCD (contiene 4 binarios) --
	signal flag_aux , ena_aux : std_logic_vector (4 downto 0); -- Un flag y un enable por cada digito --

begin 
		-- 5 Digitos -- 
		BCD0: entity work.digitoBCD port map( clk=>clk, rst=>rst, ena=>ena_aux(0), flag=>flag_aux(0), Q=>Q0);
		BCD1: entity work.digitoBCD port map( clk=>clk, rst=>rst, ena=>ena_aux(1), flag=>flag_aux(1), Q=>Q1);
		BCD2: entity work.digitoBCD port map( clk=>clk, rst=>rst, ena=>ena_aux(2), flag=>flag_aux(2), Q=>Q2);
		BCD3: entity work.digitoBCD port map( clk=>clk, rst=>rst, ena=>ena_aux(3), flag=>flag_aux(3), Q=>Q3);
		BCD4: entity work.digitoBCD port map( clk=>clk, rst=>rst, ena=>ena_aux(4), flag=>flag_aux(4), Q=>Q4);
		
		-- Conexiones entre BCD(i) --
		-- La idea aca es habilitar el conteo de el digito "n" a partir del flag de fin de cuenta en "n-1".
		ena_aux(0) <= '1'; -- nose si poner '1' o ena --
		ena_aux(1) <= (ena_aux(0) and flag_aux(0));
		ena_aux(2) <= (ena_aux(1) and flag_aux(1));
		ena_aux(3) <= (ena_aux(2) and flag_aux(2));
		ena_aux(4) <= (ena_aux(3) and flag_aux(3));
		
		
		-- Salida --
		
		BCD_OUT <= Q4 & Q3 & Q2 & Q1 & Q0; -- Union de todas las salidas en una sola --
		
end;

