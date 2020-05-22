LIBRARY ieee;
	USE ieee.std_logic_1164.all;
	USE ieee.std_logic_unsigned.all;
ENTITY Gray_counter IS 
	PORT (
		count_out: OUT std_logic_vector (3 DOWNTO 0); 
		En: IN std_logic;
		Clock: IN std_logic;
		Reset: IN std_logic
	      );
END ENTITY;

ARCHITECTURE rt1 OF Gray_counter IS 
	SIGNAL count: std_logic_vector (3 DOWNTO 0);
BEGIN 
	PROCESS (Clock, Reset) BEGIN
		IF (Reset = '1') THEN 
			count <= (others=>'0');
		ELSIF (rising_edge(Clock)) THEN 
			IF ( En = '1') THEN 
				count <= count + 1;
			END IF;
		END IF;
	END PROCESS;
	Count_out  <= ( count (3) &
			( count (3) XOR count (2) ) &
			( count (2) XOR count (1) ) &
			( count (1) XOR count (0) ) );
END ARCHITECTURE;

