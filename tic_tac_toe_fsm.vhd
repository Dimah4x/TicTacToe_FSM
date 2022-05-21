library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tic_tac_toe_fsm is

port(clk : in std_logic;
	rst_n : in std_logic;
	player : in integer range 0 to 10;
	machine : out integer range 0 to 10;
	flag :	in std_logic;
	status	  : out std_logic_vector (1 downto 0));
end entity tic_tac_toe_fsm;

architecture tic_tac_toe_fsm_logic of tic_tac_toe_fsm is

type state is (start,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,finish);
signal prev_state,next_state : state;
signal status_sig : std_logic_vector (1 downto 0);
signal en : std_logic;


begin
status<=status_sig;
en <= '1' when ((flag = '1') and (status_sig = "00")) else '0';

process (clk,rst_n) is
begin
if rst_n='0' then
	prev_state <= start;
elsif (rising_edge(clk)) then
	prev_state<= next_state;
	case prev_state is
		when start=>
			next_state <= s1;
		when s1=>
			next_state <= s2;
			machine <=5;
			status_sig<="00";
		when s2=>
			case player is
				when 1 =>
					if (en = '1') then
						machine <= 2;
						next_state<=s3;
					end if;
				when 9 =>
					if (en = '1') then
						machine <= 2;
						next_state<=s3;
					end if;
				when  0 =>
					if (en ='1') then
						machine <= 4;
						next_state <= s5;
					end if;
				when 2 =>
					if (en ='1') then
						machine <= 6;
						next_state <= s8;
					end if;
				when 4 =>
					if (en ='1') then
						machine <= 0;
						next_state <= s11;
					end if;
				when 6 =>
					if(en ='1') then
						machine <= 2;
						next_state <= s13;
					end if;
				when 8 =>
					if(en ='1') then
						machine <= 4;
						next_state <= s15;
					end if;
				when 10 =>
					if(en ='1') then
						machine <= 9;
						next_state <= s18;
					end if;
				when others => null;
			end case;
		when s3 =>
			if(player /= 8) then
				machine<= 8;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 10;
				next_state <= s4;
			end if;
		when s4 =>
			if(player=0) then
				machine <= 6;
				status_sig <= "10";
				next_state <= finish;
			else
				machine <= 0;
				status_sig <= "10";
				next_state <= finish;
			end if;
		when s5 =>
			if(player /= 6) then
				machine<= 6;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 2;
				next_state <= s6;
			end if;
		when s6=>
			if(player /= 8) then
				machine <= 8;
				status_sig <= "10";
				next_state <= finish;
			else
				machine <= 1;
				next_state <= s7;
			end if;
		when s7=>
			if(player /= 9) then
				machine<= 9;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 10;
				status_sig<= "11";
				next_state <= finish;
			end if;
		when s8 =>
			if(player /= 4) then
				machine<= 4;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 0;
				next_state <= s9;
			end if;
		when s9=>
			if(player /= 10) then
				machine <= 10;
				status_sig <= "10";
				next_state <= finish;
			else
				machine <= 9;
				next_state <= s10;
			end if;
		when s10=>
			if(player /= 1) then
				machine<= 1;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 0;
				status_sig<= "11";
				next_state <= finish;
			end if;
		when s11 =>
			if(player /= 10) then
				machine<= 10;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 1;
				next_state <= s12;
			end if;
		when s12=>
			if(player /= 2) then
				machine <= 2;
				status_sig <= "10";
				next_state <= finish;
			else
				machine <= 9;
				status_sig <= "10";
				next_state <= finish;
			end if;
		when s13 =>
			if(player /= 8) then
				machine<= 8;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 1;
				next_state <= s14;
			end if;
		when s14=>
			if(player /= 0) then
				machine <= 0;
				status_sig <= "10";
				next_state <= finish;
			else
				machine <= 9;
				status_sig <= "10";
				next_state <= finish;
			end if;
		when s15 =>
			if(player /= 6) then
				machine<= 6;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 10;
				next_state <= s16;
			end if;
		when s16=>
			if(player /= 0) then
				machine <= 0;
				status_sig <= "10";
				next_state <= finish;
			else
				machine <= 1;
				next_state <= s17;
			end if;
		when s17=>
			if(player /= 9) then
				machine<= 9;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 2;
				status_sig<= "11";
				next_state <= finish;
			end if;
		when s18 =>
			if(player /= 1) then
				machine<= 1;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 2;
				next_state <= s19;
			end if;
		when s19=>
			if(player /= 8) then
				machine <= 8;
				status_sig <= "10";
				next_state <= finish;
			else
				machine <= 4;
				next_state <= s20;
			end if;
		when s20=>
			if(player /= 6) then
				machine<= 6;
				status_sig<= "10";
				next_state <= finish;
			else
				machine <= 0;
				status_sig<= "11";
				next_state <= finish;
			end if;
		when others => next_state <= start;
	end case;
end if;
end process;
end tic_tac_toe_fsm_logic; 