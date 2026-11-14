# MIPS Single-Cycle Processor - FPGA

Implementação RTL (Register-Transfer Level) de um processador MIPS single-cycle em VHDL[cite: 1]. Este projeto foi desenvolvido como trabalho final da disciplina de Laboratório de Sistemas Digitais da Universidade Federal de Minas Gerais (UFMG)[cite: 1].

O objetivo principal deste repositório é descrever em hardware um processador capaz de rodar "ao vivo" no FPGA, executando um programa em Assembly com loops estruturados para atingir a marca de **100 bilhões de instruções** processadas[cite: 1].

## 💻 Arquitetura e Instruções Suportadas
O processador e seu sistema de controle foram projetados para suportar instruções base do MIPS[cite: 1], com validação obrigatória das seguintes operações[cite: 1]:
* `Branch` (Desvios condicionais)[cite: 1]
* `Jal` (Jump and Link)[cite: 1]
* `Lw` (Load Word)[cite: 1]
* `Sw` (Store Word)[cite: 1]

Para o desenvolvimento ágil, a microarquitetura foi dividida em blocos hierárquicos:
* **Datapath e Unidade de Controle:** Integração central e decodificação de Opcode/Funct.
* **Memórias e Banco de Registradores:** Instruction Memory (inicializada estaticamente com o código de máquina), Register File (32 registradores) e Data Memory.
* **Gerenciamento do PC e ULA:** Program Counter, Somadores (PC+4 e Branch) e Unidade Lógica e Aritmética.
* **Extensões e Roteamento:** Sign Extend, Shift Left 2 e Multiplexadores de barramento.

## 🛠️ Tecnologias e Ferramentas
* **Descrição de Hardware:** VHDL[cite: 1]
* **Compilação Assembly:** MARS (MIPS Assembler and Runtime Simulator)[cite: 1]
* **Síntese e Simulação:** [Inserir Intel Quartus ou Xilinx Vivado]
* **Hardware Alvo:** [Inserir o modelo da sua placa FPGA]

## 🚀 Como Executar
1. Clone este repositório: `git clone <url-do-repo>`
2. Abra o projeto na sua IDE de desenvolvimento FPGA (Quartus/Vivado).
3. O código fonte dos blocos está localizado na pasta `src/`.
4. Os testes unitários (Testbenches) estão na pasta `tb/`.
5. O arquivo com o código de máquina gerado pelo MARS para inicializar a Memória de Instruções está no diretório `mem/`.
6. Compile o projeto e grave o *bitstream* na placa. 

## 👥 Autores
* **Igor Araujo** - Memórias de Instrução/Dados e Banco de Registradores
* **[Nome do Integrante 2]** - ULA e Gerenciamento do Program Counter
* **[Nome do Integrante 3]** - Blocos de Extensão (Sign Extend/Shift) e Multiplexadores
* **Mariana Beatriz** - Datapath Principal e Integração
* **Gabriel Santos** - Unidade de Controle Single-Cycle
