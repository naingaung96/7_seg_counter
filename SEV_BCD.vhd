library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FOU_BIT_BCD is
port (
  i_clk                       : in  std_logic;
  i_sync_reset                : in  std_logic;
  i_count_ena                 : in  std_logic;
  --O_bcd                       : out std_logic_vector(3 downto 0);
  SEV_BCD							:OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
end FOU_BIT_BCD;

architecture rtl of FOU_BIT_BCD is
constant counter:integer:=6000000;


begin

--o_bcd  <= std_logic_vector(r_count);
p_count : process(i_clk,i_sync_reset)
variable r_count:unsigned(22 downto 0);
variable internal_bcd:unsigned(3 downto 0); 

begin

  if(I_CLK'EVENT AND I_CLK='1') then
		if(i_sync_reset='1') then
			r_count:= (others=> '0');
			internal_bcd:=(others=>'0');
      elsif(i_count_ena='1') then
       if(r_count =counter) then
        r_count:= (others=> '0');
		  internal_bcd:=internal_bcd+1;
       else
        r_count:= r_count + 1;
       end if;
      end if;
  end if;
  CASE internal_bcd IS
   WHEN "0000"=> SEV_BCD<="0000001";
	WHEN "0001"=> SEV_BCD<="1001111";
	WHEN "0010"=> SEV_BCD<="0010010";
	WHEN "0011"=> SEV_BCD<="0000110";
	WHEN "0100"=> SEV_BCD<="1001100";
	WHEN "0101"=> SEV_BCD<="0100100";
	WHEN "0110"=> SEV_BCD<="0100000";
	WHEN "0111"=> SEV_BCD<="0001111";
	WHEN "1000"=> SEV_BCD<="0000000";
	WHEN "1001"=> SEV_BCD<="0000100";
	when "1010"=> SEV_BCD<="0000010"; -- a
   When "1011"=> SEV_BCD<="1100000"; -- b
   when "1100"=> SEV_BCD<="0110001"; -- C
   When "1101"=> SEV_BCD<="1000010"; -- d
   When "1110"=> SEV_BCD<="0110000"; -- E
   when "1111"=> SEV_BCD<="0111000"; -- F
	WHEN OTHERS=> NULL;
  END CASE;
  
end process;

--WITH R_COUNT SELECT 
		--SEV_BCD<= "1111110" WHEN "0000",
				--"0110000" WHEN	"0001",
				---"1101101" WHEN "0010",
				--"1111001" WHEN "0011",
				--"0110011" WHEN "0100",
				--"1011011" WHEN "0101",
				--"1011111" WHEN "0110",
				--"1110000" WHEN "0111",
				--"1111111" WHEN "1000",
				--"1111011" WHEN "1001",
				--"ZZZZZZZ" WHEN OTHERS;
	--case r_count is
    --when "0000" => SEV_BCD <= "0000001"; -- "0"     
    --when "0001" => SEV_BCD <= "1001111"; -- "1" 
    --when "0010" => SEV_BCD <= "0010010"; -- "2" 
    --when "0011" => SEV_BCD <= "0000110"; -- "3" 
    --when "0100" => SEV_BCD <= "1001100"; -- "4" 
    --when "0101" => SEV_BCD <= "0100100"; -- "5" 
    --when "0110" => SEV_BCD <= "0100000"; -- "6" 
    --when "0111" => SEV_BCD <= "0001111"; -- "7" 
    --when "1000" => SEV_BCD <= "0000000"; -- "8"
	 --when "1001" => SEV_BCD <= "0000100"; -- "9" 
    --when "1010" => SEV_BCD <= "0000010"; -- a
    --when "1011" => SEV_BCD <= "1100000"; -- b
    --when "1100" => SEV_BCD <= "0110001"; -- C
    --when "1101" => SEV_BCD <= "1000010"; -- d
    --when "1110" => SEV_BCD <= "0110000"; -- E
    --when "1111" => SEV_BCD <= "0111000"; -- F
  --END CASE;

end rtl;