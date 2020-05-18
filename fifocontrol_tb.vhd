

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fifocontroller_tb IS
END fifocontroller_tb;

ARCHITECTURE behavior OF fifocontroller_tb IS
    SIGNAL reset : STD_LOGIC;
    SIGNAL rdclk : STD_LOGIC;
    SIGNAL wrclk : STD_LOGIC;
    SIGNAL r_req : STD_LOGIC;
    SIGNAL w_req : STD_LOGIC;
    SIGNAL write_valid : STD_LOGIC;
    SIGNAL read_valid : STD_LOGIC;
    SIGNAL wr_ptr : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL rd_ptr : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL empty : STD_LOGIC;
    SIGNAL full : STD_LOGIC;

BEGIN

    dut : ENTITY work.fifo_controller PORT MAP(
        reset => reset,
        rdclk => rdclk,
        wrclk => wrclk,
        r_req => r_req,
        w_req => w_req,
        write_valid => write_valid,
        read_valid => read_valid,
        wr_ptr => wr_ptr,
        rd_ptr => rd_ptr,
        empty => empty,
        full => full
        );

    read_clk : PROCESS IS
    BEGIN
	    rdclk <= '0', '1' AFTER 40 ns;
        WAIT FOR 80 ns;
    END PROCESS read_clk;
    write_clk : PROCESS IS
    BEGIN
	    wrclk <= '0', '1' AFTER 40 ns;
        WAIT FOR 80 ns;
    END PROCESS write_clk;

    stim_proc : PROCESS
    BEGIN
        reset <= '1';
        r_req <= '1';
        WAIT FOR 80 ns;
        ASSERT read_valid = '0' AND write_valid = '1' AND empty = '1' AND full ='0'
        REPORT "reset failed" SEVERITY ERROR;
        reset <= '0';
        WAIT FOR 80 ns;
        r_req <= '0';
        WAIT FOR 80 ns;
        w_req <= '1';
        WAIT FOR 40 ns;
        w_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '0';
        r_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '0';
        r_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '1';
        r_req <= '0';
        WAIT FOR 80 ns;
        w_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '1';
        WAIT FOR 80 ns;
        w_req <='0';
        r_req <= '1';
        WAIT FOR 80 ns;
        r_req <= '0';
        WAIT;
    END PROCESS;

END;