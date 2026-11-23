// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vsrc_top__Syms.h"


void Vsrc_top___024root__trace_chg_0_sub_0(Vsrc_top___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vsrc_top___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root__trace_chg_0\n"); );
    // Init
    Vsrc_top___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vsrc_top___024root*>(voidSelf);
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vsrc_top___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vsrc_top___024root__trace_chg_0_sub_0(Vsrc_top___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root__trace_chg_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    bufp->chgCData(oldp+0,(vlSelf->Opcode),6);
    bufp->chgCData(oldp+1,(vlSelf->funct),6);
    bufp->chgCData(oldp+2,(vlSelf->ALUop),2);
    bufp->chgBit(oldp+3,(vlSelf->MemtoReg));
    bufp->chgBit(oldp+4,(vlSelf->MemWrite));
    bufp->chgBit(oldp+5,(vlSelf->Branch));
    bufp->chgCData(oldp+6,(vlSelf->ALUControl),3);
    bufp->chgBit(oldp+7,(vlSelf->ALUSrc));
    bufp->chgBit(oldp+8,(vlSelf->RegDst));
    bufp->chgBit(oldp+9,(vlSelf->RegWrite));
}

void Vsrc_top___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root__trace_cleanup\n"); );
    // Init
    Vsrc_top___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vsrc_top___024root*>(voidSelf);
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VlUnpacked<CData/*0:0*/, 1> __Vm_traceActivity;
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        __Vm_traceActivity[__Vi0] = 0;
    }
    // Body
    vlSymsp->__Vm_activity = false;
    __Vm_traceActivity[0U] = 0U;
}
