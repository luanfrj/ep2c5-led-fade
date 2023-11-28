LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY fade IS
	PORT (
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		led : OUT STD_LOGIC
	);
END ENTITY fade;

ARCHITECTURE a OF fade IS
	SIGNAL PWM_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL cont: INTEGER range 1 to 190000 := 1;
BEGIN
u0: ENTITY work.sigma_delta
		PORT MAP (
			clk => clk,
			PWM_in => PWM_in,
			PWM_out => led
		);

	PROCESS(clk, rst)
	BEGIN
		IF rst = '0' THEN
			PWM_in <= "00000000";
		ELSIF RISING_EDGE(clk) THEN
			IF cont = 190000 THEN
				cont <= 1;
				PWM_in <= STD_LOGIC_VECTOR(UNSIGNED(PWM_in) + 1);
			ELSE
				cont <= cont + 1;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE a;
