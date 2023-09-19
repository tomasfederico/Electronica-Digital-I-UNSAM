-- Contador BCD de N digitos --

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Definicion --

entity contadorBCD is
	port(
		generic(N:=5)
		clk, ena, rst: in std_logic;
		type matriz is array (N-1 downto 0)(3 downto 0) of std_logic;
		BCD_OUT: out matriz;  -- Salida como matriz de Nx4 digitos (N x 4 binarios)
	   );
end;

-- Arquitectura --

architecture contadorBCD_arq of contadorBCD is

	signal Q : matriz; -- Matriz depende de la cantidad de digitos BCD
	signal flag_aux , ena_aux : std_logic_vector (N-1 downto 0); -- Un flag y un enable por cada digito BCD --

begin 
		-- N Digitos --
		bloque_BCDk : for k in 0 to N generate
		
			BCDk: entity work.digitoBCD port map( clk=>clk, rst=>rst, ena=>ena_aux(k), flag=>flag_aux(k), Q=>Q(k,:));-- aca nose si lamatriz Q esta bien expresada 
			-- Conexiones entre BCD(i) --
			-- La idea aca es habilitar el conteo de el digito "n" a partir del flag de fin de cuenta en "n-1".
			ena_aux(0) <= '1'; -- nose si poner '1' o ena --
			ena_aux(k+1) <= ena_aux(k) & flag_aux(k);
			
		end generate bloque_BCDk;
		
		-- Salida --
		
		BCD_OUT <= Q; -- Union de todas las salidas en una sola --
		
end;

