 entity DeMux is
    Port ( d_in : in  bit_VECTOR (7 downto 0);
           d_out1 : OUT  bit_VECTOR (7 downto 0);
           d_out2 : OUT bit_VECTOR (7 downto 0);
           d_out3 : OUT bit_VECTOR (7 downto 0);
           d_out4 : OUT bit_VECTOR (7 downto 0);
           Sel : in  bit_VECTOR (1 downto 0);
           En : in  bit);
end DeMux;

architecture DeMuxArch of DeMux is

begin
    process(d_in,Sel,En)
    begin
        if En ='1' then
            case Sel is
                when "00" =>
                    d_out1 <= d_in;
                    d_out2 <= "00000000";
                    d_out3 <= "00000000";
                    d_out4 <= "00000000";
                when "01" =>
                     d_out2 <= d_in;
                    d_out1 <= "00000000";
                    d_out3 <= "00000000";
                    d_out4 <= "00000000";
                when "10" =>
                     d_out3 <= d_in;
                    d_out1 <= "00000000";
                    d_out2 <= "00000000";
                    d_out4 <= "00000000";
                when "11" =>
                    d_out4 <= d_in;
                    d_out1 <= "00000000";
                    d_out2 <= "00000000";
                    d_out3 <= "00000000";
                when others => null;
                end case;
            else null;
        end if;
        end process;
  end DeMuxArch;