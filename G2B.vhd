
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gbConverter is
Port(
      gray_in: in STD_LOGIC_VECTOR(3 downto 0);
      bin_out: out STD_LOGIC_VECTOR(3 downto 0)
      );
end gbConverter;

architecture Behavioral of gbConverter is
begin
 bin_out(3)<=gray_in(3);
 bin_out(2)<=gray_in(3) xor gray_in(2);
 bin_out(1)<=gray_in(3) xor gray_in(2) xor gray_in(1);
 bin_out(0)<=gray_in(3) xor gray_in(2) xor gray_in(1) xor gray_in(0);
end behavioral;
