----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2022 06:17:07 PM
-- Design Name: 
-- Module Name: ID - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IDecode is
  Port (
        clk: in std_logic;
        enable: in std_logic;
        RegWrite: in std_logic;
        instruction: in std_logic_vector(15 downto 0);
        RegDst: in std_logic;
        WD: in std_logic_vector(15 downto 0);
       WA :in STD_LOGIC_VECTOR(2 downto 0);
        ExtOp: in std_logic;
        RD1:out std_logic_vector(15 downto 0);
         RD2:out std_logic_vector(15 downto 0);
         Ext_Imm:out std_logic_vector(15 downto 0);
         sa:out std_logic;
         func:out std_logic_vector(2 downto 0);
         rt: out std_logic_vector(2 downto 0);
                 rd: out std_logic_vector(2 downto 0) );
end IDecode;

architecture Behavioral of IDecode is

component Reg_file is
  Port ( 
        ra1:in STD_LOGIC_VECTOR(2 downto 0);
     ra2:in STD_LOGIC_VECTOR(2 downto 0);
     WA :in STD_LOGIC_VECTOR(2 downto 0);
     Wd:in STD_LOGIC_VECTOR(15 downto 0);
     clk:in STD_LOGIC;
    RD1:out STD_LOGIC_VECTOR(15 downto 0);
     RD2:out STD_LOGIC_VECTOR(15 downto 0);
     en1:in Std_Logic;
     regwr:in Std_Logic);
end component Reg_file;

signal wrAddr: std_logic_vector(2 downto 0) := ( others => '0' );
signal ExtImmS:std_logic_vector(15 downto 0);
begin

registerFile: Reg_file port map(instruction(12 downto 10), instruction(9 downto 7),wa, WD,clk,RD1,RD2,enable, RegWrite);

--wrAddr<=instruction(9 downto 7) when RegDst='0' else instruction(6 downto 4);
func<=instruction(2 downto 0);
sa<=instruction(3);
 Ext_Imm <= "000000000" & instruction(6 downto 0) when ExtOp = '0'
       else instruction(6) & instruction(6) & instruction(6) & instruction(6) & instruction(6) & instruction(6) & instruction(6) & instruction(6) & instruction(6) & instruction(6 downto 0);

 rt <= instruction(9 downto 7);
    rd <= instruction(6 downto 4);

end Behavioral;
