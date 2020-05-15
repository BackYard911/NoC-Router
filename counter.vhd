library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
entity Gray_counter is 
	port (
		count_out: out std_logic_vector (3 downto 0); 
		En: in std_logic;
		Clock: in std_logic;
		Reset: in std_logic
	      );
end entity;

architecture rt1 of Gray_counter is 
	signal count: std_logic_vector (3 downto 0);
begin 
	process (Clock, Reset) begin
		if (Reset = '1') then 
			count <= (others=>'0');
		elsif (rising_edge(Clock)) then 
			if ( En = '1') then 
				count <= count + 1;
			end if;
		end if;
	end process;
	Count_out  <= ( count (3) &
			( count (3) xor count (2) ) &
			( count (2) xor count (1) ) &
			( count (1) xor count (0) ) );
end architecture;

