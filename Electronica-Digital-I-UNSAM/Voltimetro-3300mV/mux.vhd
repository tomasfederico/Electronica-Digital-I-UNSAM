library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity mux is 
port( 
digitos: in std_logic_vector (11 downto 0); -- 3 primeros digitos
caracteres: in std_logic_vector (11 downto 0); -- V(0a3) coma(4a7) y blank(8a11) - en orden  especial x el rom
-- digitosycaracteres in std_logic_vector (23 downto 0); -- SI NO SIRVE SEPARAR ENTRE DIGITOS Y CARACTERES habria q cambiar tmb BLOQUESALIDA.
sel: in std_logic_vector (2 downto 0);
salida_rom: out std_logic_vector(5 down to 0); -- La salida tendra la posicion que debe usar el rom -> caracter o numero (4 binarios) -- se usa 5 downto 0 xq el vga tiene 6 entradas. las ultimas dos son 0.
);
end;
architecture mux_arq of mux is
signal aux : std_logic_vector (5 down to 0)

begin
aux(0) <= (not sel(2))  and  (not sel(1)) and (not sel(0)); -- blanco 000
aux(1) <= (not sel(2))  and  (not sel(1)) and (sel(0)); -- coma 001
aux(2) <= (not sel(2))  and  sel(1)       and (not sel(0)); -- V 010
aux(3) <= (not sel(2))  and  sel(1)       and sel(0); -- unidad 011
aux(4) <= sel(2) and  (not sel(1)) and (not sel(0)); -- decimal 100
aux(5) <= sel(2) and  (not sel(1)) and sel(0); -- centesimal 101

bloquesalida: for i in 0 to 3 generate

salida_rom(i) <=( (aux(0) and caracteres(i))   or
 (aux(1) and caracteres(i+4)) or
 (aux(2) and caracteres(i+8)) or
 (aux(3) and digitos(i))      or
 (aux(4) and digitos(i+4))    or
   (aux(5) and digitos(i+8)) );

end generate;
salida_rom(4) <= '0';
salida_rom(5) <= '0';
end;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity mux is 
	port(	
			digitos: 	in std_logic_vector (11 downto 0); -- 3 primeros digitos
			caracteres: 	in std_logic_vector (11 downto 0); -- espacio(0a3) coma(4a7) y V(8a11)
			sel: 		in std_logic_vector (2 downto 0);
			
			salida_rom:	out std_logic_vector(5 down to 0); -- La salida tendra la posicion que debe usar el rom -> caracter o numero (4 binarios) -- se usa 5 downto 0 xq el vga tiene 6 entradas. las ultimas dos son 0.
		);
		
	end;
	
architecture mux_arq of mux is
	
	signal aux : std_logic_vector (6 down to 0)
	

begin
	aux(0) <= (not sel(2))  and  (not sel(1)) and (not sel(0)); -- blanco
	aux(1) <= (not sel(2))  and  (not sel(1)) and (sel(0)); -- coma
	aux(2) <= (not sel(2))  and  sel(1)       and (not sel(0)); -- V
	aux(3) <= (not sel(2))  and  sel(1)       and sel(0); -- unidad
	aux(4) <= sel(2)	and  (not sel(1)) and (not sel(0)); -- decimal
	aux(5) <= sel(2)	and  (not sel(1)) and sel(0); -- centesimal
	aux(6) <= sel(2)	and  sel(1)       and (not sel(0)); -- nose

	bloquesalida: for i in 0 to 3 generate

		salida_rom(i) <=( (aux(0) and caracteres(i))   or
				  (aux(1) and caracteres(i+4)) or
				  (aux(2) and caracteres(i+8)) or
				  (aux(3) and digitos(i))      or
				  (aux(4) and digitos(i+4))    or
 				  (aux(5) and digitos(i+8)) 	);

		end generate;
	salida_rom(4) <= '0';
	salida_rom(5) <= '0';
end;
