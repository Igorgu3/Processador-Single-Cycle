// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vsrc_top.h for the primary calling header

#ifndef VERILATED_VSRC_TOP___024ROOT_H_
#define VERILATED_VSRC_TOP___024ROOT_H_  // guard

#include "verilated.h"


class Vsrc_top__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vsrc_top___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(Opcode,5,0);
    VL_IN8(funct,5,0);
    VL_OUT8(ALUop,1,0);
    VL_OUT8(MemtoReg,0,0);
    VL_OUT8(MemWrite,0,0);
    VL_OUT8(Branch,0,0);
    VL_OUT8(ALUControl,2,0);
    VL_OUT8(ALUSrc,0,0);
    VL_OUT8(RegDst,0,0);
    VL_OUT8(RegWrite,0,0);
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<0> __VactTriggered;
    VlTriggerVec<0> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vsrc_top__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vsrc_top___024root(Vsrc_top__Syms* symsp, const char* v__name);
    ~Vsrc_top___024root();
    VL_UNCOPYABLE(Vsrc_top___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
