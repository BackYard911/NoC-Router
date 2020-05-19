LIBRARY IEEE;
	USE IEEE.std_logic_1164.ALL;

ENTITY fifo_8 IS
	GENERIC (
		data_width :INTEGER := 8
		);
PORT (
	reset : IN std_logic;
	rclk : IN std_logic;
	wclk : IN std_logic;
	rreq : IN std_logic;
	wreq : IN std_logic;
	datain : IN std_logic_vector (data_width-1 DOWNTO 0);
	dataout : OUT std_logic_vector (data_width-1 DOWNTO 0);
	empty : OUT std_logic;
	full : OUT std_logic );
END ENTITY;

ARCHITECTURE Behavioral OF fifo_8 IS
	
	SIGNAL write_valid_ptr : std_logic;
	SIGNAL wr_ADDRA_ptr : std_logic_vector (2 DOWNTO 0);
	SIGNAL read_valid_ptr : std_logic;
	SIGNAL rd_ADDRB_ptr : std_logic_vector (2 DOWNTO 0);
	
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

mem : ENTITY work.memory PORT MAP (	
		D_in => datain,
		ADDRA => wr_ADDRA_ptr,
		ADDRB => rd_ADDRB_ptr,
		REA => read_valid_ptr,
		WEA => write_valid_ptr,
		CLKA => rclk,
		CLKB => wclk,
		D_out => dataout );



END ARCHITECTURE;
