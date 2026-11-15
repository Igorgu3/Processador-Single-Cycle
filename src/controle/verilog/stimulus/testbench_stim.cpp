#include <iostream>
#include <bitset>
#include "verilated.h"
#include "Vsrc_top.h"
#include <vector>

#include "verilated_vcd_c.h" // Ou verilated_fst_c.h

using namespace std;

Vsrc_top* top = nullptr;
VerilatedVcdC* pointer = nullptr;
vluint64_t main_t = 0;
const vluint64_t time_step = 10;  // Avança 10 unidades de tempo por instrução

//clock count, time unit and generation waves
void step() {
    top->eval();
    pointer->dump(main_t);
    main_t += time_step;
}

int main(int argc, char** argv)
{
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);
    
    top = new Vsrc_top;
    pointer = new VerilatedVcdC;
    top->trace(pointer, 99);
    pointer->open("Controller_wave.vcd");
    
    // 0x00: R | 0x23: lw | 0x28: sw | 0x02: j | 0x08: addi (immediate)
    uint8_t opcodes[] = {0X00, 0X23, 0X28, 0X02, 0X08};
    uint8_t function[] = {0x20,  0x22,  0x24,  0x25,  0x2A,  0x00, 0x00, 0x00, 0x00};
    const char* nomes[] = {"ADD", "SUB", "AND", "OR",  "SLT", "LW", "SW", "J",  "ADDI"};
  
    // Reset
    for(int j = 0; j < 5; j++) 
    {
         top->Opcode = opcodes[j];
         top->funct = function[j];
         step();
         
         std::cout << "Instruction: " << nomes[j] << " | "
                  << " (Opcode: "   << std::bitset<6>(opcodes[j]) << " | " << "Function: " << std::bitset<2>(function[j]) << ")" << "\n";
        
         // display output signals
         std::cout << "  ALUOp:    " << std::bitset<2>(top->ALUop) << "\n"
                  << " | RegDst:   " << (int)top->RegDst << "\n"
                  << " | ALUSrc:   " << (int)top->ALUSrc << "\n"
                  << " | MemtoReg: " << (int)top->MemtoReg << "\n"
                  << " | MemWrite: " << (int)top->MemWrite << "\n" 
                  << " | Branch:   " << (int)top->Branch << "\n"
                  << " | ALUControl: " << std::bitset<2>(top->ALUControl) << "\n"
                  << " | ALUSrc: "   << (int)top->ALUSrc << "\n"
                  << " | RegDst:   " << (int)top->RegDst << "\n"
                  << "   RegWrite: " << (int)top->RegWrite << "\n";
    }
    
    step();   //last instruction has a wavelength
    
    printf("Simulation at time: %ld \n", (main_t));

    pointer->close();
    delete top;
    delete pointer;
    return 0;
}
