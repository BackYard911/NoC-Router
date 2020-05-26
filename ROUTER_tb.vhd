LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ROUTER_tb IS
END ENTITY;

ARCHITECTURE routerTB OF ROUTER_tb IS

	SIGNAL datai1 : std_logic_vector(7 DOWNTO 0);
	SIGNAL datai2 : std_logic_vector(7 DOWNTO 0);
	SIGNAL datai3 : std_logic_vector(7 DOWNTO 0);
	SIGNAL datai4 : std_logic_vector(7 DOWNTO 0);
	SIGNAL wr1 : std_logic;
	SIGNAL wr2 : std_logic;
	SIGNAL wr3 : std_logic;
	SIGNAL wr4 : std_logic;
	SIGNAL datao1 : std_logic_vector(7 DOWNTO 0);
	SIGNAL datao2 : std_logic_vector(7 DOWNTO 0);
	SIGNAL datao3 : std_logic_vector(7 DOWNTO 0);
	SIGNAL datao4 : std_logic_vector(7 DOWNTO 0);
	SIGNAL wclock : std_logic;
	SIGNAL rclock : std_logic;
	SIGNAL rst : std_logic;

BEGIN 
	dut: ENTITY work.ROUTER 
	PORT MAP(datai1, datai2, datai3, datai4,
		wr1, wr2, wr3, wr4, 
		datao1, datao2, datao3, datao4,
		wclock, rclock, rst );

	read_clk : PROCESS IS
	BEGIN 
		rclock <= '0', '1' AFTER 40 ns;
		WAIT FOR 80 ns;
	END PROCESS;
	write_clk : PROCESS IS
	BEGIN
		wclock <= '0', '1' AFTER 40 ns;
		WAIT FOR 80 ns;
	END PROCESS;

	sg: PROCESS IS
	BEGIN

		rst <= '1';			--initial reset for the router 
		
		
		WAIT FOR 80 ns;
		--sending packets to from all sources to port 1 by having "00" as the last two bits (sel)
		datai1 <= "01101000";
		datai2 <= "01011000";
		datai3 <= "01111000";
		datai4 <= "01101100";
		rst <= '0';			
		--allowing the requests to enter the router
		wr1 <= '1';
		wr2 <= '1';
		wr3 <= '1';
		wr4 <= '1';
		WAIT FOR 80 ns;
		--sending packets to from all sources to port 2 by having "01" as the last two bits (sel)
		datai1 <= "11101101";
		datai2 <= "01000001";
		datai3 <= "11111001";
		datai4 <= "01001101";
		WAIT FOR 80 ns;
		--sending packets to from all sources to port 3 by having "10" as the last two bits (sel)
		datai1 <= "01011110";
		datai2 <= "01111010";
		datai3 <= "11111010";
		datai4 <= "01001110";
		WAIT FOR 80 ns;
		--sending packets to from all sources to port 4 by having "11" as the last two bits (sel)
		datai1 <= "00001111";
		datai2 <= "01111011";
		datai3 <= "01100011";
		datai4 <= "10101111";
		WAIT FOR 80 ns;
		--the router wont accept any new packets
		wr1 <= '0';
		wr2 <= '0';
		wr3 <= '0';
		wr4 <= '0';

--		ASSERT datao2 = datai2 REPORT "data entring port 2 is not the same as data coming out of output port 2";
--		WAIT FOR 160 ns;
--		ASSERT datao4 = datai4 REPORT "data entring port 4 is not the same as data coming out of output port 4";
--		WAIT FOR 100 ns;
--		ASSERT datao1 = datai1 REPORT "data entring port 1 is not the same as data coming out of output port 1";
--		WAIT FOR 120 ns;
--		ASSERT datao3 = datai3 REPORT "data entring port 3 is not the same as data coming out of output port 3";
		WAIT;
	END PROCESS;	





END ARCHITECTURE;