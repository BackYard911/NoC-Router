LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fifo_controller IS
    PORT (
        reset, rdclk, wrclk, r_req, w_req : IN STD_LOGIC;
        write_valid, read_valid, empty, full : OUT STD_LOGIC;
        wr_ptr, rd_ptr : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
    );
END ENTITY fifo_controller;

ARCHITECTURE behav OF fifo_controller IS
    COMPONENT gray_counter IS
        PORT (
            count_out : OUT std_logic_vector (3 DOWNTO 0);
            En : IN std_logic;
            Clock : IN std_logic;
            Reset : IN std_logic
        );
    END COMPONENT;

    COMPONENT G2B IS
        PORT (
            gray_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            bin_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL rd_g2b : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL rd_binary_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL wr_g2b : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL wr_binary_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL rd_valid, wr_valid : STD_LOGIC;
BEGIN

    rd_gray_counter : gray_counter
    PORT MAP(
        Clock => rdclk,
        En => rd_valid,
        Reset => reset,
        count_out => rd_g2b
    );

    read_gray2binary : G2B
    PORT MAP(
        gray_in => rd_g2b,
        bin_out => rd_binary_out
    );

    wr_gray_counter : gray_counter
    PORT MAP(
        Clock => wrclk,
        En => wr_valid,
        Reset => reset,
        count_out => wr_g2b
    );

    write_gray2binary : G2B
    PORT MAP(
        gray_in => wr_g2b,
        bin_out => wr_binary_out
    );
    rst : PROCESS (reset)
    BEGIN
        IF (reset = '1') THEN
            empty <= '1';
            full <= '0';
            read_valid <= '0';
            write_valid <= '1';
            wr_ptr <= (OTHERS => '0');
            rd_ptr <= (OTHERS => '0');
        END IF;
    END PROCESS rst;

    ef : PROCESS (wr_binary_out, rd_binary_out, r_req, w_req)
        VARIABLE flag_1, flag_2 : BOOLEAN;
    BEGIN
        flag_1 := (to_integer(signed(rd_binary_out)) = to_integer(signed(wr_binary_out)) + 1);
        flag_2 := (wr_binary_out = "1111" AND rd_binary_out = "0000"); 
        IF (flag_1 OR flag_2) THEN
            full <= '1';
        ELSE
            full <= '0';
            IF (w_req = '1') THEN
                wr_valid <= '1';
            ELSE
                wr_valid <= '0';
            END IF;
        END IF;
        IF (wr_binary_out = rd_binary_out) THEN
            empty <= '1';
        ELSE
            empty <= '0';
            IF (r_req = '1') THEN
                rd_valid <= '1';
            ELSE
                rd_valid <= '0';
            END IF;
        END IF;
    END PROCESS ef;
    write_valid <= wr_valid;
    read_valid <= rd_valid;
END ARCHITECTURE behav;