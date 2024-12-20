#include "llvm/Transforms/Utils/ControlFlowCheck.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include <unordered_map>

using namespace llvm;

// Define the function
void addControlFlowChecks(Function &F) {
  int signatureCounter = 0;
  std::unordered_map<BasicBlock *, int> blockSignatures;
  std::unordered_map<BasicBlock *, int> blockSignaturesDiff;

  // Create an i32 type for signature operations
  LLVMContext &Context = F.getContext();
  IntegerType *Int32Ty = Type::getInt32Ty(Context);

  // Insert a signature variable at the function entry block
  IRBuilder<> entryBuilder(&F.getEntryBlock(), F.getEntryBlock().begin());
  AllocaInst *signatureVar =
      entryBuilder.CreateAlloca(Int32Ty, nullptr, "signature");
  entryBuilder.CreateStore(ConstantInt::get(Int32Ty, 0), signatureVar);

  // Assign unique signatures to basic blocks
  for (BasicBlock &BB : F) {
    blockSignatures[&BB] = signatureCounter++;
  }

  for (BasicBlock &BB : F) {
    IRBuilder<> builder(&BB, BB.begin());

    // Load the current runtime signature
    Value *currentSignature = builder.CreateLoad(Int32Ty, signatureVar);

    // Update signature for each successor
    if (auto *terminator = BB.getTerminator()) {
      for (unsigned i = 0; i < terminator->getNumSuccessors(); ++i) {
        BasicBlock *nextBB = terminator->getSuccessor(i);

        // Compute the signature difference
        int diff = blockSignatures[&BB] ^ blockSignatures[nextBB];
        blockSignaturesDiff[nextBB] = diff;

        // Insert runtime signature calculation
        Value *sigDiff = builder.getInt32(diff);
        Value *updatedSignature = builder.CreateXor(currentSignature, sigDiff);

        // Store the updated signature
        builder.CreateStore(updatedSignature, signatureVar);

        // At the beginning of the successor block, add a signature check
        IRBuilder<> succBuilder(nextBB, nextBB->begin());
        Value *loadedSignature = succBuilder.CreateLoad(Int32Ty, signatureVar);
        Value *expectedSignature =
            succBuilder.getInt32(blockSignatures[nextBB]);
        Value *cmp =
            succBuilder.CreateICmpNE(loadedSignature, expectedSignature);
      }
    }
  }
}
