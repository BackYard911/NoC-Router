LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY rr_scheduler IS
    PORT (
        clock : IN STD_LOGIC;
        din1, din2, din3, din4 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        dout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );

END ENTITY rr_scheduler;

ARCHITECTURE behav OF rr_scheduler IS
    TYPE state_type IS (idle, port1, port2, port3, port4);
    SIGNAL current_state, next_state : state_type;
BEGIN
    cs : PROCESS (clock)
    BEGIN
        IF rising_edge(clock) THEN
            current_state <= next_state;
        END IF;
    END PROCESS cs;
    ns : PROCESS (current_state)
    BEGIN
        CASE current_state IS
            WHEN port1 =>
                dout <= din1;
                next_state <= port2;
            WHEN port2 =>
                dout <= din2;
                next_state <= port3;
            WHEN port3 =>
                dout <= din3;
                next_state <= port4;
            WHEN port4 =>
                dout <= din4;
                next_state <= port1;
            WHEN OTHERS =>
                next_state <= port1; 
        END CASE;
    END PROCESS ns;
END ARCHITECTURE behav;             