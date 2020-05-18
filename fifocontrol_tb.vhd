
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY fifocontrol_tb IS
END ENTITY fifocontrol_tb;
ARCHITECTURE tb_arch OF fifocontrol_tb IS
    COMPONENT fifo_controller IS
    PORT (
        reset, rdclk, wrclk, r_req, w_req : IN STD_LOGIC;
        write_valid, read_valid, empty, full : OUT STD_LOGIC;
        wr_ptr, rd_ptr : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
    );
    END COMPONENT fifo_controller;
    SIGNAL reset, rdclk, wrclk, r_req, w_req : STD_LOGIC;
    SIGNAL write_valid, read_valid, empty, full : STD_LOGIC;
    SIGNAL wr_ptr, rd_ptr : STD_LOGIC_VECTOR (2 DOWNTO 0);
BEGIN
    dut : fifo_controller
    PORT MAP(
        reset, rdclk, wrclk, r_req, w_req,
        write_valid, read_valid, empty, full,
        wr_ptr, rd_ptr
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
    sg : PROCESS IS
    BEGIN
        reset <= '1';
        WAIT FOR 80 ns;
        reset <= '0';
        WAIT FOR 80 ns;
        r_req <= '1';
        WAIT FOR 80 ns;
        r_req <= '0';
        WAIT FOR 40 ns;
        w_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '0';
        WAIT FOR 40 ns;
        w_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '0';
        WAIT FOR 80 ns;
        w_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '0';
        WAIT FOR 80 ns;
        w_req <= '1';
        WAIT FOR 80 ns;
        w_req <= '0';
        WAIT FOR 80 ns;
        r_req <= '1';
        WAIT FOR 80 ns;
        r_req <= '0';

        WAIT;
    END PROCESS sg;
END ARCHITECTURE tb_arch;