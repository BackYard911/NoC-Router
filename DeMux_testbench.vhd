
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY DeMux_testbench IS
END DeMux_testbench;
 
ARCHITECTURE behavior OF DeMux_testbench IS 
 

 
    COMPONENT DeMux
    PORT(
         d_in : IN  STD_LOGIC_VECTOR(7 downto 0);
         d_out1 : OUT  STD_LOGIC_VECTOR(7 downto 0);
         d_out2 : OUT  STD_LOGIC_VECTOR(7 downto 0);
         d_out3 : OUT  STD_LOGIC_VECTOR(7 downto 0);
         d_out4 : OUT  STD_LOGIC_VECTOR(7 downto 0);
         Sel : IN  STD_LOGIC_VECTOR(1 downto 0);
         En : IN  STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal d_in :STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
   signal Sel : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
   signal En : STD_LOGIC := '0';

 	--Outputs
   signal d_out1 : STD_LOGIC_VECTOR(7 downto 0);
   signal d_out2 : STD_LOGIC_VECTOR(7 downto 0);
   signal d_out3 : STD_LOGIC_VECTOR(7 downto 0);
   signal d_out4 : STD_LOGIC_VECTOR(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DeMux PORT MAP (
          d_in => d_in,
          d_out1 => d_out1,
          d_out2 => d_out2,
          d_out3 => d_out3,
          d_out4 => d_out4,
          Sel => Sel,
          En => En
        );

   -- Clock process definition
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		En <='1'; 
		Sel <="00"; d_in <="00101011";
		wait for 100 ns;	
		En <='0'; 
		Sel <="00"; d_in <="00101011";
		wait for 100 ns;	
		En <='1'; 
		Sel <="00"; d_in <="00101011";
		wait for 100 ns;	
		En <='1'; 
		Sel <="01"; d_in <="00101011";
		wait for 100 ns;	
		En <='1'; 
		Sel <="01"; d_in <="00101011";
		wait for 100 ns;	
		En <='1'; 
		Sel <="10"; d_in <="00101011";
		wait for 100 ns;	
		En <='1'; 
		Sel <="10"; d_in <="00101011";
		wait for 100 ns;	
		En <='1'; 
		Sel <="11"; d_in <="00101011";
		wait for 100 ns;	
		En <='1'; 
		Sel <="11"; d_in <="00101011";
		wait for 100 ns;	
		En <='1'; 
		Sel <="11"; d_in <="00101011";



      -- insert stimulus here 

      wait;
   end process;

END;
