LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb IS
END ENTITY;

ARCHITECTURE tb1 OF tb IS

SIGNAL data_in :  STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL clock :   STD_LOGIC;
SIGNAL reset :   STD_LOGIC;
SIGNAL clock_En :   STD_LOGIC;
SIGNAL data_out :  STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN
	dut: ENTITY work.ib 
	PORT MAP(
	   data_in ,
           clock ,
           reset,
           clock_En ,
           data_out );

PROCESS IS
	BEGIN 
		clock <= '0', '1' AFTER 40 ns;
		WAIT FOR 80 ns;
END PROCESS;

PROCESS IS
BEGIN
	data_in <= "01010101";
	clock_En <= '1';
	WAIT FOR 80 ns;
	data_in <= "10101011";
	clock_En <= '1';
	WAIT FOR 80 ns;
	data_in <= "11001100";
	clock_En <= '0';
	WAIT FOR 80 ns;
	data_in <= "11000110";
	clock_En <= '1';
	WAIT FOR 80 ns;
	data_in <= "00001000";
	clock_En <= '0';
	WAIT FOR 80 ns;
	data_in <= "11110111";
	clock_En <= '1';
	WAIT FOR 80 ns;


WAIT;
END PROCESS;
end architecture;