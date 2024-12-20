; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s | FileCheck %s

target triple = "aarch64"

; First some corner cases
define <4 x float> @f_v4_s0(<4 x i32> %u) {
; CHECK-LABEL: f_v4_s0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf v0.4s, v0.4s
; CHECK-NEXT:    ret
  %s = ashr exact <4 x i32> %u, <i32 0, i32 0, i32 0, i32 0>
  %v = sitofp <4 x i32> %s to <4 x float>
  ret <4 x float> %v
}

define <4 x float> @f_v4_s1(<4 x i32> %u) {
; CHECK-LABEL: f_v4_s1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf v0.4s, v0.4s, #1
; CHECK-NEXT:    ret
  %s = ashr exact <4 x i32> %u, <i32 1, i32 1, i32 1, i32 1>
  %v = sitofp <4 x i32> %s to <4 x float>
  ret <4 x float> %v
}

define <4 x float> @f_v4_s24_inexact(<4 x i32> %u) {
; CHECK-LABEL: f_v4_s24_inexact:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshr v0.4s, v0.4s, #24
; CHECK-NEXT:    scvtf v0.4s, v0.4s
; CHECK-NEXT:    ret
  %s = ashr <4 x i32> %u, <i32 24, i32 24, i32 24, i32 24>
  %v = sitofp <4 x i32> %s to <4 x float>
  ret <4 x float> %v
}

define <4 x float> @f_v4_s31(<4 x i32> %u) {
; CHECK-LABEL: f_v4_s31:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmlt v0.4s, v0.4s, #0
; CHECK-NEXT:    scvtf v0.4s, v0.4s
; CHECK-NEXT:    ret
  %s = ashr <4 x i32> %u, <i32 31, i32 31, i32 31, i32 31>
  %v = sitofp <4 x i32> %s to <4 x float>
  ret <4 x float> %v
}

; Common cases for conversion from signed integer to floating point types
define <2 x float> @f_v2_s24(<2 x i32> %u) {
; CHECK-LABEL: f_v2_s24:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf v0.2s, v0.2s, #24
; CHECK-NEXT:    ret
  %s = ashr exact <2 x i32> %u, <i32 24, i32 24>
  %v = sitofp <2 x i32> %s to <2 x float>
  ret <2 x float> %v
}

define <4 x float> @f_v4_s24(<4 x i32> %u) {
; CHECK-LABEL: f_v4_s24:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf v0.4s, v0.4s, #24
; CHECK-NEXT:    ret
  %s = ashr exact <4 x i32> %u, <i32 24, i32 24, i32 24, i32 24>
  %v = sitofp <4 x i32> %s to <4 x float>
  ret <4 x float> %v
}

; Check legalisation to <2 x f64> does not get in the way
define <8 x double> @d_v8_s64(<8 x i64> %u) {
; CHECK-LABEL: d_v8_s64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf v0.2d, v0.2d, #56
; CHECK-NEXT:    scvtf v1.2d, v1.2d, #56
; CHECK-NEXT:    scvtf v2.2d, v2.2d, #56
; CHECK-NEXT:    scvtf v3.2d, v3.2d, #56
; CHECK-NEXT:    ret
  %s = ashr exact <8 x i64> %u, <i64 56, i64 56, i64 56, i64 56, i64 56, i64 56, i64 56, i64 56>
  %v = sitofp <8 x i64> %s to <8 x double>
  ret <8 x double> %v
}

define <4 x half> @h_v4_s8(<4 x i16> %u) #0 {
; CHECK-LABEL: h_v4_s8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf v0.4h, v0.4h, #8
; CHECK-NEXT:    ret
  %s = ashr exact <4 x i16> %u, <i16 8, i16 8, i16 8, i16 8>
  %v = sitofp <4 x i16> %s to <4 x half>
  ret <4 x half> %v
}

define <8 x half> @h_v8_s8(<8 x i16> %u) #0 {
; CHECK-LABEL: h_v8_s8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf v0.8h, v0.8h, #8
; CHECK-NEXT:    ret
  %s = ashr exact <8 x i16> %u, <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
  %v = sitofp <8 x i16> %s to <8 x half>
  ret <8 x half> %v
}

; int-to-fp conversion of element in lane 0 should apply
; cvtf on vector subregister to avoid fpr->gpr trip
define float @l0_extract_f_v2s(<2 x i32> %u) {
; CHECK-LABEL: l0_extract_f_v2s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf s0, s0
; CHECK-NEXT:    ret
  %i = extractelement <2 x i32> %u, i64 0
  %f = sitofp i32 %i to float
  ret float %f
}

; cvtf to use ssub for bottom 32-bits from v2i32
define float @l0_extract_f_v2u(<2 x i32> %u) {
; CHECK-LABEL: l0_extract_f_v2u:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    ret
  %i = extractelement <2 x i32> %u, i64 0
  %f = uitofp i32 %i to float
  ret float %f
}

; Pattern should only apply when it is known to be lane 0
define float @ln_extract_f_v2s(<2 x i32> %u, i64 %n) {
; CHECK-LABEL: ln_extract_f_v2s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    add x8, sp, #8
; CHECK-NEXT:    str d0, [sp, #8]
; CHECK-NEXT:    bfi x8, x0, #2, #1
; CHECK-NEXT:    ldr s0, [x8]
; CHECK-NEXT:    scvtf s0, s0
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
  %i = extractelement <2 x i32> %u, i64 %n
  %f = sitofp i32 %i to float
  ret float %f
}

; cvtf to use ssub for bottom 32-bits from v4i32
define float @l0_extract_f_v4s(<4 x i32> %u) {
; CHECK-LABEL: l0_extract_f_v4s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf s0, s0
; CHECK-NEXT:    ret
  %i = extractelement <4 x i32> %u, i64 0
  %f = sitofp i32 %i to float
  ret float %f
}

define float @l0_extract_f_v4u(<4 x i32> %u) {
; CHECK-LABEL: l0_extract_f_v4u:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ucvtf s0, s0
; CHECK-NEXT:    ret
  %i = extractelement <4 x i32> %u, i64 0
  %f = uitofp i32 %i to float
  ret float %f
}

define float @ln_extract_f_v4s(<4 x i32> %u, i64 %n) {
; CHECK-LABEL: ln_extract_f_v4s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    str q0, [sp]
; CHECK-NEXT:    bfi x8, x0, #2, #2
; CHECK-NEXT:    ldr s0, [x8]
; CHECK-NEXT:    scvtf s0, s0
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
  %i = extractelement <4 x i32> %u, i64 %n
  %f = sitofp i32 %i to float
  ret float %f
}

; cvtf to use dsub for bottom 64-bits from v2i64
define double @l0_extract_d_v2s(<2 x i64> %u) {
; CHECK-LABEL: l0_extract_d_v2s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf d0, d0
; CHECK-NEXT:    ret
  %i = extractelement <2 x i64> %u, i64 0
  %f = sitofp i64 %i to double
  ret double %f
}

define double @l0_extract_d_v2u(<2 x i64> %u) {
; CHECK-LABEL: l0_extract_d_v2u:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ucvtf d0, d0
; CHECK-NEXT:    ret
  %i = extractelement <2 x i64> %u, i64 0
  %f = uitofp i64 %i to double
  ret double %f
}

define double @ln_extract_d_v2s(<2 x i64> %u, i64 %n) {
; CHECK-LABEL: ln_extract_d_v2s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    str q0, [sp]
; CHECK-NEXT:    bfi x8, x0, #3, #1
; CHECK-NEXT:    ldr d0, [x8]
; CHECK-NEXT:    scvtf d0, d0
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
  %i = extractelement <2 x i64> %u, i64 %n
  %f = sitofp i64 %i to double
  ret double %f
}

; (fullfp16) cvtf to use hsub for bottom 16-bits from v8i16
define half @l0_extract_h_v8s(<8 x i16> %u) #0 {
; CHECK-LABEL: l0_extract_h_v8s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    scvtf h0, h0
; CHECK-NEXT:    ret
  %i = extractelement <8 x i16> %u, i32 0
  %f = sitofp i16 %i to half
  ret half %f
}

define half @l0_extract_h_v8u(<8 x i16> %u) #0 {
; CHECK-LABEL: l0_extract_h_v8u:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ucvtf h0, h0
; CHECK-NEXT:    ret
  %i = extractelement <8 x i16> %u, i32 0
  %f = uitofp i16 %i to half
  ret half %f
}

define half @ln_extract_h_v8u(<8 x i16> %u, i32 %n) #0 {
; CHECK-LABEL: ln_extract_h_v8u:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    str q0, [sp]
; CHECK-NEXT:    bfi x8, x0, #1, #3
; CHECK-NEXT:    ldrh w8, [x8]
; CHECK-NEXT:    ucvtf h0, w8
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    ret
  %i = extractelement <8 x i16> %u, i32 %n
  %f = uitofp i16 %i to half
  ret half %f
}

attributes #0 = { "target-features"="+fullfp16"}
