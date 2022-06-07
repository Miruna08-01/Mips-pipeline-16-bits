----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2022 07:13:53 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
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
entity mem is
  Port (clk:in std_logic;
        enable:in std_logic;
  memWr: in std_logic;
  aluResIn: in std_logic_vector (15 downto 0);
  rd2: in std_logic_vector(15 downto 0);
  memData: out std_logic_vector(15 downto 0);
  aluResOut: out std_logic_vector(15 downto 0));
end mem;

architecture Behavioral of MEM is
    type ram_array is array (0 to 31) of std_logic_vector(15 downto 0);
    signal RAM: ram_array := (
        X"0006",
		X"0009",
		X"0005",
		X"0003",
		X"0007",
		others =>X"1111");
 signal read_address : std_logic_vector(15 downto 0);
        
        begin
        
        process(memWr,clk,enable) is
          begin
             if enable = '1' then
                      if rising_edge(clk) AND memwr = '1' then
                ram(conv_integer(aluResIn)) <= rd2;
              end if;
              end if;
        end process;
          
        aluresout<=aluresin;
        memData <= ram(conv_integer(aluResIn));
end Behavioral;
