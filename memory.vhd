LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;
	USE IEEE.std_logic_unsigned.ALL;

ENTITY memory IS
	GENERIC (
		data_width :INTEGER := 8;
		address_width :INTEGER := 3 );
	PORT (
		D_in  :IN std_logic_vector (data_width-1 downto 0);
		ADDRA  :IN std_logic_vector (address_width-1 downto 0);
		ADDRB  :IN std_logic_vector (address_width-1 downto 0);
		REA  :IN std_logic;
		WEA  :IN std_logic;
		CLKA  :IN std_logic;
		CLKB  :IN std_logic;
		D_out : OUT std_logic_vector (data_width-1 downto 0)
		 );
END ENTITY;

ARCHITECTURE syn OF memory IS

	TYPE ram IS ARRAY (0 TO 7) OF std_logic_vector (data_width-1 DOWNTO 0);
	SIGNAL mem: ram ;
BEGIN

	PROCESS(CLKA) IS
	BEGIN
		IF(rising_edge(CLKA)) THEN
			IF (WEA = '1') THEN
				mem(conv_integer(ADDRA)) <= D_in;
			END IF;
		END IF;
	END PROCESS;

	PROCESS (CLKB) IS
	BEGIN
		IF (rising_edge(CLKB)) THEN
			IF (REA = '1') THEN
				D_out <= mem(conv_integer(ADDRB));
			ELSE
				D_out <= (others=>'Z');
			END IF;
		END IF; 
	END PROCESS;
	
END ARCHITECTURE;