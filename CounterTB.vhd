LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Testbench IS
END Testbench;

ARCHITECTURE TBarch OF Testbench IS
  COMPONENT Gray_counter IS
    PORT (Clock, Reset, En: IN std_logic;
          count_out: OUT std_logic_vector (3 DOWNTO 0));
  END COMPONENT;

  SIGNAL Clock_s, Reset_s, En_s: std_logic;
  SIGNAL output_s: std_logic_vector(3 DOWNTO 0);

BEGIN
  CompToTest: Gray_counter GENERIC MAP (4) PORT MAP (Clock_s, Reset_s, En_s, output_s);
   
  Clock_proc: PROCESS
  BEGIN
    Clock_s <= '1';
    WAIT FOR 10 ns;
    Clock_s <= '0';
    WAIT FOR 10 ns;
  END PROCESS clock_proc;
                      
  Vector_proc: PROCESS
  BEGIN
    Reset_s <= '1';
    WAIT UNTIL Clock_s='1' AND Clock_s'EVENT;
    WAIT FOR 3 NS;
    Reset_s <= '0';
    En_s <= '1';
    FOR index IN 0 To 3 LOOP
      WAIT UNTIL Clock_s='1' AND Clock_s'EVENT;
    END LOOP;
    WAIT FOR 3 NS;
    WAIT;
  END PROCESS Vector_proc;

END TBarch;