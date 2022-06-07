----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2022 06:55:13 PM
-- Design Name: 
-- Module Name: test_env1 - Behavioral
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

entity msg is
    Port ( clk : in STD_LOGIC;
            btn:in STD_LOGIC;
           enable:out STD_LOGIC);
           
end msg;

architecture Behavioral of msg is
signal temp:STD_LOGIC_VECTOR(15 downto 0):=(others=>'0');
signal q1: STD_LOGIC:='0';
signal q2:STD_LOGIC:='0';
signal q3:STD_LOGIC:='0';
begin
counter:process(clk)
begin
if rising_edge(clk) then
temp<=temp+ '1';
end if;
end process;
reg1:process(temp,clk)
begin
if rising_edge(clk) then
if temp="1111111111111111" then 
q1<=btn;
end if;
end if;
end process;

reg2:process(clk)
begin
if rising_edge(clk) then
q2<=q1;
q3<=q2;
end if;
end process;
enable<=(NOT q3) AND q2;
end Behavioral;
