; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64 -mattr=+v8.2a,+fullfp16  | FileCheck %s

declare half @llvm.aarch64.neon.fmulx.f16(half, half)
declare <4 x half> @llvm.aarch64.neon.fmulx.v4f16(<4 x half>, <4 x half>)
declare <8 x half> @llvm.aarch64.neon.fmulx.v8f16(<8 x half>, <8 x half>)
declare <4 x half> @llvm.fma.v4f16(<4 x half>, <4 x half>, <4 x half>)
declare <8 x half> @llvm.fma.v8f16(<8 x half>, <8 x half>, <8 x half>)
declare half @llvm.fma.f16(half, half, half) #1

define <4 x half> @t_vfma_lane_f16(<4 x half> %a, <4 x half> %b, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfma_lane_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla v0.4h, v1.4h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %lane1 = shufflevector <4 x half> %c, <4 x half> undef, <4 x i32> zeroinitializer
  %fmla3 = tail call <4 x half> @llvm.fma.v4f16(<4 x half> %b, <4 x half> %lane1, <4 x half> %a)
  ret <4 x half> %fmla3
}

define <8 x half> @t_vfmaq_lane_f16(<8 x half> %a, <8 x half> %b, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmaq_lane_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla v0.8h, v1.8h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %lane1 = shufflevector <4 x half> %c, <4 x half> undef, <8 x i32> zeroinitializer
  %fmla3 = tail call <8 x half> @llvm.fma.v8f16(<8 x half> %b, <8 x half> %lane1, <8 x half> %a)
  ret <8 x half> %fmla3
}

define <4 x half> @t_vfma_laneq_f16(<4 x half> %a, <4 x half> %b, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfma_laneq_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla v0.4h, v1.4h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %lane1 = shufflevector <8 x half> %c, <8 x half> undef, <4 x i32> zeroinitializer
  %0 = tail call <4 x half> @llvm.fma.v4f16(<4 x half> %lane1, <4 x half> %b, <4 x half> %a)
  ret <4 x half> %0
}

define <8 x half> @t_vfmaq_laneq_f16(<8 x half> %a, <8 x half> %b, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmaq_laneq_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla v0.8h, v1.8h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %lane1 = shufflevector <8 x half> %c, <8 x half> undef, <8 x i32> zeroinitializer
  %0 = tail call <8 x half> @llvm.fma.v8f16(<8 x half> %lane1, <8 x half> %b, <8 x half> %a)
  ret <8 x half> %0
}

define <4 x half> @t_vfma_n_f16(<4 x half> %a, <4 x half> %b, half %c) {
; CHECK-LABEL: t_vfma_n_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla v0.4h, v1.4h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %vecinit = insertelement <4 x half> undef, half %c, i32 0
  %vecinit3 = shufflevector <4 x half> %vecinit, <4 x half> undef, <4 x i32> zeroinitializer
  %0 = tail call <4 x half> @llvm.fma.v4f16(<4 x half> %b, <4 x half> %vecinit3, <4 x half> %a) #4
  ret <4 x half> %0
}

define <8 x half> @t_vfmaq_n_f16(<8 x half> %a, <8 x half> %b, half %c) {
; CHECK-LABEL: t_vfmaq_n_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla v0.8h, v1.8h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %vecinit = insertelement <8 x half> undef, half %c, i32 0
  %vecinit7 = shufflevector <8 x half> %vecinit, <8 x half> undef, <8 x i32> zeroinitializer
  %0 = tail call <8 x half> @llvm.fma.v8f16(<8 x half> %b, <8 x half> %vecinit7, <8 x half> %a) #4
  ret <8 x half> %0
}

define half @t_vfmah_lane_f16_0(half %a, half %b, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmah_lane_f16_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmadd h0, h1, h2, h0
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <4 x half> %c, i32 0
  %0 = tail call half @llvm.fma.f16(half %b, half %extract, half %a)
  ret half %0
}

define half @t_vfmah_lane_f16_0_swap(half %a, half %b, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmah_lane_f16_0_swap:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmadd h0, h2, h1, h0
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <4 x half> %c, i32 0
  %0 = tail call half @llvm.fma.f16(half %extract, half %b, half %a)
  ret half %0
}

define half @t_vfmah_lane_f16_3(half %a, half %b, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmah_lane_f16_3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla h0, h1, v2.h[3]
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <4 x half> %c, i32 3
  %0 = tail call half @llvm.fma.f16(half %b, half %extract, half %a)
  ret half %0
}

define half @t_vfmah_lane_f16_3_0(half %a, <4 x half> %c) {
; CHECK-LABEL: t_vfmah_lane_f16_3_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla h0, h1, v1.h[3]
; CHECK-NEXT:    ret
entry:
  %b = extractelement <4 x half> %c, i32 0
  %extract = extractelement <4 x half> %c, i32 3
  %0 = tail call half @llvm.fma.f16(half %b, half %extract, half %a)
  ret half %0
}

define half @t_vfmah_lane_f16_0_0(half %a, <4 x half> %b, <4 x half> %c) {
; CHECK-LABEL: t_vfmah_lane_f16_0_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmadd h0, h1, h2, h0
; CHECK-NEXT:    ret
entry:
  %b0 = extractelement <4 x half> %b, i32 0
  %c0 = extractelement <4 x half> %c, i32 0
  %0 = tail call half @llvm.fma.f16(half %b0, half %c0, half %a)
  ret half %0
}

define half @t_vfmah_laneq_f16_0(half %a, half %b, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmah_laneq_f16_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmadd h0, h1, h2, h0
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <8 x half> %c, i32 0
  %0 = tail call half @llvm.fma.f16(half %b, half %extract, half %a)
  ret half %0
}

define half @t_vfmah_laneq_f16_0_swap(half %a, half %b, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmah_laneq_f16_0_swap:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmadd h0, h2, h1, h0
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <8 x half> %c, i32 0
  %0 = tail call half @llvm.fma.f16(half %extract, half %b, half %a)
  ret half %0
}

define half @t_vfmah_laneq_f16_7(half %a, half %b, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmah_laneq_f16_7:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla h0, h1, v2.h[7]
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <8 x half> %c, i32 7
  %0 = tail call half @llvm.fma.f16(half %b, half %extract, half %a)
  ret half %0
}

define <4 x half> @t_vfms_lane_f16(<4 x half> %a, <4 x half> %b, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfms_lane_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls v0.4h, v1.4h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %sub = fsub <4 x half> <half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000>, %b
  %lane1 = shufflevector <4 x half> %c, <4 x half> undef, <4 x i32> zeroinitializer
  %fmla3 = tail call <4 x half> @llvm.fma.v4f16(<4 x half> %sub, <4 x half> %lane1, <4 x half> %a)
  ret <4 x half> %fmla3
}

define <8 x half> @t_vfmsq_lane_f16(<8 x half> %a, <8 x half> %b, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmsq_lane_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls v0.8h, v1.8h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %sub = fsub <8 x half> <half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000>, %b
  %lane1 = shufflevector <4 x half> %c, <4 x half> undef, <8 x i32> zeroinitializer
  %fmla3 = tail call <8 x half> @llvm.fma.v8f16(<8 x half> %sub, <8 x half> %lane1, <8 x half> %a)
  ret <8 x half> %fmla3
}

define <4 x half> @t_vfms_laneq_f16(<4 x half> %a, <4 x half> %b, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfms_laneq_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls v0.4h, v1.4h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %sub = fsub <4 x half> <half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000>, %b
  %lane1 = shufflevector <8 x half> %c, <8 x half> undef, <4 x i32> zeroinitializer
  %0 = tail call <4 x half> @llvm.fma.v4f16(<4 x half> %lane1, <4 x half> %sub, <4 x half> %a)
  ret <4 x half> %0
}

define <8 x half> @t_vfmsq_laneq_f16(<8 x half> %a, <8 x half> %b, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmsq_laneq_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls v0.8h, v1.8h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %sub = fsub <8 x half> <half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000>, %b
  %lane1 = shufflevector <8 x half> %c, <8 x half> undef, <8 x i32> zeroinitializer
  %0 = tail call <8 x half> @llvm.fma.v8f16(<8 x half> %lane1, <8 x half> %sub, <8 x half> %a)
  ret <8 x half> %0
}

define <4 x half> @t_vfms_n_f16(<4 x half> %a, <4 x half> %b, half %c) {
; CHECK-LABEL: t_vfms_n_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls v0.4h, v1.4h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %sub = fsub <4 x half> <half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000>, %b
  %vecinit = insertelement <4 x half> undef, half %c, i32 0
  %vecinit3 = shufflevector <4 x half> %vecinit, <4 x half> undef, <4 x i32> zeroinitializer
  %0 = tail call <4 x half> @llvm.fma.v4f16(<4 x half> %sub, <4 x half> %vecinit3, <4 x half> %a) #4
  ret <4 x half> %0
}

define <8 x half> @t_vfmsq_n_f16(<8 x half> %a, <8 x half> %b, half %c) {
; CHECK-LABEL: t_vfmsq_n_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls v0.8h, v1.8h, v2.h[0]
; CHECK-NEXT:    ret
entry:
  %sub = fsub <8 x half> <half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000, half 0xH8000>, %b
  %vecinit = insertelement <8 x half> undef, half %c, i32 0
  %vecinit7 = shufflevector <8 x half> %vecinit, <8 x half> undef, <8 x i32> zeroinitializer
  %0 = tail call <8 x half> @llvm.fma.v8f16(<8 x half> %sub, <8 x half> %vecinit7, <8 x half> %a) #4
  ret <8 x half> %0
}

define half @t_vfmsh_lane_f16_0(half %a, half %b, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmsh_lane_f16_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmsub h0, h2, h1, h0
; CHECK-NEXT:    ret
entry:
  %0 = fsub half 0xH8000, %b
  %extract = extractelement <4 x half> %c, i32 0
  %1 = tail call half @llvm.fma.f16(half %0, half %extract, half %a)
  ret half %1
}

define half @t_vfmsh_lane_f16_0_swap(half %a, half %b, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmsh_lane_f16_0_swap:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmsub h0, h2, h1, h0
; CHECK-NEXT:    ret
entry:
  %0 = fsub half 0xH8000, %b
  %extract = extractelement <4 x half> %c, i32 0
  %1 = tail call half @llvm.fma.f16(half %extract, half %0, half %a)
  ret half %1
}

define half @t_vfmsh_lane_f16_3(half %a, half %b, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmsh_lane_f16_3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls h0, h1, v2.h[3]
; CHECK-NEXT:    ret
entry:
  %0 = fsub half 0xH8000, %b
  %extract = extractelement <4 x half> %c, i32 3
  %1 = tail call half @llvm.fma.f16(half %0, half %extract, half %a)
  ret half %1
}

define half @t_vfmsh_laneq_f16_0(half %a, half %b, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmsh_laneq_f16_0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmsub h0, h2, h1, h0
; CHECK-NEXT:    ret
entry:
  %0 = fsub half 0xH8000, %b
  %extract = extractelement <8 x half> %c, i32 0
  %1 = tail call half @llvm.fma.f16(half %0, half %extract, half %a)
  ret half %1
}

define half @t_vfmsh_lane_f16_0_3(half %a, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmsh_lane_f16_0_3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls h0, h1, v1.h[3]
; CHECK-NEXT:    ret
entry:
  %b = extractelement <4 x half> %c, i32 0
  %0 = fsub half 0xH8000, %b
  %extract = extractelement <4 x half> %c, i32 3
  %1 = tail call half @llvm.fma.f16(half %0, half %extract, half %a)
  ret half %1
}

define half @t_vfmsh_laneq_f16_0_swap(half %a, half %b, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmsh_laneq_f16_0_swap:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmsub h0, h2, h1, h0
; CHECK-NEXT:    ret
entry:
  %0 = fsub half 0xH8000, %b
  %extract = extractelement <8 x half> %c, i32 0
  %1 = tail call half @llvm.fma.f16(half %extract, half %0, half %a)
  ret half %1
}

define half @t_vfmsh_laneq_f16_7(half %a, half %b, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vfmsh_laneq_f16_7:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls h0, h1, v2.h[7]
; CHECK-NEXT:    ret
entry:
  %0 = fsub half 0xH8000, %b
  %extract = extractelement <8 x half> %c, i32 7
  %1 = tail call half @llvm.fma.f16(half %0, half %extract, half %a)
  ret half %1
}

define <4 x half> @t_vmul_laneq_f16(<4 x half> %a, <8 x half> %b, i32 %lane) {
; CHECK-LABEL: t_vmul_laneq_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul v0.4h, v0.4h, v1.h[0]
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <8 x half> %b, <8 x half> undef, <4 x i32> zeroinitializer
  %mul = fmul <4 x half> %shuffle, %a
  ret <4 x half> %mul
}

define <8 x half> @t_vmulq_laneq_f16(<8 x half> %a, <8 x half> %b, i32 %lane) {
; CHECK-LABEL: t_vmulq_laneq_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul v0.8h, v0.8h, v1.h[0]
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <8 x half> %b, <8 x half> undef, <8 x i32> zeroinitializer
  %mul = fmul <8 x half> %shuffle, %a
  ret <8 x half> %mul
}

define half @t_vmulh_lane0_f16(half %a, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vmulh_lane0_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul h0, h0, h1
; CHECK-NEXT:    ret
entry:
  %0 = extractelement <4 x half> %c, i32 0
  %1 = fmul half %0, %a
  ret half %1
}

define half @t_vmulh_lane3_f16(half %a, <4 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vmulh_lane3_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul h0, h0, v1.h[3]
; CHECK-NEXT:    ret
entry:
  %0 = extractelement <4 x half> %c, i32 3
  %1 = fmul half %0, %a
  ret half %1
}

define half @t_vmulh_laneq0_f16(half %a, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vmulh_laneq0_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul h0, h0, h1
; CHECK-NEXT:    ret
entry:
  %0 = extractelement <8 x half> %c, i32 0
  %1 = fmul half %0, %a
  ret half %1
}

define half @t_vmulh_laneq7_f16(half %a, <8 x half> %c, i32 %lane) {
; CHECK-LABEL: t_vmulh_laneq7_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul h0, h0, v1.h[7]
; CHECK-NEXT:    ret
entry:
  %0 = extractelement <8 x half> %c, i32 7
  %1 = fmul half %0, %a
  ret half %1
}

define half @t_vmulx_f16(half %a, half %b) {
; CHECK-LABEL: t_vmulx_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmulx h0, h0, h1
; CHECK-NEXT:    ret
entry:
  %fmulx.i = tail call half @llvm.aarch64.neon.fmulx.f16(half %a, half %b)
  ret half %fmulx.i
}

define half @t_vmulxh_lane0_f16(half %a, <4 x half> %b) {
; CHECK-LABEL: t_vmulxh_lane0_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmulx h0, h0, h1
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <4 x half> %b, i32 0
  %fmulx.i = tail call half @llvm.aarch64.neon.fmulx.f16(half %a, half %extract)
  ret half %fmulx.i
}

define half @t_vmulxh_lane3_f16(half %a, <4 x half> %b, i32 %lane) {
; CHECK-LABEL: t_vmulxh_lane3_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmulx h0, h0, v1.h[3]
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <4 x half> %b, i32 3
  %fmulx.i = tail call half @llvm.aarch64.neon.fmulx.f16(half %a, half %extract)
  ret half %fmulx.i
}

define <4 x half> @t_vmulx_lane_f16(<4 x half> %a, <4 x half> %b, i32 %lane) {
; CHECK-LABEL: t_vmulx_lane_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmulx v0.4h, v0.4h, v1.h[0]
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <4 x half> %b, <4 x half> undef, <4 x i32> zeroinitializer
  %vmulx2.i = tail call <4 x half> @llvm.aarch64.neon.fmulx.v4f16(<4 x half> %a, <4 x half> %shuffle) #4
  ret <4 x half> %vmulx2.i
}

define <8 x half> @t_vmulxq_lane_f16(<8 x half> %a, <4 x half> %b, i32 %lane) {
; CHECK-LABEL: t_vmulxq_lane_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmulx v0.8h, v0.8h, v1.h[0]
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <4 x half> %b, <4 x half> undef, <8 x i32> zeroinitializer
  %vmulx2.i = tail call <8 x half> @llvm.aarch64.neon.fmulx.v8f16(<8 x half> %a, <8 x half> %shuffle) #4
  ret <8 x half> %vmulx2.i
}

define <4 x half> @t_vmulx_laneq_f16(<4 x half> %a, <8 x half> %b, i32 %lane) {
; CHECK-LABEL: t_vmulx_laneq_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmulx v0.4h, v0.4h, v1.h[0]
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <8 x half> %b, <8 x half> undef, <4 x i32> zeroinitializer
  %vmulx2.i = tail call <4 x half> @llvm.aarch64.neon.fmulx.v4f16(<4 x half> %a, <4 x half> %shuffle) #4
  ret <4 x half> %vmulx2.i
}

define <8 x half> @t_vmulxq_laneq_f16(<8 x half> %a, <8 x half> %b, i32 %lane) {
; CHECK-LABEL: t_vmulxq_laneq_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmulx v0.8h, v0.8h, v1.h[0]
; CHECK-NEXT:    ret
entry:
  %shuffle = shufflevector <8 x half> %b, <8 x half> undef, <8 x i32> zeroinitializer
  %vmulx2.i = tail call <8 x half> @llvm.aarch64.neon.fmulx.v8f16(<8 x half> %a, <8 x half> %shuffle) #4
  ret <8 x half> %vmulx2.i
}

define half @t_vmulxh_laneq0_f16(half %a, <8 x half> %b) {
; CHECK-LABEL: t_vmulxh_laneq0_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmulx h0, h0, h1
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <8 x half> %b, i32 0
  %fmulx.i = tail call half @llvm.aarch64.neon.fmulx.f16(half %a, half %extract)
  ret half %fmulx.i
}

define half @t_vmulxh_laneq7_f16(half %a, <8 x half> %b, i32 %lane) {
; CHECK-LABEL: t_vmulxh_laneq7_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmulx h0, h0, v1.h[7]
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <8 x half> %b, i32 7
  %fmulx.i = tail call half @llvm.aarch64.neon.fmulx.f16(half %a, half %extract)
  ret half %fmulx.i
}

define <4 x half> @t_vmulx_n_f16(<4 x half> %a, half %c) {
; CHECK-LABEL: t_vmulx_n_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    dup v1.4h, v1.h[0]
; CHECK-NEXT:    fmulx v0.4h, v0.4h, v1.4h
; CHECK-NEXT:    ret
entry:
  %vecinit = insertelement <4 x half> undef, half %c, i32 0
  %vecinit3 = shufflevector <4 x half> %vecinit, <4 x half> undef, <4 x i32> zeroinitializer
  %vmulx2.i = tail call <4 x half> @llvm.aarch64.neon.fmulx.v4f16(<4 x half> %a, <4 x half> %vecinit3) #4
  ret <4 x half> %vmulx2.i
}

define <8 x half> @t_vmulxq_n_f16(<8 x half> %a, half %c) {
; CHECK-LABEL: t_vmulxq_n_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    dup v1.8h, v1.h[0]
; CHECK-NEXT:    fmulx v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
entry:
  %vecinit = insertelement <8 x half> undef, half %c, i32 0
  %vecinit7 = shufflevector <8 x half> %vecinit, <8 x half> undef, <8 x i32> zeroinitializer
  %vmulx2.i = tail call <8 x half> @llvm.aarch64.neon.fmulx.v8f16(<8 x half> %a, <8 x half> %vecinit7) #4
  ret <8 x half> %vmulx2.i
}

define half @t_vfmah_lane3_f16(half %a, half %b, <4 x half> %c) {
; CHECK-LABEL: t_vfmah_lane3_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla h0, h1, v2.h[3]
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <4 x half> %c, i32 3
  %0 = tail call half @llvm.fma.f16(half %b, half %extract, half %a)
  ret half %0
}

define half @t_vfmah_laneq7_f16(half %a, half %b, <8 x half> %c) {
; CHECK-LABEL: t_vfmah_laneq7_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmla h0, h1, v2.h[7]
; CHECK-NEXT:    ret
entry:
  %extract = extractelement <8 x half> %c, i32 7
  %0 = tail call half @llvm.fma.f16(half %b, half %extract, half %a)
  ret half %0
}

define half @t_vfmsh_lane3_f16(half %a, half %b, <4 x half> %c) {
; CHECK-LABEL: t_vfmsh_lane3_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls h0, h1, v2.h[3]
; CHECK-NEXT:    ret
entry:
  %0 = fsub half 0xH8000, %b
  %extract = extractelement <4 x half> %c, i32 3
  %1 = tail call half @llvm.fma.f16(half %0, half %extract, half %a)
  ret half %1
}

define half @t_vfmsh_laneq7_f16(half %a, half %b, <8 x half> %c) {
; CHECK-LABEL: t_vfmsh_laneq7_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmls h0, h1, v2.h[7]
; CHECK-NEXT:    ret
entry:
  %0 = fsub half 0xH8000, %b
  %extract = extractelement <8 x half> %c, i32 7
  %1 = tail call half @llvm.fma.f16(half %0, half %extract, half %a)
  ret half %1
}

define half @t_fadd_vfmah_f16(half %a, half %b, <4 x half> %c, <4 x half> %d) {
; CHECK-LABEL: t_fadd_vfmah_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fadd v2.4h, v2.4h, v3.4h
; CHECK-NEXT:    fmla h0, h1, v2.h[3]
; CHECK-NEXT:    ret
entry:
  %0 = fadd <4 x half> %c, %d
  %extract = extractelement <4 x half> %0, i32 3
  %1 = tail call half @llvm.fma.f16(half %b, half %extract, half %a)
  ret half %1
}

define half @test_fmulx_horizontal_f16(<2 x half> %v) {
; CHECK-LABEL: test_fmulx_horizontal_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmulx h0, h0, v0.h[1]
; CHECK-NEXT:    ret
entry:
  %0 = extractelement <2 x half> %v, i32 0
  %1 = extractelement <2 x half> %v, i32 1
  %2 = call half @llvm.aarch64.neon.fmulx.f16(half %0, half %1)
  ret half %2
}
