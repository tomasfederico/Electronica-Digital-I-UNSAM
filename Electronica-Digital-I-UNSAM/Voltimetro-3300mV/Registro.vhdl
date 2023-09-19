-- Registro de Salida --

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Definicion --

entity registro is
	port(
			clk,rst : in std_logic;
			D : in std_logic_vector (15 downto 0);
			Q : out std_logic_vector (15 downto 0);
		);
end;

-- Arquitectura --

architecture registro_arq of registro is	

	signal q_aux, d_aux : std_logic_vector(15 downto 0);
	
	begin
			bloque_registro : for i in 0 to 15 generate
			
				ffd_i : entity work.ffd port map (clk,rst,'0',ena,d_aux(i),q_aux(i));
				
			end generate bloque_registro;
			
			d_aux <= D;
			Q <= q_aux;
			
end;