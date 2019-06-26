library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_ARITH.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

 

entity lcd_exm is

port ( clk    : in std_logic;                          --clock i/p

		 button : in  STD_LOGIC; 

       lcd_rw : out std_logic;                         --read & write control

       lcd_e : out std_logic;                         --enable control
		 
		 lcd_on : out std_logic;
		 
		 lcd_blon : out std_logic;

       lcd_rs : out std_logic;                         --data or command control

       data  : out std_logic_vector(7 downto 0));     --data line

end lcd_exm;


architecture Behavioral of lcd_exm is
constant N: integer :=21;
type arr is array (1 to N) of std_logic_vector(7 downto 0);

constant datas : arr := (X"38",X"0c",X"06",X"01",X"80",x"48",x"41",x"56",x"41",x"20",x"59",x"41",x"47",x"4d",x"55",x"52",x"4c",x"55",x"20",x"20",x"20"); --command and data to display

constant datas1 : arr := (X"38",X"0c",X"06",X"01",X"80",x"48",x"41",x"56",x"41",x"20",x"47",x"55",x"4e",x"45",x"53",x"4c",x"49",x"20",x"20",x"20",x"20"); --command and data to display


begin

lcd_rw <= '0';  --lcd write

lcd_on <= '1';

lcd_blon <= '1';

process(clk)

variable i : integer := 0;

variable j : integer := 1;

begin

 

if clk'event and clk = '1' then



if i <= 1000000 then

i := i + 1;

lcd_e <= '1';

	if (button='1') then
	data <= datas(j)(7 downto 0);

	elsif (button='0') then
	data <= datas1(j)(7 downto 0);
	end if;


elsif i > 1000000 and i < 2000000 then

i := i + 1;

lcd_e <= '0';

elsif i = 2000000 then

j := j + 1;

i := 0;

end if;

if j <= 5  then

lcd_rs <= '0';    --command signal

elsif j > 5   then

lcd_rs <= '1';   --data signal

end if;

if j = 22 then  --repeated display of data

j := 5;

end if;

end if;


 

end process;

end Behavioral;