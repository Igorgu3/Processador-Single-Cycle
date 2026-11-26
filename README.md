# MIPS Single-Cycle Processor - FPGA

Implementação RTL (Register-Transfer Level) de um processador MIPS single-cycle em VHDL. Este projeto foi desenvolvido como trabalho final da disciplina de Laboratório de Sistemas Digitais da Universidade Federal de Minas Gerais (UFMG).

O objetivo é descrever em hardware um processador capaz de rodar "ao vivo" na FPGA, executando um programa em Assembly com loops aninhados que soma **100 bilhões de instruções** processadas.

## 💻 Arquitetura e Instruções Suportadas
O caminho de dados e a unidade de controle seguem o diagrama do enunciado (processador single-cycle com Decodificador Principal + Decodificador da ULA). Os nomes dos fios no VHDL são os mesmos do diagrama (`PC`, `PCPlus4`, `PCBranch`, `PCSrc`, `Instr`, `SignImm`, `WriteReg`, `SrcA`, `SrcB`, `ALUResult`, `Zero`, `WriteData`, `ReadData`, `Result`).

Com a liberação do professor para escolher o conjunto de instruções, o grupo implementou as instruções básicas abaixo (**`jal` não foi implementado**):

| Instrução | Tipo | Uso no programa |
|---|---|---|
| `addi` | I | inicializar e decrementar os contadores dos loops |
| `lw`   | I | ler da memória de dados |
| `sw`   | I | escrever na memória de dados |
| `beq`  | I | desvios dos loops (tomado e não tomado) |

A controladora também decodifica as instruções tipo R da tabela do enunciado (`add`, `sub`, `and`, `or`, `slt` e `mult` com funct `101011`).

## 🧮 Programa de 100 bilhões de instruções
O programa está em `src/memoria/loop_100b.asm` (código de máquina em `src/memoria/instrucoes.txt`). São três loops aninhados:

* loop externo: 2.000 voltas (`$t0`)
* loop do meio: 1.000 voltas (`$t1`)
* loop interno: 10.000 voltas (`$t2`), cada uma com `sw`, `lw`, `addi` e `beq`

No total são **100.006.006.001 instruções** (~1,0 × 10¹¹), cerca de 33 minutos a 50 MHz. No fim, o PC fica preso em `0x3C` (`beq $zero, $zero, fim_programa`).

## 📁 Estrutura
| Pasta | Conteúdo |
|---|---|
| `src/alu_pc/` | `pc_register`, `adder_pc4`, `adder_branch`, `alu` |
| `src/roteamento/` | `sign_extend`, `shift_left_2`, `mux2x1_32bits` (genérico, 32 ou 5 bits) |
| `src/memoria/` | `instruction_memory`, `data_memory`, `register_file`, programa (`.asm` e `instrucoes.txt`) |
| `src/controle/vhdl/` | Unidade de controle: `src_top` (= `main_decoder` + `alu_decoder`) |
| `src/top/` | `mips_datapath` (caminho de dados) |
| `src/processador/` | `processador` (datapath + controladora + memórias) |
| `src/fpga/` | `fpga_top` (top-level da placa) e `hex_to_7seg` |
| `src/testbenchs/` | Testbenches, incluindo o `tb_processador` do processador completo |

Cada arquivo `.vhd` tem o mesmo nome da entidade que ele contém.

## 🛠️ Tecnologias e Ferramentas
* **Descrição de Hardware:** VHDL
* **Compilação Assembly:** MARS (MIPS Assembler and Runtime Simulator)
* **Simulação:** GHDL (EDA Playground)
* **Síntese:** Intel Quartus Prime
* **Hardware Alvo:** Terasic DE10-Lite (Intel MAX 10, clock de 50 MHz)

## 🧪 Simulação
1. Adicione todos os `.vhd` de `src/` e o arquivo `src/memoria/instrucoes.txt` na mesma pasta do simulador.
2. Use `tb_processador` como top-level da simulação.
3. O testbench tem um modelo de referência próprio e compara a cada ciclo o PC, a saída da ULA, o `WriteData` e todos os sinais da controladora. No fim ele mostra um resumo e `SUCESSO` ou `FALHA`.
4. Toda escrita na memória de dados (`sw`) também fica registrada em `saida_memoria.txt`.

## 🚀 Executando na FPGA
1. Crie um projeto no Quartus com todos os `.vhd` de `src/` (sem os testbenches) e defina `fpga_top` como *top-level entity*.
2. Copie `src/memoria/instrucoes.txt` para a pasta do projeto do Quartus (a memória de instruções lê esse arquivo na síntese).
3. Compile e grave o *bitstream* na placa.

Interface na placa:
* `KEY(0)`: reset
* `SW(0)`: `0` = clock lento (1 Hz), `1` = 50 MHz
* `SW(1)`: escolhe o que aparece em `HEX3..HEX0`: `0` = `$t2`, `1` = `$t0`
* `LEDR(0..5)`: RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg
* `LEDR(8..6)`: ALUControl
* `LEDR(9)`: aceso quando o programa terminou (PC = `0x3C`)
* `HEX5..HEX4`: PC (byte menos significativo)
* `HEX3..HEX0` (em hexadecimal):
  * `SW(1) = 0`: último valor de `$t2` gravado na memória pelo `sw`. Bom para acompanhar em 1 Hz (muda a cada 5 s: `2710`, `270F`, …).
  * `SW(1) = 1`: último valor gravado no registrador `$t0` (contador do loop externo). Bom para acompanhar em 50 MHz: diminui 1 por segundo, de `07D0` (2000) até `0000`, em ~33 minutos.

Para o `$t0`, o processador expõe a instrução atual (`instr_out`). O `fpga_top` calcula o registrador destino (a mesma escolha do mux RegDst) e, sempre que há `RegWrite` no registrador 8, guarda a saída da ULA.

## 👥 Autores
* **Igor Araujo** - Memórias de Instrução/Dados e Banco de Registradores
* **[Nome do Integrante 2]** - ULA e Gerenciamento do Program Counter
* **[Nome do Integrante 3]** - Blocos de Extensão (Sign Extend/Shift) e Multiplexadores
* **Mariana Beatriz** - Datapath Principal e Integração
* **Gabriel da Cruz** - Unidade de Controle Single-Cycle
