----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2022 07:01:18 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
  Port ( 
  opcode:in std_logic_vector(2 downto 0);
        regdst:out std_logic;
        regwr:out std_logic;
        aluSrc:out std_logic;
        extOp:out std_logic;
        aluOp:out std_logic_vector(1 downto 0);
        memWrite:out std_logic;
        memReg:out std_logic;
        branch:out std_logic;
        jump:out std_logic;
        bgt:out std_logic
  );
end UC;

architecture Behavioral of UC is
begin
process(opcode)
begin
        regdst<='0';
        regwr<='0';
        aluSrc<='0';
        extOp<='0';
        aluOp<="00";
        memWrite<='0';
        memReg<='0';
        branch<='0';
        jump<='0';
        bgt<='0';
case opcode is 
when "000" =>
 regdst<='1'; --tipul R
 regwr<='1';
 aluSrc<='0';
 extOp<='0';
 aluOp<="00";
 memWrite<='0';
 memReg<='0';
 branch<='0';
 jump<='0';
 bgt<='0';
when "001" =>
 regdst<='0'; --addi
 regwr<='1';
 aluSrc<='1';
 extOp<='1';
 aluOp<="01";
 memWrite<='0';
 memReg<='0';
 branch<='0';
 jump<='0';
 bgt<='0';
 when "010"=> ----lw
    regdst<='0';
  regwr<='1';
  aluSrc<='1';
  extOp<='1';
  aluOp<="01";
  memWrite<='0';
  memReg<='1';
  branch<='0';
  jump<='0';
  bgt<='0';
  when "011"=> ----sw
    regdst<='0';
   regwr<='0';
   aluSrc<='1';
   extOp<='1';
   aluOp<="01";
   memWrite<='1';
   memReg<='0';
   branch<='0';
   jump<='0';
   bgt<='0';
when "100" => -- beq
  regdst<='0';
 regwr<='0';
 aluSrc<='0';
 extOp<='1';
 aluOp<="10";
 memWrite<='0';
 memReg<='0';
 branch<='1';
 jump<='0';
 bgt<='0';
 when "101" => ---bgt
   regdst<='0';
  regwr<='0';
  aluSrc<='0';
  extOp<='1';
  aluOp<="10";
  memWrite<='0';
  memReg<='0';
  branch<='0';
  jump<='0';
  bgt<='1';
 when "110" => --ori
   regdst<='0';
  regwr<='1';
  aluSrc<='1';
  extOp<='1';
  aluOp<="11";
  memWrite<='0';
  memReg<='0';
  branch<='0';
  jump<='0';
  bgt<='0';
 when "111" => ----jump
  regdst<='0';
  regwr<='0';
  aluSrc<='0';
  extOp<='0';
  aluOp<="00";
  memWrite<='0';
  memReg<='0';
  branch<='0';
  jump<='1';
  bgt<='0';

 when others=>
 regdst<='X';
         regwr<='X';
         aluSrc<='X';
         extOp<='X';
         aluOp<="XX";
         memWrite<='X';
         memReg<='X';
         branch<='X';
         jump<='X';
         bgt<='X';
         end case;
end process;

end Behavioral;
