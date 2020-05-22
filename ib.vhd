LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;



ENTITY ib IS
    PORT ( data_in : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
           clock : IN  STD_LOGIC;
           reset : IN  STD_LOGIC;
           clock_En : IN  STD_LOGIC;
           data_out : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
END ib;

ARCHITECTURE input_Buffer_Arch OF ib IS

BEGIN
    PROCESS(clock,reset)
        BEGIN
	IF rising_edge(clock) THEN
            IF reset = '1' THEN data_out <= "00000000";
	    
    	    ELSIF clock_En='1' THEN
                    data_out <= data_in;
            END IF;
            
            
            END IF;
        END PROCESS;

END input_Buffer_Arch;