library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-------------------------------------------------------------------------------
entity tic_tac_toe_fsm_tb is
end entity tic_tac_toe_fsm_tb;
-------------------------------------------------------------------------------
architecture arc_tic_tac_toe_fsm_tb of tic_tac_toe_fsm_tb is

component tic_tac_toe_fsm is
port (  clk  : in std_logic;
	rst_n : in std_logic;
	player : in integer range 0 to 10;
	machine : out integer range 0 to 10;
	flag :	in std_logic; -- flag for test bench
	status	  : out std_logic_vector (1 downto 0));
end component;

signal rst_n :  std_logic := '0';
signal clk : std_logic := '0';
signal player : integer range 0 to 10 := 0;
signal machine : integer range 0 to 10 := 0;
signal enable_s : std_logic := '1';
signal status_s :  std_logic_vector (1 downto 0) := (others => '0'); 

begin
-- DUT instantiation
DUT : tic_tac_toe_fsm

port map (
	rst_n => rst_n,
	clk=>clk,
	player=>player,
	machine=>machine,
	flag=>enable_s,
	status=>status_s);

   clk <= not clk after 10 ns;
   rst_n <= '1'     after 20 ns;

   WaveGen_Proc : process
      variable lr, lw : line;
      variable o_sel  : integer;
   begin
      wait until rst_n = '1';
      wait on machine;
      wait until rising_edge(clk);
      l1 : loop
         write(lw, string'("x machine selects ") & integer'image(machine));
         writeline(output, lw);
		 exit l1 when (status_s /= "00");
         readline(input, lr);
         read(lr, o_sel);
         player <= o_sel;
        enable_s   <= '1';
         wait until rising_edge(clk);
         enable_s   <= '0';
         wait on machine, status_s;
		 wait until rising_edge(clk);
      end loop l1;
      write(lw, string'("end of game with status ") & integer'image(conv_integer(status_s)));
      writeline(output, lw);
      wait;
   end process WaveGen_Proc;
end arc_tic_tac_toe_fsm_tb;
