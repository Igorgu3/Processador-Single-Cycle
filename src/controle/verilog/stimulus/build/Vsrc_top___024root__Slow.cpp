// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsrc_top.h for the primary calling header

#include "Vsrc_top__pch.h"
#include "Vsrc_top__Syms.h"
#include "Vsrc_top___024root.h"

void Vsrc_top___024root___ctor_var_reset(Vsrc_top___024root* vlSelf);

Vsrc_top___024root::Vsrc_top___024root(Vsrc_top__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vsrc_top___024root___ctor_var_reset(this);
}

void Vsrc_top___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vsrc_top___024root::~Vsrc_top___024root() {
}
