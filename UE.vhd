----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2022 06:25:37 PM
-- Design Name: 
-- Module Name: UE - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UE is
  Port (RD1: in STD_LOGIC_VECTOR (15 downto 0);
        RD2: in STD_LOGIC_VECTOR (15 downto 0);
        ALUSrc: in STD_LOGIC;
        Ext_Imm: in STD_LOGIC_VECTOR (15 downto 0);
        sa:in STD_LOGIC;
        func:in STD_LOGIC_VECTOR(2 downto 0);
        aluop:in STD_LOGIC_VECTOR(1 downto 0);
        PCNext: in STD_LOGIC_VECTOR (15 downto 0);
        BranchAddr: out STD_LOGIC_VECTOR (15 downto 0);
        ALURes: out STD_LOGIC_VECTOR (15 downto 0);
        Zero: out STD_LOGIC;
        greater:out STD_LOGIC;
        rt:in std_logic_vector(2 downto 0);
         rd:in std_logic_vector(2 downto 0);
       wa:out STD_LOGIC_VECTOR(2 downto 0);
       regdst:in std_logic
         );
end UE;

architecture Behavioral of UE is
signal Aluctrl: STD_LOGIC_VECTOR(2 downto 0);
signal iesireMux: STD_LOGIC_VECTOR(15 downto 0);
signal ALUResAux :STD_LOGIC_VECTOR (15 downto 0);
begin
first:process(aluop,func)
begin
case aluop is
when "00"=>Aluctrl<=func;
when "01"=>Aluctrl<="000";
when "10"=>Aluctrl<="001";
when "11"=>Aluctrl<="110";
when others =>Aluctrl<="XXX";
end case;
end process;

iesireMux<=RD2 when Alusrc='0' else Ext_Imm;
second: process(RD1, iesireMux, ALUCtrl, sa)
begin
  case ALUCtrl is
  when "000"=>ALUResAux<=RD1+iesireMux;
  when "001"=>AluResAux<=RD1-iesireMux;
  when "010"=>
  if sa = '1' then
  ALUResAux<=iesireMux(14 downto 0) & '0';
  else 
  AlUResAux<=iesireMux;
  end if;
  when "011"=>
    if sa = '1' then
  ALUResAux<='0'&iesireMux(14 downto 0);
  else 
  AlUResAux<=iesireMux;
  end if;
   when "100"=>ALUResAux<=RD1 or iesireMux;
   when "101"=>ALUResAux<=RD1 and iesireMux;
   when "110"=>ALUResAux<=RD1 xor iesireMux;
   when "111"=>
   if RD1 < iesireMux then
                       ALUResAux <= X"0001";
                   else 
                       ALUResAux <= X"0000";
                   end if;
    end case;
    end process;
   Zero<='1' when ALUResAux = X"0000"  else '0';
   greater <='1' when RD1>iesireMux else '0';
    
  BranchAddr <= PCNext + Ext_Imm;
  ALURes <= ALUResAux;
  wa<=rt when regdst='0' else rd;

end Behavioral;
