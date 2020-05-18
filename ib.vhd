library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ib is
    Port ( data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clock_En : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end ib;

architecture input_Buffer_Arch of ib is

begin
    process(clock,reset)
        begin
            if reset = '1' then data_out <= "00000000";
            elsif clock'event and clock = '1' then
                if clock_En='1' then
                    data_out <= data_in;
                else
                    null;
            end if;
            end if;
        end process;

end input_Buffer_Arch;