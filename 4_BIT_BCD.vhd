library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SEV_BCD is
port (
  i_clk                       : in  std_logic;
  i_rstb                      : in  std_logic;
  i_sync_reset                : in  std_logic;
  i_count_ena                 : in  std_logic;
  O_bcd                       : out std_logic_vector(3 downto 0);
  SEV_BCD							:OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
end SEV_BCD;

architecture rtl of SEV_BCD is
signal r_count                 : unsigned(3 downto 0);


begin

o_bcd  <= std_logic_vector(r_count);
p_count : process(i_clk,i_rstb)
begin
  if(i_rstb='0') then
    r_count      <= (others=> '0');
  elsif(I_CLK'EVENT AND I_CLK='1') then
    if(i_sync_reset='1') then
      r_count      <= (others=> '0');
    elsif(i_count_ena='1') then
      if(r_count = 9) then
        r_count      <= (others=> '0');
      else
        r_count      <= r_count + 1;
      end if;
    end if;
  end if;
  case r_count is
    when "0000" =>SEV_BCD <= "0000001"; -- "0"     
    when "0001" =>SEV_BCD <= "1001111"; -- "1" 
    when "0010" =>SEV_BCD <= "0010010"; -- "2" 
    when "0011" =>SEV_BCD <= "0000110"; -- "3" 
    when "0100" =>SEV_BCD <= "1001100"; -- "4" 
    when "0101" =>SEV_BCD <= "0100100"; -- "5" 
    when "0110" =>SEV_BCD <= "0100000"; -- "6" 
    when "0111" =>SEV_BCD <= "0001111"; -- "7" 
    when "1000" =>SEV_BCD <= "0000000"; -- "8"
  END CASE;
end PROCESS;

--WITH R_COUNT SELECT 
		--BCD<= "1111110" WHEN "0000",
				--"0110000" WHEN	"0001",
				--"1101101" WHEN "0010",
				--"1111001" WHEN "0011",
				--"0110011" WHEN "0100",
				--"1011011" WHEN "0101",
				--"1011111" WHEN "0110",
				--"1110000" WHEN "0111",
				--"1111111" WHEN "1000",
				--"1111011" WHEN "1001",
				--"ZZZZZZZ" WHEN OTHERS;

end rtl;