LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;
	USE IEEE>std_logic_unsigned.ALL;

ENTITY fifo_8 IS
	GENERIC (
		data_width :INTEGER := 8
--		address_width : INTEGER := 3;
		);
PORT (
	reset : IN std_logic;
	rclk : IN std_logic;	--readClock
	wclk : IN std_logic;	--writeClock
	rreq : IN std_logic;
	wreq : IN std_logic;
	datain : IN std_logic_vector (data_width-1 DOWNTO 0);
	dataout : OUT std_logic_vector (data_width-1 DOWNTO 0);
	empty : OUT std_logic;
	full : OUT std_logic );
END ENTITY;

ARCHITECTURE Behavioral OF fifo_8 IS
	

	COMPONENT memory IS 
	GENERIC (
		data_width :INTEGER := 8;
		address_width :INTEGER := 3 );
	PORT (
		D_in  :IN std_logic_vector (data_width-1 downto 0);
		ADDRA  :IN std_logic_vector (address_width-1 downto 0);
		ADDRB  :IN std_logic_vector (address_width-1 downto 0);
		REA  :IN std_logic;	--ReadEnable
		WEA  :IN std_logic;	--WriteEnable
		CLKA  :IN std_logic;
		CLKB  :IN std_logic;
		D_out : OUT std_logic_vector (data_width-1 downto 0)
		 );
	END COMPONENT;

 	COMPONENT Gray_counter IS
	PORT(
		count_out: out std_logic_vector (3 downto 0); 
		En: in std_logic;
		Clock: in std_logic;
		Reset: in std_logic
	      );
	END COMPONENT;

	COMPONENT gbConverter IS
	PORT (
            gray_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            bin_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
      	);
	END COMPONENT;

	SIGNAL D_in  :IN std_logic_vector (7 downto 0);
	SIGNAL	ADDRA  :IN std_logic_vector (2 downto 0);
	SIGNAL	ADDRB  :IN std_logic_vector (2 downto 0);
	SIGNAL	REA  :IN std_logic;	--ReadEnable
	SIGNAL	WEA  :IN std_logic;	--WriteEnable
	SIGNAL	CLKA  :IN std_logic;
	SIGNAL	CLKB  :IN std_logic;
	SIGNAL	D_out : OUT std_logic_vector (7 downto 0);
	SIGNAL	count_out: out std_logic_vector (3 downto 0); 
	SIGNAL	En: in std_logic;
	SIGNAL	Clock: in std_logic;
	SIGNAL	Reset: in std_logic;
        SIGNAL 	gray_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL  bin_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN





END ARCHITECTURE;
