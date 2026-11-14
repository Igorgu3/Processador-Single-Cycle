# Entradas e Saídas - Roteamento 

Blocos combinacionais testados no ModelSim (tb_roteamento.vhd).

## 1. Sign Extend (sign_extend.vhd)
- imm_in (16 bits) -> ligar em Instr(15:0)
- imm_out (32 bits) -> sai o sinal SignImm

## 2. Shift Left 2 (shift_left_2.vhd)
- data_in (32 bits) -> ligar no SignImm
- data_out (32 bits) -> vai para o somador do PCBranch

## 3. Mux 2x1 (mux2x1_32bits.vhd)
Parâmetro WIDTH: padrão 32 (alterar para 5 no Mux do RegDst)
- in0 -> entrada selecionada quando sel = '0'
- in1 -> entrada selecionada quando sel = '1'
- sel -> sinal de controle
- y -> saída roteada

### Onde ligar os 4 Muxes no Datapath:

Mux do PC (WIDTH => 32)
- in0 => PCPlus4
- in1 => PCBranch
- sel => PCSrc
- y => PC'

Mux do RegDst (WIDTH => 5)
- in0 => Instr(20:16)
- in1 => Instr(15:11)
- sel => RegDst
- y => WriteReg

Mux da ULA (WIDTH => 32)
- in0 => RD2
- in1 => SignImm
- sel => ALUSrc
- y => SrcB

Mux da Memória (WIDTH => 32)
- in0 => ALUResult
- in1 => ReadData
- sel => MemtoReg
- y => Result