LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY sigma_delta IS
    PORT(
        clk     : IN STD_LOGIC;
        PWM_in  : IN STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
        PWM_out : OUT STD_LOGIC
    );
END sigma_delta;

ARCHITECTURE sigma_delta_arch OF sigma_delta IS
    SIGNAL PWM_accumulator : STD_LOGIC_VECTOR (8 DOWNTO 0) := "000000000";
BEGIN
    PROCESS(clk, PWM_in)
    BEGIN
        IF rising_edge(clk) THEN
            PWM_accumulator <= STD_LOGIC_VECTOR(UNSIGNED("0" & PWM_accumulator(7 DOWNTO 0)) + UNSIGNED("0" & PWM_in));
        END IF;
    END PROCESS;

    PWM_out <= PWM_accumulator(8);
END ARCHITECTURE sigma_delta_arch;