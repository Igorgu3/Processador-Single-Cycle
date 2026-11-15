#include <iostream>
#include <bitset>
#include "verilated.h"
#include "src_top.h"
#include <vector>

#include "verilated_fst_c.h"

using namespace std;

const vluint64_t scale_factor = 1000;			//1ns = 1000ps
const vluint64_t clock_half_period = 5 * scale_factor;		//half period of clock (5ns)
const int SIMUL_CYCLES = 1000000;			//total cycles (150 us)

//clock count, time unit and generation waves
void tick()
{
    top->clk = 0;
    top->eval();
    pointer->dump(main_t);
    main_t += clock_half_period;

    //rising edge
    top->clk = 1;
    top->eval();

  	 //Displaying LFSR signals & time running
		
    pointer->dump(main_t);
    main_t += clock_half_period;
}

int main(int argc, char** argv)
{
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    top = new src_top;
    pointer = new VerilatedFstC;

    top->trace(pointer, 99);
    pointer->open("Controller_wave.vcd");
    
    // 0x00: R | 0x23: lw | 0x28: sw | 0x02: j | 0x08: addi (immediate)
    uint8_t opcodes[] = {0X00, 0X23, 0X28, 0X02, 0X08};
    const char* nomes[] = {"R", "LW", "SW", "J", "I(ADDI)"};
  
    // Reset
    for(int j = 0; j < 5; j++) 
    {
         top->Opcode = Opcode[j];
         
         tick();
         top->eval();
         
         std::cout << "Instruction: " << nomes[j] 
                  << " (Opcode:   "   << std::bitset<6>(Opcode[j]) << ")\n"
                  << " (Function: " << std::bitset<6>(funct[j]) << ")\n";
        
         // display output signals
         std::cout << "  ALUOp:    " << std::bitset<2>(top->ALUOp) << "\n\n"
                  << " | RegDst:   " << (int)top->RegDst << "\n"
                  << " | ALUSrc:   " << (int)top->ALUSrc << "\n"
                  << " | MemtoReg: " << (int)top->MemtoReg << "\n"
                  << " | MemWrite: " << (int)top->MemWrite << "\n" 
                  << " | Branch:   " << (int)top->Branch << "\n"
                  << " | ALUControl: " << std::bitset<2>(top->ALUControl) << "\n"
                  << " | ALUSrc: "   << (int)top->ALUSrc << "\n"
                  << " | RegDst:   " << (int)top->RegDst << "\n";
                  << "   RegWrite: " << (int)top->RegWrite << "\n";
    }
    
    printf("Simulation at time: %ld \n", (main_t/1000));

    pointer->close();
    delete top;
    delete pointer;
    return 0;
}
