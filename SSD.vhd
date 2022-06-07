----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2022 12:17:16 AM
-- Design Name: 
-- Module Name: SSD - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SSD is
    Port ( digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           digit4 : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end SSD;

architecture Behavioral of SSD is
signal temp:STD_LOGIC_VECTOR(15 downto 0):=(others=>'0');
signal mux1:STD_LOGIC_VECTOR(3 downto 0):=(others=>'0');
signal mux2:STD_LOGIC_VECTOR(3 downto 0):=(others=>'0');
begin
couter:process(clk)
begin
if rising_edge(clk) then 
temp<=temp+1;
end if;
end process;
muxPrim:process(temp) 
begin
case temp(15 downto 14) is
when "00"=>an<="1110";
when "01"=>an<="1101";
when "10"=>an<="1011";
when "11"=>an<="0111";
when others =>an<="ZZZZ";
end case;
end process;
muxDoi:process(digit1,digit2,digit3,digit4,temp) 
begin
case temp(15 downto 14) is
when "00"=>mux1<=digit1;
when "01"=>mux1<=digit2;
when "10"=>mux1<=digit3;
when "11"=>mux1<=digit4;
when others =>mux1<="ZZZZ";
end case;
end process;
bdc7:process(mux1)
begin
case mux1 is
 when "0001"=>cat<="1111001";   --1
when "0010"=>cat<="0100100";   --2
when "0011"=>cat<="0110000";    --3
when "0100"=>cat<="0011001";   --4
when "0101"=>cat<="0010010";    --5
when "0110"=>cat<="0000010";   --6
when "0111"=>cat<="1111000";   --7
when "1000"=>cat<="0000000";   --8
when "1001"=>cat<="0010000";   --9
when "1010"=>cat<="0001000";    --A
when "1011"=>cat<="0000011";   --b
when "1100"=>cat<="1000110";   --C
when "1101"=>cat<="0100001";   --d
when "1110"=>cat<="0000110";   --E
when "1111"=>cat<="0001110";   --F
when others=>cat<="1000000";   --0
end case;
end process;
end Behavioral;
