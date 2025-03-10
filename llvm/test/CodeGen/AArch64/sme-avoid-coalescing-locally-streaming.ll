; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mattr=+sme -stop-after=finalize-isel < %s | FileCheck %s --check-prefix=CHECK-COALESCER-BARRIER
; RUN: llc -mattr=+sme -stop-after=virtregrewriter < %s | FileCheck %s --check-prefix=CHECK-REGALLOC

target triple = "aarch64"

define void @dont_coalesce_args(<2 x i64> %a) "aarch64_pstate_sm_body" nounwind {
  ; CHECK-COALESCER-BARRIER-LABEL: name: dont_coalesce_args
  ; CHECK-COALESCER-BARRIER: bb.0 (%ir-block.0):
  ; CHECK-COALESCER-BARRIER-NEXT:   liveins: $q0
  ; CHECK-COALESCER-BARRIER-NEXT: {{  $}}
  ; CHECK-COALESCER-BARRIER-NEXT:   [[COPY:%[0-9]+]]:fpr128 = COPY $q0
  ; CHECK-COALESCER-BARRIER-NEXT:   [[COALESCER_BARRIER_FPR128_:%[0-9]+]]:fpr128 = COALESCER_BARRIER_FPR128 [[COPY]]
  ; CHECK-COALESCER-BARRIER-NEXT:   MSRpstatesvcrImm1 1, 1, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit $vg, implicit-def $vg
  ; CHECK-COALESCER-BARRIER-NEXT:   [[DEF:%[0-9]+]]:zpr = IMPLICIT_DEF
  ; CHECK-COALESCER-BARRIER-NEXT:   [[INSERT_SUBREG:%[0-9]+]]:zpr = INSERT_SUBREG [[DEF]], [[COALESCER_BARRIER_FPR128_]], %subreg.zsub
  ; CHECK-COALESCER-BARRIER-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-COALESCER-BARRIER-NEXT:   $z0 = COPY [[INSERT_SUBREG]]
  ; CHECK-COALESCER-BARRIER-NEXT:   BL @scalable_args, csr_aarch64_sve_aapcs, implicit-def dead $lr, implicit $sp, implicit $z0, implicit-def $sp
  ; CHECK-COALESCER-BARRIER-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-COALESCER-BARRIER-NEXT:   MSRpstatesvcrImm1 1, 0, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit $vg, implicit-def $vg
  ; CHECK-COALESCER-BARRIER-NEXT:   RET_ReallyLR
  ;
  ; CHECK-REGALLOC-LABEL: name: dont_coalesce_args
  ; CHECK-REGALLOC: bb.0 (%ir-block.0):
  ; CHECK-REGALLOC-NEXT:   liveins: $q0
  ; CHECK-REGALLOC-NEXT: {{  $}}
  ; CHECK-REGALLOC-NEXT:   STRQui $q0, %stack.0, 0 :: (store (s128) into %stack.0)
  ; CHECK-REGALLOC-NEXT:   MSRpstatesvcrImm1 1, 1, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit $vg, implicit-def $vg
  ; CHECK-REGALLOC-NEXT:   renamable $q0 = LDRQui %stack.0, 0 :: (load (s128) from %stack.0)
  ; CHECK-REGALLOC-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-REGALLOC-NEXT:   BL @scalable_args, csr_aarch64_sve_aapcs, implicit-def dead $lr, implicit $sp, implicit $z0, implicit-def $sp
  ; CHECK-REGALLOC-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-REGALLOC-NEXT:   MSRpstatesvcrImm1 1, 0, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit $vg, implicit-def $vg
  ; CHECK-REGALLOC-NEXT:   RET_ReallyLR
  %sa = call <vscale x 2 x i64> @llvm.vector.insert.nxv2i64.v2i64(<vscale x 2 x i64> poison, <2 x i64> %a, i64 0)
  call void @scalable_args(<vscale x 2 x i64> %sa)
  ret void
}

define <2 x i64> @dont_coalesce_res() "aarch64_pstate_sm_body" nounwind {
  ; CHECK-COALESCER-BARRIER-LABEL: name: dont_coalesce_res
  ; CHECK-COALESCER-BARRIER: bb.0 (%ir-block.0):
  ; CHECK-COALESCER-BARRIER-NEXT:   MSRpstatesvcrImm1 1, 1, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit $vg, implicit-def $vg
  ; CHECK-COALESCER-BARRIER-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-COALESCER-BARRIER-NEXT:   BL @scalable_res, csr_aarch64_sve_aapcs, implicit-def dead $lr, implicit $sp, implicit-def $sp, implicit-def $z0
  ; CHECK-COALESCER-BARRIER-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-COALESCER-BARRIER-NEXT:   [[COPY:%[0-9]+]]:zpr = COPY $z0
  ; CHECK-COALESCER-BARRIER-NEXT:   [[COPY1:%[0-9]+]]:fpr128 = COPY [[COPY]].zsub
  ; CHECK-COALESCER-BARRIER-NEXT:   [[COALESCER_BARRIER_FPR128_:%[0-9]+]]:fpr128 = COALESCER_BARRIER_FPR128 [[COPY1]]
  ; CHECK-COALESCER-BARRIER-NEXT:   MSRpstatesvcrImm1 1, 0, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit-def $q0, implicit $vg, implicit-def $vg
  ; CHECK-COALESCER-BARRIER-NEXT:   $q0 = COPY [[COALESCER_BARRIER_FPR128_]]
  ; CHECK-COALESCER-BARRIER-NEXT:   RET_ReallyLR implicit $q0
  ;
  ; CHECK-REGALLOC-LABEL: name: dont_coalesce_res
  ; CHECK-REGALLOC: bb.0 (%ir-block.0):
  ; CHECK-REGALLOC-NEXT:   MSRpstatesvcrImm1 1, 1, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit $vg, implicit-def $vg
  ; CHECK-REGALLOC-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-REGALLOC-NEXT:   BL @scalable_res, csr_aarch64_sve_aapcs, implicit-def dead $lr, implicit $sp, implicit-def $sp, implicit-def $z0
  ; CHECK-REGALLOC-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-REGALLOC-NEXT:   STRQui killed renamable $q0, %stack.0, 0 :: (store (s128) into %stack.0)
  ; CHECK-REGALLOC-NEXT:   MSRpstatesvcrImm1 1, 0, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit-def dead $q0, implicit $vg, implicit-def $vg
  ; CHECK-REGALLOC-NEXT:   $q0 = LDRQui %stack.0, 0 :: (load (s128) from %stack.0)
  ; CHECK-REGALLOC-NEXT:   RET_ReallyLR implicit $q0
  %sa = call <vscale x 2 x i64> @scalable_res()
  %res = call <2 x i64> @llvm.vector.extract.v2i64.nxv2i64(<vscale x 2 x i64> %sa, i64 0)
  ret <2 x i64> %res
}

define <2 x i64> @dont_coalesce_arg_that_is_also_res(<2 x i64> %a) "aarch64_pstate_sm_body" nounwind {
  ; CHECK-COALESCER-BARRIER-LABEL: name: dont_coalesce_arg_that_is_also_res
  ; CHECK-COALESCER-BARRIER: bb.0 (%ir-block.0):
  ; CHECK-COALESCER-BARRIER-NEXT:   liveins: $q0
  ; CHECK-COALESCER-BARRIER-NEXT: {{  $}}
  ; CHECK-COALESCER-BARRIER-NEXT:   [[COPY:%[0-9]+]]:fpr128 = COPY $q0
  ; CHECK-COALESCER-BARRIER-NEXT:   [[COALESCER_BARRIER_FPR128_:%[0-9]+]]:fpr128 = COALESCER_BARRIER_FPR128 [[COPY]]
  ; CHECK-COALESCER-BARRIER-NEXT:   MSRpstatesvcrImm1 1, 1, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit $vg, implicit-def $vg
  ; CHECK-COALESCER-BARRIER-NEXT:   [[DEF:%[0-9]+]]:zpr = IMPLICIT_DEF
  ; CHECK-COALESCER-BARRIER-NEXT:   [[INSERT_SUBREG:%[0-9]+]]:zpr = INSERT_SUBREG [[DEF]], [[COALESCER_BARRIER_FPR128_]], %subreg.zsub
  ; CHECK-COALESCER-BARRIER-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-COALESCER-BARRIER-NEXT:   $z0 = COPY [[INSERT_SUBREG]]
  ; CHECK-COALESCER-BARRIER-NEXT:   BL @scalable_args, csr_aarch64_sve_aapcs, implicit-def dead $lr, implicit $sp, implicit $z0, implicit-def $sp
  ; CHECK-COALESCER-BARRIER-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-COALESCER-BARRIER-NEXT:   [[COALESCER_BARRIER_FPR128_1:%[0-9]+]]:fpr128 = COALESCER_BARRIER_FPR128 [[COALESCER_BARRIER_FPR128_]]
  ; CHECK-COALESCER-BARRIER-NEXT:   MSRpstatesvcrImm1 1, 0, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit-def $q0, implicit $vg, implicit-def $vg
  ; CHECK-COALESCER-BARRIER-NEXT:   $q0 = COPY [[COALESCER_BARRIER_FPR128_1]]
  ; CHECK-COALESCER-BARRIER-NEXT:   RET_ReallyLR implicit $q0
  ;
  ; CHECK-REGALLOC-LABEL: name: dont_coalesce_arg_that_is_also_res
  ; CHECK-REGALLOC: bb.0 (%ir-block.0):
  ; CHECK-REGALLOC-NEXT:   liveins: $q0
  ; CHECK-REGALLOC-NEXT: {{  $}}
  ; CHECK-REGALLOC-NEXT:   STRQui $q0, %stack.0, 0 :: (store (s128) into %stack.0)
  ; CHECK-REGALLOC-NEXT:   MSRpstatesvcrImm1 1, 1, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit $vg, implicit-def $vg
  ; CHECK-REGALLOC-NEXT:   renamable $q0 = LDRQui %stack.0, 0 :: (load (s128) from %stack.0)
  ; CHECK-REGALLOC-NEXT:   ADJCALLSTACKDOWN 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-REGALLOC-NEXT:   BL @scalable_args, csr_aarch64_sve_aapcs, implicit-def dead $lr, implicit $sp, implicit $z0, implicit-def $sp
  ; CHECK-REGALLOC-NEXT:   ADJCALLSTACKUP 0, 0, implicit-def dead $sp, implicit $sp
  ; CHECK-REGALLOC-NEXT:   MSRpstatesvcrImm1 1, 0, csr_aarch64_smstartstop, implicit-def dead $nzcv, implicit-def dead $q0, implicit $vg, implicit-def $vg
  ; CHECK-REGALLOC-NEXT:   $q0 = LDRQui %stack.0, 0 :: (load (s128) from %stack.0)
  ; CHECK-REGALLOC-NEXT:   RET_ReallyLR implicit $q0
  %sa = call <vscale x 2 x i64> @llvm.vector.insert.nxv2i64.v2i64(<vscale x 2 x i64> poison, <2 x i64> %a, i64 0)
  call void @scalable_args(<vscale x 2 x i64> %sa)
  ret <2 x i64> %a
}

declare void @scalable_args(<vscale x 2 x i64>) "aarch64_pstate_sm_enabled"
declare <vscale x 2 x i64> @llvm.vector.insert.nxv2i64.v2i64(<vscale x 2 x i64>, <2 x i64>, i64)

declare <vscale x 2 x i64> @scalable_res() "aarch64_pstate_sm_enabled"
declare <2 x i64> @llvm.vector.extract.v2i64.nxv2i64(<vscale x 2 x i64>, i64)
