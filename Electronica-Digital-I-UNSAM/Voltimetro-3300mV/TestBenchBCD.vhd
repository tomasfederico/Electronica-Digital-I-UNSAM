library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity contadorBCD_tb is

end;

architecture contadorBCD_tb_arq of contadorBCD_tb is
	signal clk: std_logic:= '0';
	signal ena: std_logic := '0';
	signal rst: std_logic :='1';
	signal BCD_OUT: std_logic_vector (19 downto 0);



begin
		rst <= '0' after 50 ns;
		clk <= not clk after 10 ns;
		ena <= '1' after 66150 ns, '0' after 66200 ns, '1' after 66250 ns, '0' after 66300 ns, '1' after 132400 ns, '0' after 132500 ns;

		bloque: entity work.ContadorBCD port map (ena,clk,rst,BCD_OUT);
		
end;