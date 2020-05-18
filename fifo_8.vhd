LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;
	USE IEEE.std_logic_unsigned.ALL;
	USE IEEE.numeric_std.ALL;

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
	
--
--	COMPONENT memory IS 
--	GENERIC (
--		data_width :INTEGER := 8;
--		address_width :INTEGER := 3 );
--	PORT (
--		D_in  :IN std_logic_vector (data_width-1 downto 0);
----		ADDRA  :IN std_logic_vector (address_width-1 downto 0);
----		ADDRB  :IN std_logic_vector (address_width-1 downto 0);
--		ADDRA : IN INTEGER;
--		ADDRB : IN INTEGER;
--		REA  :IN std_logic;	--ReadEnable
--		WEA  :IN std_logic;	--WriteEnable
--		CLKA  :IN std_logic;
--		CLKB  :IN std_logic;
--		D_out : OUT std_logic_vector (data_width-1 downto 0)
--		 );
--	END COMPONENT;
--
--	COMPONENT fifo_controller IS 
--	GENERIC (
--		address_width :INTEGER := 3 );	
--	PORT(
--		reset :IN std_logic;
--		rdclk :IN std_logic;
--		wrclk :IN std_logic;
--		r_req :IN std_logic;
--		w_req :IN std_logic;
--		write_valid :OUT std_logic;
--		read_valid :OUT std_logic;
--		wr_ptr :OUT std_logic_vector (address_width-1 DOWNTO 0);
--		rd_ptr :OUT std_logic_vector (address_width-1 DOWNTO 0);
--		empty :OUT std_logic;
--		full :OUT std_logic );
--	END COMPONENT;	
--
	SIGNAL write_valid_ptr : std_logic;
	SIGNAL wr_ADDRA_ptr : std_logic_vector (2 DOWNTO 0);
	SIGNAL read_valid_ptr : std_logic;
	SIGNAL rd_ADDRB_ptr : std_logic_vector (2 DOWNTO 0);
	SIGNAL read_ptr_int : INTEGER;
	SIGNAL write_ptr_int : INTEGER;
	
BEGIN

fifoc : ENTITY work.fifo_controller PORT MAP ( 
		reset => reset,
		rdclk => rclk,
		wrclk => wclk,
		r_req => rreq,
		w_req => wreq,
		write_valid => write_valid_ptr,
		read_valid => read_valid_ptr,
		wr_ptr => wr_ADDRA_ptr,
		rd_ptr => rd_ADDRB_ptr,
		full => full,
		empty => empty  );

read_ptr_int <= to_integer(unsigned(rd_ADDRB_ptr));
write_ptr_int <= to_integer(unsigned(wr_ADDRA_ptr));
mem : ENTITY work.memory PORT MAP (	
		D_in => datain,
		ADDRA => wr_ADDRA_ptr,
		ADDRB => rd_ADDRB_ptr,
--		ADDRA => write_ptr_int,
--		ADDRB => read_ptr_int,
		REA => read_valid_ptr,
		WEA => write_valid_ptr,
		CLKA => rclk,
		CLKB => wclk,
		D_out => dataout );



END ARCHITECTURE;
