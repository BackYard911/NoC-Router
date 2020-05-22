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
		rst <= '1';
		WAIT FOR 40 ns;
		rst <= '0';
		wr1 <= '1';
		datai1 <= "01000000";
		WAIT FOR 80 ns;
--		wr3 <= '0';
--		rst <= '1';
		datai2 <= "10000001";
		wr2 <= '1';
		WAIT FOR 580 ns;
--		wr1 <= '0';
		rst <= '1';
		wr1 <= '1';
		WAIT FOR 320 ns;
		rst <= '0';
		datai3 <= "00100010";
		wr3 <= '1';
		WAIT FOR 80 ns;
--		wr2 <= '0';
		datai4 <= "00010011";
		wr4 <= '1';

--		WAIT FOR 320 ns;
--		wr4 <= '0';


		WAIT;
	END PROCESS;	





END ARCHITECTURE;