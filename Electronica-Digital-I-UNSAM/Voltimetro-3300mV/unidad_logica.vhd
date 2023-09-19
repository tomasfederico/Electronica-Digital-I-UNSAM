library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity unidad_logica is
	port(
		px: in std_logic_vector(9 downto 0);	--	pos horizontal del pixel en la pantalla
		py: in std_logic_vector(9 downto 0);	--	pos vertical del pixel en la pantalla
		sel: out std_logic_vector(2 downto 0); -- va al mux
		fil, col: out std_logic_vector(2 downto 0) -- esto es para cada caracter de 8x8. enmascara los ultimos 3 digitos de x e y
		);
end;

architecture unidad_logica_arq of unidad_logica is
	
	signal aux_sel: std_logic_vector(2 downto 0);

begin
		-- se realiza cableado con la logica de enmascarar todo menos ultimos 3 digitos del binario. segun el selector del mux. tanto para x como para y.
		-- arranca en 256 y 256. seria caracter n 32 y 32
		-- para todos y: 01 0000 0xxx
		aux_sel(2) <= px(8) and px(4) and (not px(9)) and (not px(7)) and (not px(6)) and (not px(5)) and (not px(4)) and py(8) and (not py(9)) and (not py(7)) and (not py(6)) and (not py(5)) and (not py(4)) and (not py(3));
		-- sel 2 = x:01 0001 xxxx 
		aux_sel(1) <= (  (px(8) and (not px(9)) and (not px(7)) and (not px(6)) and (not px(5)) and (not px(4)) and (not px(3))) or (px(8) and px(5) and (not px(9)) and (not px(7)) and (not px(6)) and (not px(4)) and (not px(3)) ) ) and (py(8) and (not py(9)) and (not py(7)) and (not py(6)) and (not py(5)) and (not py(4)) and (not py(3))  ); -- (xa or xb) and (y)  
		-- sel 1 = x:01 0000 0xxx or 01 0100 0xxx
		aux_sel(0) <= ( px(8) and (not px(9)) and (not px(7)) and (not px(6)) and (not px(5)) and (not px(4)) and (not px(3)) or px(8) and px(4) and px(3) and (not px(9)) and (not px(7)) and (not px(6)) and (not px(5))  ) and (py(8) and (not py(9)) and (not py(7)) and (not py(6)) and (not py(5)) and (not py(4)) and (not py(3))); -- (xa or xb) and (y)
		-- sel 0 = x: 01 0000 xxxx or 01 0001 1xxx
		sel <= aux_sel;
		
		fil <= py(2) and py(1) and py(0);
		col <= px(2) and px(1) and px(0);
		
		
end 