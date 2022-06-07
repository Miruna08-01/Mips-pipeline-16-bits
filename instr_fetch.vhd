---------------------------------------------------------------------------------
--- Company: 
--- Engineer: 
--- 
--- Create Date: 03/17/2022 06:24:32 PM
--- Design Name: 
--- Module Name: instr_fetch - Behavioral
--- Project Name: 
--- Target Devices: 
--- Tool Versions: 
--- Description: 
--- 
--- Dependencies: 
--- 
--- Revision:
--- Revision 0.01 - File Created
--- Additional Comments:
--- 
---------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--- Uncomment the following library declaration if using
--- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

--- Uncomment the following library declaration if instantiating
--- any Xilinx leaf cells in this code.
---library UNISIM;
--use UNISIM.VComponents.all;

entity instr_fetch is
   Port ( jump : in STD_LOGIC;
          pcsrc : in STD_LOGIC;
          clk : in STD_LOGIC;
          ba : in STD_LOGIC_VECTOR(15 downto 0);
          ja : in STD_LOGIC_VECTOR(15 downto 0);
          en : in STD_LOGIC;
          reset : in STD_LOGIC;
          pcPlusUnu : out STD_LOGIC_VECTOR(15 downto 0);
          instruction : out STD_LOGIC_VECTOR(15 downto 0));
end instr_fetch;

  architecture Behavioral of instr_fetch is
signal pc_out : STD_LOGIC_VECTOR (15 DOWNTO 0) := X"0000";
signal sum: STD_LOGIC_VECTOR(15 DOWNTO 0):=X"0000";
signal mux1: STD_LOGIC_VECTOR(15 DOWNTO 0):=X"0000";
signal mux2:STD_LOGIC_VECTOR(15 DOWNTO 0):=X"0000";

type ROM is array(0 to 70) of STD_LOGIC_VECTOR(15 downto 0);
signal memorieROM: ROM:=(      --minimul unui sir la patrat
b"001_000_001_0000001", --2081 0 #i=0, contorul buclei
B"001_000_100_0000101", -- 2205, 1 #se salveaza numarul maxim de iteratii
b"000_000_000_010_0_000", --0020	2 #initializarea indexului locatiei de memorie
b"000_000_000_000_0_000", --noop    3
b"000_000_000_000_0_000", --noop    4
b"010_010_101_0000000", --	4A80 5   #min=arr[0]
b"100_001_100_0010000",	-- 8606  6 #s-au facut 5 iteratii? Daca da, sari la 
b"000_000_000_000_0_000", --noop    7
b"000_000_000_000_0_000", --noop    8
b"000_000_000_000_0_000", --noop    9
b"001_010_010_0000001",	--2901   10 #creste indexul
b"000_000_000_000_0_000", --noop    11
b"000_000_000_000_0_000", --noop    12
b"010_010_110_0000000",	--4B00 13 #salveaza in $6 urmatorul elem
b"000_000_000_000_0_000", --noop    14
b"000_000_000_000_0_000", --noop    15
b"101_110_101_0000100",	--BA84  16 #arr[i]>min? Daca da, sari
b"000_000_000_000_0_000", --noop    17
b"000_000_000_000_0_000", --noop    18
b"000_000_000_000_0_000", --noop    19
b"010_010_101_0000000",	-- 4A80  20 #daca nu, salveaza in $5 arr[i]
b"001_001_001_0000001",	-- 2481 21  #creste contorul
b"111_0000000000110",	--E006   22 #jump
b"000_000_000_000_0_000", --noop    23
b"000_000_000_111_0_000",  --0070 24 #pune in $7 0
b"000_000_000_000_0_000", --noop    25
b"000_000_000_011_0_000",   --0030 26 #pune in $3 valoarea 0
b"000_000_000_000_0_000", --noop    27
b"100_111_101_0000110",	-- 9E87  28 #este $7=$5? daca da sari
b"000_000_000_000_0_000", --noop    29
b"000_000_000_000_0_000", --noop    30
b"000_000_000_000_0_000", --noop    31
b"000_011_101_011_0_000",  --0EB0 32 #daca nu adauga in $3 valoarea lui $5
b"001_111_111_0000001",	--3F81   33 #creste contorul
b"111_0000000011100",   --E00D	34 #jump
b"000_000_000_000_0_000", --noop 35
b"011_010_011_0000000",	--6980   36 #salveaza minimul	la patrat
others=>x"1111");
begin

sum<=pc_out+1;
pcPlusUnu<=sum;

C_PROCESS: process(clk)
begin
if rising_edge(clk) then 
if reset='1' then
pc_out<=X"0000";
elsif en='1' then
pc_out<=mux2;
end if;
end if;
end process;

--mux1
mux1<=sum when pcsrc='0' else BA;
mux2<=mux1 when jump='0' else JA;

instruction<=memorieROM(conv_integer(pc_out));
end Behavioral;
