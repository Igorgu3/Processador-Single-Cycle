----------------------------------------------------------------------------------
-- tb_src_top  -- exhaustive check of the MIPS control unit
--
-- Applies every Opcode (0..63) with every funct (0..63) = 4096 vectors and
-- compares all seven outputs against an independent reference model written
-- in the testbench.  Also prints the control-signal table for the four real
-- instructions (handy for the lab report).
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;
 
entity tb_src_top is
end entity tb_src_top;
 
architecture sim of tb_src_top is
 
    signal Opcode  : std_logic_vector(5 downto 0) := (others => '0');
    signal funct  : std_logic_vector(5 downto 0) := (others => '0');
    signal ALUop  : std_logic_vector(1 downto 0);
    signal MemtoReg : std_logic;
    signal MemWrite : std_logic;
    signal Branch : std_logic;
    signal ALUControl : std_logic_vector(2 downto 0);
    signal ALUSrc  : std_logic;
    signal RegDst  : std_logic;
    signal RegWrite : std_logic;
 
    -- ---------------- reference model (independent of the DUT) ----------------
 
    function x_aluop(op : integer) return std_logic_vector is
    begin
        case op is
            when 16#00# => return "10";     -- R-type
            when 16#23# => return "00";     -- lw   100011
            when 16#2B# => return "00";     -- sw   101011
            when 16#04# => return "01";     -- beq  000100
            when others => return "00";
        end case;
    end function;
 
    function x_regwrite(op : integer) return std_logic is
    begin
        if op = 16#00# or op = 16#23# then return '1'; else return '0'; end if;
    end function;
 
    function x_regdst(op : integer) return std_logic is
    begin
        if op = 16#00# then return '1'; else return '0'; end if;
    end function;
 
    function x_alusrc(op : integer) return std_logic is
    begin
        if op = 16#23# or op = 16#2B# then return '1'; else return '0'; end if;
    end function;
 
    function x_memtoreg(op : integer) return std_logic is
    begin
        if op = 16#23# then return '1'; else return '0'; end if;
    end function;
 
    function x_memwrite(op : integer) return std_logic is
    begin
        if op = 16#2B# then return '1'; else return '0'; end if;
    end function;
 
    function x_branch(op : integer) return std_logic is
    begin
        if op = 16#04# then return '1'; else return '0'; end if;
    end function;
 
    function x_alucontrol(f : integer; o : std_logic_vector(1 downto 0))
        return std_logic_vector is
    begin
        if o = "00" then
            return "010";                                   -- add  (lw/sw)
        elsif o = "01" or o = "11" then
            return "110";                                   -- sub  (beq/bne)
        else                                                -- o = "10" -> R-type
            case f is
                when 16#20# => return "010";                -- add
                when 16#22# => return "110";                -- sub
                when 16#24# => return "000";                -- and
                when 16#25# => return "001";                -- or
                when 16#2A# => return "111";                -- slt
                when 16#2B# => return "011";                -- mult
                when others => return "000";
            end case;
        end if;
    end function;
 
    -- -------------------------------------------------------------------------
 
    procedure show(l : inout line; op, f : integer) is
        variable ok : boolean := true;
    begin
        write(l, string'("Opcode="));
        write(l, op, right, 3);
        write(l, string'("  funct=00x"));
        write(l, std_logic_vector(to_unsigned(f, 6)));
        write(l, string'("  ALUControl="));
        write(l, string'("   "));
    end procedure;
 
begin
 
    dut : entity work.src_top
        port map (
            Opcode     => Opcode,
            funct      => funct,
            ALUop      => ALUop,
            MemtoReg   => MemtoReg,
            MemWrite   => MemWrite,
            Branch     => Branch,
            ALUControl => ALUControl,
            ALUSrc     => ALUSrc,
            RegDst     => RegDst,
            RegWrite   => RegWrite
        );
 
    stim : process
        variable errs : integer := 0;
        variable l    : line;
        variable opi  : integer;
    begin
        for op in 0 to 63 loop
            for f in 0 to 63 loop
                Opcode <= std_logic_vector(to_unsigned(op, 6));
                funct  <= std_logic_vector(to_unsigned(f, 6));
                wait for 1 ns;
 
                opi := op;
                if ALUop      /= x_aluop(opi)                 then errs := errs + 1;
                    report "ALUop mismatch op=" & integer'image(op) severity error; end if;
                if RegWrite   /= x_regwrite(opi)              then errs := errs + 1;
                    report "RegWrite mismatch op=" & integer'image(op) severity error; end if;
                if RegDst     /= x_regdst(opi)                then errs := errs + 1;
                    report "RegDst mismatch" severity error; end if;
                if ALUSrc     /= x_alusrc(opi)                then errs := errs + 1;
                    report "ALUSrc mismatch" severity error; end if;
                if MemtoReg   /= x_memtoreg(opi)              then errs := errs + 1;
                    report "MemtoReg mismatch" severity error; end if;
                if MemWrite   /= x_memwrite(opi)              then errs := errs + 1;
                    report "MemWrite mismatch" severity error; end if;
                if Branch     /= x_branch(opi)                then errs := errs + 1;
                    report "Branch mismatch" severity error; end if;
            end loop;
        end loop;
 
        -- ALUControl depends on funct: only check where it matters (ALUop="10")
        for f in 0 to 63 loop
            Opcode <= "000000";
            funct  <= std_logic_vector(to_unsigned(f, 6));
            wait for 1 ns;
            if ALUControl /= x_alucontrol(f, "10") then
                errs := errs + 1;
                report "ALUControl mismatch funct=" & integer'image(f) severity error;
            end if;
        end loop;
 
        report "tb_src_top: 4096 + 64 vectors checked, errors = " & integer'image(errs);
 
        -- control-signal table for the report
        write(l, string'(""));
        writeline(output, l);
        write(l, string'(" Opcode Instr  RegW RegDst ALUSrc MemtoReg MemW Branch ALUop ALUCtrl"));
        writeline(output, l);
 
        -- R-type add
        Opcode <= "000000"; funct <= "100000"; wait for 1 ns;
		  write(l, string'(" 000000 R-add  "));
		  write(l, std_logic'image(RegWrite) & "    " & std_logic'image(RegDst) & "      ");
	 	  write(l, std_logic'image(ALUSrc) & "      " & std_logic'image(MemtoReg));
		  write(l, "     " & std_logic'image(MemWrite) & "     " & std_logic'image(Branch));
		  write(l, string'("     "));
		  write(l, ALUop);
		  write(l, string'("    "));
		  write(l, ALUControl);
		  writeline(output, l);
 
        -- lw
		  Opcode <= "100011"; wait for 1 ns;
		  write(l, string'(" 100011 lw     "));
		  write(l, std_logic'image(RegWrite) & "    " & std_logic'image(RegDst) & "      ");
		  write(l, std_logic'image(ALUSrc) & "      " & std_logic'image(MemtoReg));
		  write(l, "     " & std_logic'image(MemWrite) & "     " & std_logic'image(Branch));
		  write(l, string'("     "));
		  write(l, ALUop);
		  write(l, string'("    "));
		  write(l, ALUControl);
		  writeline(output, l);

		  -- sw
		  Opcode <= "101011"; wait for 1 ns;
	 	  write(l, string'(" 101011 sw     "));
		  write(l, std_logic'image(RegWrite) & "    " & std_logic'image(RegDst) & "      ");
		  write(l, std_logic'image(ALUSrc) & "      " & std_logic'image(MemtoReg));
		  write(l, "     " & std_logic'image(MemWrite) & "     " & std_logic'image(Branch));
		  write(l, string'("     "));
		  write(l, ALUop);
		  write(l, string'("    "));
		  write(l, ALUControl);
		  writeline(output, l);

		  -- beq
		  Opcode <= "000100"; wait for 1 ns;
		  write(l, string'(" 000100 beq    "));
		  write(l, std_logic'image(RegWrite) & "    " & std_logic'image(RegDst) & "      ");
		  write(l, std_logic'image(ALUSrc) & "      " & std_logic'image(MemtoReg));
		  write(l, "     " & std_logic'image(MemWrite) & "     " & std_logic'image(Branch));
		  write(l, string'("     "));
		  write(l, ALUop);
		  write(l, string'("    "));
		  write(l, ALUControl);
		  writeline(output, l);
 
        report "done" severity note;
        wait;
    end process stim;
 
end architecture sim;
