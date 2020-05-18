LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY fifo_8_tb IS
END ENTITY;

ARCHITECTURE fifo_tb OF fifo_8_tb IS

--	COMPONENT fifo_8 IS
--		PORT(
--			reset : IN std_logic;
--			rclk : IN std_logic;
--			wclk : IN std_logic;	
--			rreq : IN std_logic;
--			wreq : IN std_logic;
--			datain : IN std_logic_vector (7 DOWNTO 0);
--			dataout : OUT std_logic_vector (7 DOWNTO 0);
--			empty : OUT std_logic;
--			full : OUT std_logic );
--	
--	END COMPONENT;

	SIGNAL 	reset :  std_logic;
	SIGNAL	rclk : std_logic;
	SIGNAL	wclk : std_logic;	
	SIGNAL	rreq : std_logic;
	SIGNAL	wreq : std_logic;
	SIGNAL	datain : std_logic_vector (7 DOWNTO 0);
	SIGNAL	dataout : std_logic_vector (7 DOWNTO 0);
	SIGNAL	empty : std_logic;
	SIGNAL full : std_logic;
	
BEGIN 
	dut: ENTITY work.fifo_8 
	PORT MAP (
		reset, rclk, wclk, rreq, wreq,
		datain, dataout, empty, full );
	
	read_clk : PROCESS IS
	BEGIN 
		rclk <= '0', '1' AFTER 40 ns;
		WAIT FOR 80 ns;
	END PROCESS;
	write_clk : PROCESS IS
	BEGIN
		wclk <= '0', '1' AFTER 40 ns;
		WAIT FOR 80 ns;
	END PROCESS;

	sg : PROCESS IS
	BEGIN
		reset <= '1';
		WAIT FOR 80 ns;
		reset <= '0';
		WAIT FOR 80 ns;
		rreq <= '1';
        	WAIT FOR 80 ns;
	        rreq <= '0';
	        WAIT FOR 80 ns;
	        wreq <= '1';
		datain <= "01001101";
		WAIT FOR 80 ns;
		rreq <= '1';
		ASSERT dataout = "01001001";
--		datain <= X"A5";
	        WAIT FOR 80 ns;
	        wreq <= '0';
--		datain <= X"A2";
	        WAIT FOR 80 ns;
	        wreq <= '1';
		datain <= "01001001";
	        WAIT FOR 80 ns;
	        wreq <= '0';
--		datain <= X"A1";
	        WAIT FOR 80 ns;
	        wreq <= '1';
		datain <= "01001011";
--		datain <= X"A6";
	        WAIT FOR 80 ns;
	        wreq <= '0';
	        WAIT FOR 80 ns;
	        wreq <= '1';
		datain <= "01101001";
		rreq <= '1';
		ASSERT dataout = "01001001";
--		datain <= X"A7";
	        WAIT FOR 80 ns;
	        wreq <= '0';
	        WAIT FOR 80 ns;
	        rreq <= '1';
		ASSERT dataout = "01001001";
	        WAIT FOR 80 ns;
	        rreq <= '0';
		
		WAIT;
	END PROCESS;
END ARCHITECTURE;