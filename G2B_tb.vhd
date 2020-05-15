library ieee;
use ieee.std_logic_1164.all;
 
entity tb is
end tb;
 
architecture Behavioral of tb is 

component gbConverter is
port(   gray_in : in std_logic_vector(3 downto 0);
        bin_out : out std_logic_vector(3 downto 0)
        );
end component;

signal gin,bout : std_logic_vector(3 downto 0);
 
begin
  
   uut1: gbConverter port map (
          gray_in => gin,
          bin_out => bout
        );
          
   -- stimulus process
   stim_proc: process
   begin        
        gin <= "0000";    wait for 20 ns;
        gin <= "0001";  wait for 20 ns;
        gin <= "0010";  wait for 20 ns;
        gin <= "0011";  wait for 20 ns;
        gin <= "0100";    wait for 20 ns;
        gin <= "0101";  wait for 20 ns;
        gin <= "0110";  wait for 20 ns;
        gin <= "0111";  wait for 20 ns;
        gin <= "1000";    wait for 20 ns;
        gin <= "1001";  wait for 20 ns;
        gin <= "1010";  wait for 20 ns;
        gin <= "1011";  wait for 20 ns;
        gin <= "1100";    wait for 20 ns;
        gin <= "1101";  wait for 20 ns;
        gin <= "1110";  wait for 20 ns;
        gin <= "1111";  wait for 20 ns;     
      wait;
   end process;

end;