-- Contador Binario de 16 digitos (reset en 33000) --

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Definicion --
entity contadorbinario is
	port(
			
			clk : in std_logic;
			rst : in std_logic;

			q   : out std_logic_vector (15 downto 0);
			reset_bcd : out std_logic
		);
	end contadorbinario;

-- Arquitectura --
architecture contadorbinario_arq of contadorbinario is

		signal q_aux : std_logic_vector(15 downto 0);	
		signal E_aux : std_logic_vector(15 downto 0);
		signal D_aux  : std_logic_vector(15 downto 0);
		signal reset_aux : std_logic;
	begin
		
		E_aux(0) <= '1';
		
		bloque_ffd : for i in 0 to 14 generate --
		
			ffd_i : entity work.ffd port map (clk=>clk,rst=>reset_aux,ena=>'1',D=>D_aux(i),Q=>q_aux(i),set=>'0');	
			D_aux(i) <= q_aux(i) xor E_aux(i);
			E_aux(i+1) <= E_aux(i) and q_aux(i); 
		
		end generate bloque_ffd;
		ffd_15 : entity work.ffd port map (clk=>clk,rst=>reset_aux,ena=>'1',D=>D_aux(15),Q=>q_aux(15),set=>'0');
		D_aux(15) <= q_aux(15) xor E_aux(15);

		reset_aux <= (rst) or (q_aux(3) and q_aux(5) and q_aux(6) and q_aux(7) and q_aux(15) ) ; --    cuando llego a 33000 o reseteo, se resetea todo el ciclo
		q <= q_aux; -- Señal de salida del contador
		reset_bcd <= reset_aux; -- Flag a bcd para volver a 0 - preguntar si se puede enmascarar como q_aux and '1000000011101000 --
	end	;
		
--hay que ver las conexiones on el bcd y el registro
--el bcd cuenta voltaje y recibe señal para mandar info y recibe reset para volver a cero. 
--el registro recibe señal para recibir info. recibe info solo. 
