; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple aarch64-none-linux-gnu -mattr=+dotprod    < %s | FileCheck %s
; RUN: llc -mtriple aarch64-none-linux-gnu -mcpu=cortex-a65   < %s | FileCheck %s
; RUN: llc -mtriple aarch64-none-linux-gnu -mcpu=cortex-a65ae < %s | FileCheck %s
; RUN: llc -mtriple aarch64-none-linux-gnu -mcpu=neoverse-e1  < %s | FileCheck %s
; RUN: llc -mtriple aarch64-none-linux-gnu -mcpu=neoverse-n1  < %s | FileCheck %s
; RUN: llc -mtriple aarch64-none-linux-gnu -mcpu=neoverse-n2  < %s | FileCheck %s
; RUN: llc -mtriple aarch64-none-linux-gnu -mcpu=ampere1      < %s | FileCheck %s
; RUN: llc -mtriple aarch64-none-linux-gnu -mcpu=ampere1a     < %s | FileCheck %s
; RUN: llc -mtriple aarch64-none-linux-gnu -mcpu=ampere1b     < %s | FileCheck %s

declare <2 x i32> @llvm.aarch64.neon.udot.v2i32.v8i8(<2 x i32>, <8 x i8>, <8 x i8>)
declare <4 x i32> @llvm.aarch64.neon.udot.v4i32.v16i8(<4 x i32>, <16 x i8>, <16 x i8>)
declare <2 x i32> @llvm.aarch64.neon.sdot.v2i32.v8i8(<2 x i32>, <8 x i8>, <8 x i8>)
declare <4 x i32> @llvm.aarch64.neon.sdot.v4i32.v16i8(<4 x i32>, <16 x i8>, <16 x i8>)

define <2 x i32> @test_vdot_u32(<2 x i32> %a, <8 x i8> %b, <8 x i8> %c) #0 {
; CHECK-LABEL: test_vdot_u32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.2s, v1.8b, v2.8b
; CHECK-NEXT:    ret
entry:
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.udot.v2i32.v8i8(<2 x i32> %a, <8 x i8> %b, <8 x i8> %c) #2
  ret <2 x i32> %vdot1.i
}

define <4 x i32> @test_vdotq_u32(<4 x i32> %a, <16 x i8> %b, <16 x i8> %c) #0 {
; CHECK-LABEL: test_vdotq_u32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.4s, v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.udot.v4i32.v16i8(<4 x i32> %a, <16 x i8> %b, <16 x i8> %c) #2
  ret <4 x i32> %vdot1.i
}

define <2 x i32> @test_vdot_s32(<2 x i32> %a, <8 x i8> %b, <8 x i8> %c) #0 {
; CHECK-LABEL: test_vdot_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.2s, v1.8b, v2.8b
; CHECK-NEXT:    ret
entry:
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.sdot.v2i32.v8i8(<2 x i32> %a, <8 x i8> %b, <8 x i8> %c) #2
  ret <2 x i32> %vdot1.i
}

define <4 x i32> @test_vdotq_s32(<4 x i32> %a, <16 x i8> %b, <16 x i8> %c) #0 {
; CHECK-LABEL: test_vdotq_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.4s, v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.sdot.v4i32.v16i8(<4 x i32> %a, <16 x i8> %b, <16 x i8> %c) #2
  ret <4 x i32> %vdot1.i
}


define <2 x i32> @test_vdot_u32_zero(<2 x i32> %a, <8 x i8> %b, <8 x i8> %c) #0 {
; CHECK-LABEL: test_vdot_u32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.2s, v1.8b, v2.8b
; CHECK-NEXT:    ret
entry:
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.udot.v2i32.v8i8(<2 x i32> zeroinitializer, <8 x i8> %b, <8 x i8> %c) #2
  %ret = add <2 x i32> %vdot1.i, %a
  ret <2 x i32> %ret
}

define <4 x i32> @test_vdotq_u32_zero(<4 x i32> %a, <16 x i8> %b, <16 x i8> %c) #0 {
; CHECK-LABEL: test_vdotq_u32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.4s, v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.udot.v4i32.v16i8(<4 x i32> zeroinitializer, <16 x i8> %b, <16 x i8> %c) #2
  %ret = add <4 x i32> %vdot1.i, %a
  ret <4 x i32> %ret
}

define <2 x i32> @test_vdot_s32_zero(<2 x i32> %a, <8 x i8> %b, <8 x i8> %c) #0 {
; CHECK-LABEL: test_vdot_s32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.2s, v1.8b, v2.8b
; CHECK-NEXT:    ret
entry:
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.sdot.v2i32.v8i8(<2 x i32> zeroinitializer, <8 x i8> %b, <8 x i8> %c) #2
  %ret = add <2 x i32> %vdot1.i, %a
  ret <2 x i32> %ret
}

define <4 x i32> @test_vdotq_s32_zero(<4 x i32> %a, <16 x i8> %b, <16 x i8> %c) #0 {
; CHECK-LABEL: test_vdotq_s32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.4s, v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.sdot.v4i32.v16i8(<4 x i32> zeroinitializer, <16 x i8> %b, <16 x i8> %c) #2
  %ret = add <4 x i32> %vdot1.i, %a
  ret <4 x i32> %ret
}


define <2 x i32> @test_vdot_lane_u32(<2 x i32> %a, <8 x i8> %b, <8 x i8> %c) {
; CHECK-LABEL: test_vdot_lane_u32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.2s, v1.8b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <8 x i8> %c to <2 x i32>
  %shuffle = shufflevector <2 x i32> %.cast, <2 x i32> undef, <2 x i32> <i32 1, i32 1>
  %.cast5 = bitcast <2 x i32> %shuffle to <8 x i8>
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.udot.v2i32.v8i8(<2 x i32> %a, <8 x i8> %b, <8 x i8> %.cast5) #2
  ret <2 x i32> %vdot1.i
}

define <4 x i32> @test_vdotq_lane_u32(<4 x i32> %a, <16 x i8> %b, <8 x i8> %c) {
; CHECK-LABEL: test_vdotq_lane_u32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.4s, v1.16b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <8 x i8> %c to <2 x i32>
  %shuffle = shufflevector <2 x i32> %.cast, <2 x i32> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %.cast3 = bitcast <4 x i32> %shuffle to <16 x i8>
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.udot.v4i32.v16i8(<4 x i32> %a, <16 x i8> %b, <16 x i8> %.cast3) #2
  ret <4 x i32> %vdot1.i
}

define <2 x i32> @test_vdot_laneq_u32(<2 x i32> %a, <8 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: test_vdot_laneq_u32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.2s, v1.8b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <16 x i8> %c to <4 x i32>
  %shuffle = shufflevector <4 x i32> %.cast, <4 x i32> undef, <2 x i32> <i32 1, i32 1>
  %.cast5 = bitcast <2 x i32> %shuffle to <8 x i8>
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.udot.v2i32.v8i8(<2 x i32> %a, <8 x i8> %b, <8 x i8> %.cast5) #2
  ret <2 x i32> %vdot1.i
}

define <4 x i32> @test_vdotq_laneq_u32(<4 x i32> %a, <16 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: test_vdotq_laneq_u32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.4s, v1.16b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <16 x i8> %c to <4 x i32>
  %shuffle = shufflevector <4 x i32> %.cast, <4 x i32> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %.cast3 = bitcast <4 x i32> %shuffle to <16 x i8>
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.udot.v4i32.v16i8(<4 x i32> %a, <16 x i8> %b, <16 x i8> %.cast3) #2
  ret <4 x i32> %vdot1.i
}


define <2 x i32> @test_vdot_lane_u32_zero(<2 x i32> %a, <8 x i8> %b, <8 x i8> %c) {
; CHECK-LABEL: test_vdot_lane_u32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.2s, v1.8b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <8 x i8> %c to <2 x i32>
  %shuffle = shufflevector <2 x i32> %.cast, <2 x i32> undef, <2 x i32> <i32 1, i32 1>
  %.cast5 = bitcast <2 x i32> %shuffle to <8 x i8>
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.udot.v2i32.v8i8(<2 x i32> zeroinitializer, <8 x i8> %b, <8 x i8> %.cast5) #2
  %ret = add <2 x i32> %vdot1.i, %a
  ret <2 x i32> %ret
}

define <4 x i32> @test_vdotq_lane_u32_zero(<4 x i32> %a, <16 x i8> %b, <8 x i8> %c) {
; CHECK-LABEL: test_vdotq_lane_u32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.4s, v1.16b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <8 x i8> %c to <2 x i32>
  %shuffle = shufflevector <2 x i32> %.cast, <2 x i32> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %.cast3 = bitcast <4 x i32> %shuffle to <16 x i8>
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.udot.v4i32.v16i8(<4 x i32> zeroinitializer, <16 x i8> %b, <16 x i8> %.cast3) #2
  %ret = add <4 x i32> %vdot1.i, %a
  ret <4 x i32> %ret
}

define <2 x i32> @test_vdot_laneq_u32_zero(<2 x i32> %a, <8 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: test_vdot_laneq_u32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.2s, v1.8b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <16 x i8> %c to <4 x i32>
  %shuffle = shufflevector <4 x i32> %.cast, <4 x i32> undef, <2 x i32> <i32 1, i32 1>
  %.cast5 = bitcast <2 x i32> %shuffle to <8 x i8>
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.udot.v2i32.v8i8(<2 x i32> zeroinitializer, <8 x i8> %b, <8 x i8> %.cast5) #2
  %ret = add <2 x i32> %vdot1.i, %a
  ret <2 x i32> %ret
}

define <4 x i32> @test_vdotq_laneq_u32_zero(<4 x i32> %a, <16 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: test_vdotq_laneq_u32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    udot v0.4s, v1.16b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <16 x i8> %c to <4 x i32>
  %shuffle = shufflevector <4 x i32> %.cast, <4 x i32> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %.cast3 = bitcast <4 x i32> %shuffle to <16 x i8>
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.udot.v4i32.v16i8(<4 x i32> zeroinitializer, <16 x i8> %b, <16 x i8> %.cast3) #2
  %ret = add <4 x i32> %vdot1.i, %a
  ret <4 x i32> %ret
}


define <2 x i32> @test_vdot_lane_s32(<2 x i32> %a, <8 x i8> %b, <8 x i8> %c) {
; CHECK-LABEL: test_vdot_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.2s, v1.8b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <8 x i8> %c to <2 x i32>
  %shuffle = shufflevector <2 x i32> %.cast, <2 x i32> undef, <2 x i32> <i32 1, i32 1>
  %.cast5 = bitcast <2 x i32> %shuffle to <8 x i8>
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.sdot.v2i32.v8i8(<2 x i32> %a, <8 x i8> %b, <8 x i8> %.cast5) #2
  ret <2 x i32> %vdot1.i
}

define <4 x i32> @test_vdotq_lane_s32(<4 x i32> %a, <16 x i8> %b, <8 x i8> %c) {
; CHECK-LABEL: test_vdotq_lane_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.4s, v1.16b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <8 x i8> %c to <2 x i32>
  %shuffle = shufflevector <2 x i32> %.cast, <2 x i32> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %.cast3 = bitcast <4 x i32> %shuffle to <16 x i8>
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.sdot.v4i32.v16i8(<4 x i32> %a, <16 x i8> %b, <16 x i8> %.cast3) #2
  ret <4 x i32> %vdot1.i
}

define <2 x i32> @test_vdot_laneq_s32(<2 x i32> %a, <8 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: test_vdot_laneq_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.2s, v1.8b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <16 x i8> %c to <4 x i32>
  %shuffle = shufflevector <4 x i32> %.cast, <4 x i32> undef, <2 x i32> <i32 1, i32 1>
  %.cast5 = bitcast <2 x i32> %shuffle to <8 x i8>
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.sdot.v2i32.v8i8(<2 x i32> %a, <8 x i8> %b, <8 x i8> %.cast5) #2
  ret <2 x i32> %vdot1.i
}

define <4 x i32> @test_vdotq_laneq_s32(<4 x i32> %a, <16 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: test_vdotq_laneq_s32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.4s, v1.16b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <16 x i8> %c to <4 x i32>
  %shuffle = shufflevector <4 x i32> %.cast, <4 x i32> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %.cast3 = bitcast <4 x i32> %shuffle to <16 x i8>
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.sdot.v4i32.v16i8(<4 x i32> %a, <16 x i8> %b, <16 x i8> %.cast3) #2
  ret <4 x i32> %vdot1.i
}


define <2 x i32> @test_vdot_lane_s32_zero(<2 x i32> %a, <8 x i8> %b, <8 x i8> %c) {
; CHECK-LABEL: test_vdot_lane_s32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.2s, v1.8b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <8 x i8> %c to <2 x i32>
  %shuffle = shufflevector <2 x i32> %.cast, <2 x i32> undef, <2 x i32> <i32 1, i32 1>
  %.cast5 = bitcast <2 x i32> %shuffle to <8 x i8>
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.sdot.v2i32.v8i8(<2 x i32> zeroinitializer, <8 x i8> %b, <8 x i8> %.cast5) #2
  %ret = add <2 x i32> %vdot1.i, %a
  ret <2 x i32> %ret
}

define <4 x i32> @test_vdotq_lane_s32_zero(<4 x i32> %a, <16 x i8> %b, <8 x i8> %c) {
; CHECK-LABEL: test_vdotq_lane_s32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.4s, v1.16b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <8 x i8> %c to <2 x i32>
  %shuffle = shufflevector <2 x i32> %.cast, <2 x i32> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %.cast3 = bitcast <4 x i32> %shuffle to <16 x i8>
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.sdot.v4i32.v16i8(<4 x i32> zeroinitializer, <16 x i8> %b, <16 x i8> %.cast3) #2
  %ret = add <4 x i32> %vdot1.i, %a
  ret <4 x i32> %ret
}

define <2 x i32> @test_vdot_laneq_s32_zero(<2 x i32> %a, <8 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: test_vdot_laneq_s32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.2s, v1.8b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <16 x i8> %c to <4 x i32>
  %shuffle = shufflevector <4 x i32> %.cast, <4 x i32> undef, <2 x i32> <i32 1, i32 1>
  %.cast5 = bitcast <2 x i32> %shuffle to <8 x i8>
  %vdot1.i = call <2 x i32> @llvm.aarch64.neon.sdot.v2i32.v8i8(<2 x i32> zeroinitializer, <8 x i8> %b, <8 x i8> %.cast5) #2
  %ret = add <2 x i32> %vdot1.i, %a
  ret <2 x i32> %ret
}

define <4 x i32> @test_vdotq_laneq_s32_zero(<4 x i32> %a, <16 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: test_vdotq_laneq_s32_zero:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sdot v0.4s, v1.16b, v2.4b[1]
; CHECK-NEXT:    ret
entry:
  %.cast = bitcast <16 x i8> %c to <4 x i32>
  %shuffle = shufflevector <4 x i32> %.cast, <4 x i32> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %.cast3 = bitcast <4 x i32> %shuffle to <16 x i8>
  %vdot1.i = call <4 x i32> @llvm.aarch64.neon.sdot.v4i32.v16i8(<4 x i32> zeroinitializer, <16 x i8> %b, <16 x i8> %.cast3) #2
  %ret = add <4 x i32> %vdot1.i, %a
  ret <4 x i32> %ret
}
