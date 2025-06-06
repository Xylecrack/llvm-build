//===- XtensaInstPrinter.h - Convert Xtensa MCInst to asm syntax -*- C++ -*-==//
//
//                     The LLVM Compiler Infrastructure
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This class prints an Xtensa MCInst to a .s file.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_XTENSA_MCTARGETDESC_XTENSAINSTPRINTER_H
#define LLVM_LIB_TARGET_XTENSA_MCTARGETDESC_XTENSAINSTPRINTER_H

#include "llvm/MC/MCInstPrinter.h"
#include "llvm/Support/Compiler.h"

namespace llvm {
class MCOperand;

class XtensaInstPrinter : public MCInstPrinter {
public:
  XtensaInstPrinter(const MCAsmInfo &MAI, const MCInstrInfo &MII,
                    const MCRegisterInfo &MRI)
      : MCInstPrinter(MAI, MII, MRI) {}

  // Automatically generated by tblgen.
  std::pair<const char *, uint64_t>
  getMnemonic(const MCInst &MI) const override;
  void printInstruction(const MCInst *MI, uint64_t Address, raw_ostream &O);
  static const char *getRegisterName(MCRegister Reg);

  // Print the given operand.
  static void printOperand(const MCOperand &MO, raw_ostream &O);

  // Override MCInstPrinter.
  void printRegName(raw_ostream &O, MCRegister Reg) override;
  void printInst(const MCInst *MI, uint64_t Address, StringRef Annot,
                 const MCSubtargetInfo &STI, raw_ostream &O) override;

private:
  // Print various types of operand.
  void printOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printMemOperand(const MCInst *MI, int OpNUm, raw_ostream &O);
  void printBranchTarget(const MCInst *MI, int OpNum, raw_ostream &O);
  void printJumpTarget(const MCInst *MI, int OpNum, raw_ostream &O);
  void printCallOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printL32RTarget(const MCInst *MI, int OpNum, raw_ostream &O);

  void printImm8_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printImm8_sh8_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printImm12_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printImm12m_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printUimm4_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printUimm5_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printShimm1_31_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printImm1_16_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printOffset8m8_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printOffset8m16_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printOffset8m32_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printOffset4m32_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printB4const_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
  void printB4constu_AsmOperand(const MCInst *MI, int OpNum, raw_ostream &O);
};
} // end namespace llvm

#endif /* LLVM_LIB_TARGET_XTENSA_MCTARGETDESC_XTENSAINSTPRINTER_H */
