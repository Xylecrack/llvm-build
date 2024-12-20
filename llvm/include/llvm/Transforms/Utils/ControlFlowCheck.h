#ifndef LLVM_TRANSFORMS_UTILS_CONTROLFLOWCHECK_H
#define LLVM_TRANSFORMS_UTILS_CONTROLFLOWCHECK_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class ControlFlowCheck : public PassInfoMixin<ControlFlowCheck> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};
void addControlFlowChecks(Function &F);

} // namespace llvm

#endif // LLVM_TRANSFORMS_UTILS_CONTROLFLOWCHECK_H