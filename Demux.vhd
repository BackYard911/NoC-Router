LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY DeMux IS
    PORT ( d_in : in  STD_LOGIC_VECTOR (7 DOWNTO 0);
           d_out1 : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0);
           d_out2 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
           d_out3 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
           d_out4 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
           Sel : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
           En : IN  STD_LOGIC);
END DeMux;

ARCHITECTURE DeMuxArch OF DeMux IS

BEGIN
    PROCESS(d_in,Sel,En)
    BEGIN
        IF En ='1' THEN
            CASE Sel IS
                WHEN "00" =>
                    d_out1 <= d_in;
                    d_out2 <= "00000000";
                    d_out3 <= "00000000";
                    d_out4 <= "00000000";
                WHEN "01" =>
                     d_out2 <= d_in;
                    d_out1 <= "00000000";
                    d_out3 <= "00000000";
                    d_out4 <= "00000000";
                WHEN "10" =>
                     d_out3 <= d_in;
                    d_out1 <= "00000000";
                    d_out2 <= "00000000";
                    d_out4 <= "00000000";
                WHEN "11" =>
                    d_out4 <= d_in;
                    d_out1 <= "00000000";
                    d_out2 <= "00000000";
                    d_out3 <= "00000000";
                WHEN others => null;
                END CASE;
            ELSE null;
        END IF;
        END PROCESS;
  END DeMuxArch;