
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY scheduler_tb IS
END ENTITY scheduler_tb;
ARCHITECTURE tb_arch OF scheduler_tb IS
    COMPONENT rr_scheduler IS
    PORT (
        clock : IN STD_LOGIC;
        din1, din2, din3, din4 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        dout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
    END COMPONENT rr_scheduler;
        SIGNAL clock : STD_LOGIC;
        SIGNAL din1, din2, din3, din4, dout : STD_LOGIC_VECTOR (7 DOWNTO 0);
BEGIN
    dut : rr_scheduler
    PORT MAP(clock, din1, din2, din3, din4, dout);
    clk : PROCESS IS
    BEGIN
        clock <= '0', '1' AFTER 40 ns;
        WAIT FOR 80 ns;
    END PROCESS clk;
    sg : PROCESS IS
    BEGIN
        din1 <= "00000001";
        din2 <= "00000010";
        din3 <= "00000011";
        din4 <= "00000100";
        WAIT;
    END PROCESS sg;
END ARCHITECTURE tb_arch;