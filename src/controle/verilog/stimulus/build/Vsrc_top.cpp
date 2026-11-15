// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vsrc_top__pch.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

Vsrc_top::Vsrc_top(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vsrc_top__Syms(contextp(), _vcname__, this)}
    , Opcode{vlSymsp->TOP.Opcode}
    , funct{vlSymsp->TOP.funct}
    , ALUop{vlSymsp->TOP.ALUop}
    , MemtoReg{vlSymsp->TOP.MemtoReg}
    , MemWrite{vlSymsp->TOP.MemWrite}
    , Branch{vlSymsp->TOP.Branch}
    , ALUControl{vlSymsp->TOP.ALUControl}
    , ALUSrc{vlSymsp->TOP.ALUSrc}
    , RegDst{vlSymsp->TOP.RegDst}
    , RegWrite{vlSymsp->TOP.RegWrite}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vsrc_top::Vsrc_top(const char* _vcname__)
    : Vsrc_top(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vsrc_top::~Vsrc_top() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vsrc_top___024root___eval_debug_assertions(Vsrc_top___024root* vlSelf);
#endif  // VL_DEBUG
void Vsrc_top___024root___eval_static(Vsrc_top___024root* vlSelf);
void Vsrc_top___024root___eval_initial(Vsrc_top___024root* vlSelf);
void Vsrc_top___024root___eval_settle(Vsrc_top___024root* vlSelf);
void Vsrc_top___024root___eval(Vsrc_top___024root* vlSelf);

void Vsrc_top::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vsrc_top::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vsrc_top___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vsrc_top___024root___eval_static(&(vlSymsp->TOP));
        Vsrc_top___024root___eval_initial(&(vlSymsp->TOP));
        Vsrc_top___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vsrc_top___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vsrc_top::eventsPending() { return false; }

uint64_t Vsrc_top::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vsrc_top::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vsrc_top___024root___eval_final(Vsrc_top___024root* vlSelf);

VL_ATTR_COLD void Vsrc_top::final() {
    Vsrc_top___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vsrc_top::hierName() const { return vlSymsp->name(); }
const char* Vsrc_top::modelName() const { return "Vsrc_top"; }
unsigned Vsrc_top::threads() const { return 1; }
void Vsrc_top::prepareClone() const { contextp()->prepareClone(); }
void Vsrc_top::atClone() const {
    contextp()->threadPoolpOnClone();
}
std::unique_ptr<VerilatedTraceConfig> Vsrc_top::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void Vsrc_top___024root__trace_decl_types(VerilatedVcd* tracep);

void Vsrc_top___024root__trace_init_top(Vsrc_top___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vsrc_top___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vsrc_top___024root*>(voidSelf);
    Vsrc_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->pushPrefix(std::string{vlSymsp->name()}, VerilatedTracePrefixType::SCOPE_MODULE);
    Vsrc_top___024root__trace_decl_types(tracep);
    Vsrc_top___024root__trace_init_top(vlSelf, tracep);
    tracep->popPrefix();
}

VL_ATTR_COLD void Vsrc_top___024root__trace_register(Vsrc_top___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vsrc_top::trace(VerilatedVcdC* tfp, int levels, int options) {
    if (tfp->isOpen()) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'Vsrc_top::trace()' shall not be called after 'VerilatedVcdC::open()'.");
    }
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addModel(this);
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    Vsrc_top___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
