
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY ROUTER IS
    PORT (
        datai1, datai2, datai3, datai4 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        wr1, wr2, wr3, wr4 : IN STD_LOGIC;
        datao1, datao2, datao3, datao4 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        wclock, rclock : IN STD_LOGIC;
        rst : IN STD_LOGIC
    );
END ENTITY ROUTER;

ARCHITECTURE Behavioral OF ROUTER IS
    TYPE bit_1Darray4 IS ARRAY (0 TO 3) OF std_logic;
    TYPE bit_2Darray IS ARRAY (0 TO 3, 0 TO 3) OF std_logic;
    TYPE vector_1Darray IS ARRAY (0 TO 3) OF std_logic_vector(7 DOWNTO 0);
    TYPE vector_2Darray IS ARRAY (0 TO 3, 0 TO 3) OF std_logic_vector(7 DOWNTO 0);


    SIGNAL DEMUX_out : vector_2Darray;
    SIGNAL ib_out : vector_1Darray;
    SIGNAL wr : bit_1Darray4;
    SIGNAL data_out : vector_2Darray;
    SIGNAL full : bit_2Darray;
    SIGNAL empty : bit_2Darray;
    Signal flag : bit_2Darray;
    Signal wreq : bit_2Darray;
    Signal rdreq : bit_2Darray;
BEGIN
    ib_1 : ENTITY work.ib PORT MAP (datai1, wclock, rst, wr1, ib_out(0));
    ib_2 : ENTITY work.ib PORT MAP (datai1, wclock, rst, wr2, ib_out(1));
    ib_3 : ENTITY work.ib PORT MAP (datai1, wclock, rst, wr3, ib_out(2));
    ib_4 : ENTITY work.ib PORT MAP (datai1, wclock, rst, wr4, ib_out(3));
    DeMux_1 : ENTITY work.DeMux PORT MAP (ib_out(0), DEMUX_out(0, 0), DEMUX_out(0, 1), DEMUX_out(0, 2), DEMUX_out(0, 3), ib_out(0)(1 DOWNTO 0), wr1);
    DeMux_2 : ENTITY work.DeMux PORT MAP (ib_out(1), DEMUX_out(1, 0), DEMUX_out(1, 1), DEMUX_out(1, 2), DEMUX_out(1, 3), ib_out(1)(1 DOWNTO 0), wr2);
    DeMux_3 : ENTITY work.DeMux PORT MAP (ib_out(2), DEMUX_out(2, 0), DEMUX_out(2, 1), DEMUX_out(2, 2), DEMUX_out(2, 3), ib_out(2)(1 DOWNTO 0), wr3);
    DeMux_4 : ENTITY work.DeMux PORT MAP (ib_out(3), DEMUX_out(3, 0), DEMUX_out(3, 1), DEMUX_out(3, 2), DEMUX_out(3, 3), ib_out(3)(1 DOWNTO 0), wr4);
    scheduler_1 : ENTITY work.rr_scheduler PORT MAP (rclock, data_out(0, 0), data_out(0, 1), data_out(0, 2), data_out(0, 3), datao1);
    scheduler_2 : ENTITY work.rr_scheduler PORT MAP (rclock, data_out(1, 0), data_out(1, 1), data_out(1, 2), data_out(1, 3), datao2);
    scheduler_3 : ENTITY work.rr_scheduler PORT MAP (rclock, data_out(2, 0), data_out(2, 1), data_out(2, 2), data_out(2, 3), datao3);
    scheduler_4 : ENTITY work.rr_scheduler PORT MAP (rclock, data_out(3, 0), data_out(3, 1), data_out(3, 2), data_out(3, 3), datao4);
    wr(0) <= wr1;
    wr(1) <= wr2;
    wr(2) <= wr3;
    wr(3) <= wr4;

    
 

    g_GENERATE_FOR : FOR i IN 0 TO 4 GENERATE
        z_GENERATE_FOR : FOR j IN 0 TO 4 GENERATE
            flag(i,j) <= '1' when (to_integer(signed(ib_out(i)(1 DOWNTO 0))) = i) else '0';
            rdreq(i,j) <= NOT empty(i, j);
            wreq(i,j) <= (NOT full(i,j)) AND wr(j) AND flag(i,j);
            fifo_8 : ENTITY work.fifo_8 PORT MAP (rst, rclock, wclock,rdreq(i,j) ,wreq(i,j) , DEMUX_out(j, i), data_out(i, j), empty(i, j), full(i, j));
        END GENERATE z_GENERATE_FOR;
    END GENERATE g_GENERATE_FOR;
END ARCHITECTURE;