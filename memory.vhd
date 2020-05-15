library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;

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
		CLKB  :IN std_logic
		 );
END ENTITY;

ARCHITECTURE syn OF memory IS
	CONSTANT ram_depth :INTEGER := 2**address_width;
	
	SIGNAL D_out :std_logic_vector (data_width-1 downto 0);

	TYPE ram IS ARRAY (INTEGER RANGE <>) OF std_logic_vector (data_width-1 DOWNTO 0);
	SIGNAL mem: ram (0 TO ram_depth-1);
BEGIN
	memory_write :
	PROCESS(CLKA,CLKB) BEGIN
		IF(rising_edge(CLKA)) THEN
			IF (WEA = '1') THEN
				mem(CONV_INTEGER(ADDRA)) <= D_in;
			END IF;
		END IF;
		
		IF(rising_edge(CLKB)) THEN
			IF (WEA = '1') THEN
				mem(CONV_INTEGER(ADDRB)) <= D_in;
			END IF;
		END IF;
	END PROCESS;
	 
	memory_readA :
	PROCESS (CLKA) BEGIN
		IF (rising_edge(CLKA)) THEN
			IF (WEA = '0' AND REA = '1') THEN
				D_out <= mem(CONV_INTEGER(ADDRA));
			ELSE
				D_out <= (OTHERS => '0');
			END IF;
		END IF;
	END PROCESS;

	memory_readB :
	PROCESS (CLKB) BEGIN
		IF (rising_edge(CLKB)) THEN
			IF (WEA = '0' AND REA = '1') THEN
				D_out <= mem(CONV_INTEGER(ADDRB));
			ELSE
				D_out <= (OTHERS => '0');
			END IF;
		END IF; 
	END PROCESS;	
END ARCHITECTURE;