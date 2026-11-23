// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsrc_top.h for the primary calling header

#include "Vsrc_top__pch.h"
#include "Vsrc_top___024root.h"

extern const VlUnpacked<CData/*0:0*/, 64> Vsrc_top__ConstPool__TABLE_h468a064c_0;
extern const VlUnpacked<CData/*0:0*/, 64> Vsrc_top__ConstPool__TABLE_h9c50cc6f_0;
extern const VlUnpacked<CData/*0:0*/, 64> Vsrc_top__ConstPool__TABLE_hac88bb16_0;
extern const VlUnpacked<CData/*0:0*/, 64> Vsrc_top__ConstPool__TABLE_h07955efe_0;
extern const VlUnpacked<CData/*0:0*/, 64> Vsrc_top__ConstPool__TABLE_h3e8a5fce_0;
extern const VlUnpacked<CData/*0:0*/, 64> Vsrc_top__ConstPool__TABLE_h9be1d641_0;
extern const VlUnpacked<CData/*1:0*/, 64> Vsrc_top__ConstPool__TABLE_h7198fa83_0;
extern const VlUnpacked<CData/*2:0*/, 256> Vsrc_top__ConstPool__TABLE_h8db564b2_0;

VL_INLINE_OPT void Vsrc_top___024root___ico_sequent__TOP__0(Vsrc_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root___ico_sequent__TOP__0\n"); );
    // Init
    CData/*5:0*/ __Vtableidx1;
    __Vtableidx1 = 0;
    CData/*7:0*/ __Vtableidx2;
    __Vtableidx2 = 0;
    // Body
    __Vtableidx1 = vlSelf->Opcode;
    vlSelf->MemtoReg = Vsrc_top__ConstPool__TABLE_h468a064c_0
        [__Vtableidx1];
    vlSelf->MemWrite = Vsrc_top__ConstPool__TABLE_h9c50cc6f_0
        [__Vtableidx1];
    vlSelf->Branch = Vsrc_top__ConstPool__TABLE_hac88bb16_0
        [__Vtableidx1];
    vlSelf->ALUSrc = Vsrc_top__ConstPool__TABLE_h07955efe_0
        [__Vtableidx1];
    vlSelf->RegDst = Vsrc_top__ConstPool__TABLE_h3e8a5fce_0
        [__Vtableidx1];
    vlSelf->RegWrite = Vsrc_top__ConstPool__TABLE_h9be1d641_0
        [__Vtableidx1];
    vlSelf->ALUop = Vsrc_top__ConstPool__TABLE_h7198fa83_0
        [__Vtableidx1];
    __Vtableidx2 = (((IData)(vlSelf->funct) << 2U) 
                    | (IData)(vlSelf->ALUop));
    vlSelf->ALUControl = Vsrc_top__ConstPool__TABLE_h8db564b2_0
        [__Vtableidx2];
}

void Vsrc_top___024root___eval_ico(Vsrc_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root___eval_ico\n"); );
    // Body
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        Vsrc_top___024root___ico_sequent__TOP__0(vlSelf);
    }
}

void Vsrc_top___024root___eval_triggers__ico(Vsrc_top___024root* vlSelf);

bool Vsrc_top___024root___eval_phase__ico(Vsrc_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root___eval_phase__ico\n"); );
    // Init
    CData/*0:0*/ __VicoExecute;
    // Body
    Vsrc_top___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = vlSelf->__VicoTriggered.any();
    if (__VicoExecute) {
        Vsrc_top___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

void Vsrc_top___024root___eval_act(Vsrc_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root___eval_act\n"); );
}

void Vsrc_top___024root___eval_nba(Vsrc_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root___eval_nba\n"); );
}

void Vsrc_top___024root___eval_triggers__act(Vsrc_top___024root* vlSelf);

bool Vsrc_top___024root___eval_phase__act(Vsrc_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<0> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vsrc_top___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vsrc_top___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vsrc_top___024root___eval_phase__nba(Vsrc_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vsrc_top___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vsrc_top___024root___dump_triggers__ico(Vsrc_top___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vsrc_top___024root___dump_triggers__nba(Vsrc_top___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vsrc_top___024root___dump_triggers__act(Vsrc_top___024root* vlSelf);
#endif  // VL_DEBUG

void Vsrc_top___024root___eval(Vsrc_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VicoIterCount;
    CData/*0:0*/ __VicoContinue;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VicoIterCount = 0U;
    vlSelf->__VicoFirstIteration = 1U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        if (VL_UNLIKELY((0x64U < __VicoIterCount))) {
#ifdef VL_DEBUG
            Vsrc_top___024root___dump_triggers__ico(vlSelf);
#endif
            VL_FATAL_MT("../src_top.v", 1, "", "Input combinational region did not converge.");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
        __VicoContinue = 0U;
        if (Vsrc_top___024root___eval_phase__ico(vlSelf)) {
            __VicoContinue = 1U;
        }
        vlSelf->__VicoFirstIteration = 0U;
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vsrc_top___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("../src_top.v", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vsrc_top___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("../src_top.v", 1, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vsrc_top___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vsrc_top___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vsrc_top___024root___eval_debug_assertions(Vsrc_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsrc_top___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->Opcode & 0xc0U))) {
        Verilated::overWidthError("Opcode");}
    if (VL_UNLIKELY((vlSelf->funct & 0xc0U))) {
        Verilated::overWidthError("funct");}
}
#endif  // VL_DEBUG
