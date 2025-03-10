; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD,CHECK-SD-NOFP16
; RUN: llc -mtriple=aarch64 -mattr=+fullfp16 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD,CHECK-SD-FP16
; RUN: llc -mtriple=aarch64 -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI,CHECK-GI-NOFP16
; RUN: llc -mtriple=aarch64 -mattr=+fullfp16 -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI,CHECK-GI-FP16

define double @fabs_f64(double %a) {
; CHECK-LABEL: fabs_f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fneg d0, d0
; CHECK-NEXT:    ret
entry:
  %c = fneg double %a
  ret double %c
}

define float @fabs_f32(float %a) {
; CHECK-LABEL: fabs_f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fneg s0, s0
; CHECK-NEXT:    ret
entry:
  %c = fneg float %a
  ret float %c
}

define half @fabs_f16(half %a) {
; CHECK-SD-NOFP16-LABEL: fabs_f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fmov w8, s0
; CHECK-SD-NOFP16-NEXT:    eor w8, w8, #0x8000
; CHECK-SD-NOFP16-NEXT:    fmov s0, w8
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fabs_f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fneg h0, h0
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fabs_f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fmov w8, s0
; CHECK-GI-NOFP16-NEXT:    eor w8, w8, #0xffff8000
; CHECK-GI-NOFP16-NEXT:    fmov s0, w8
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fabs_f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fneg h0, h0
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fneg half %a
  ret half %c
}

define <2 x double> @fabs_v2f64(<2 x double> %a) {
; CHECK-LABEL: fabs_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fneg v0.2d, v0.2d
; CHECK-NEXT:    ret
entry:
  %c = fneg <2 x double> %a
  ret <2 x double> %c
}

define <3 x double> @fabs_v3f64(<3 x double> %a) {
; CHECK-SD-LABEL: fabs_v3f64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-SD-NEXT:    fneg v2.2d, v2.2d
; CHECK-SD-NEXT:    fneg v0.2d, v0.2d
; CHECK-SD-NEXT:    ext v1.16b, v0.16b, v0.16b, #8
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fabs_v3f64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-GI-NEXT:    fneg d2, d2
; CHECK-GI-NEXT:    fneg v0.2d, v0.2d
; CHECK-GI-NEXT:    mov d1, v0.d[1]
; CHECK-GI-NEXT:    ret
entry:
  %c = fneg <3 x double> %a
  ret <3 x double> %c
}

define <4 x double> @fabs_v4f64(<4 x double> %a) {
; CHECK-LABEL: fabs_v4f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fneg v0.2d, v0.2d
; CHECK-NEXT:    fneg v1.2d, v1.2d
; CHECK-NEXT:    ret
entry:
  %c = fneg <4 x double> %a
  ret <4 x double> %c
}

define <2 x float> @fabs_v2f32(<2 x float> %a) {
; CHECK-LABEL: fabs_v2f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fneg v0.2s, v0.2s
; CHECK-NEXT:    ret
entry:
  %c = fneg <2 x float> %a
  ret <2 x float> %c
}

define <3 x float> @fabs_v3f32(<3 x float> %a) {
; CHECK-LABEL: fabs_v3f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fneg v0.4s, v0.4s
; CHECK-NEXT:    ret
entry:
  %c = fneg <3 x float> %a
  ret <3 x float> %c
}

define <4 x float> @fabs_v4f32(<4 x float> %a) {
; CHECK-LABEL: fabs_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fneg v0.4s, v0.4s
; CHECK-NEXT:    ret
entry:
  %c = fneg <4 x float> %a
  ret <4 x float> %c
}

define <8 x float> @fabs_v8f32(<8 x float> %a) {
; CHECK-LABEL: fabs_v8f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fneg v0.4s, v0.4s
; CHECK-NEXT:    fneg v1.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %c = fneg <8 x float> %a
  ret <8 x float> %c
}

define <7 x half> @fabs_v7f16(<7 x half> %a) {
; CHECK-SD-NOFP16-LABEL: fabs_v7f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    movi v1.8h, #128, lsl #8
; CHECK-SD-NOFP16-NEXT:    eor v0.16b, v0.16b, v1.16b
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fabs_v7f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fneg v0.8h, v0.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fabs_v7f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    movi v1.8h, #128, lsl #8
; CHECK-GI-NOFP16-NEXT:    eor v0.16b, v0.16b, v1.16b
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fabs_v7f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fneg v0.8h, v0.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fneg <7 x half> %a
  ret <7 x half> %c
}

define <4 x half> @fabs_v4f16(<4 x half> %a) {
; CHECK-SD-NOFP16-LABEL: fabs_v4f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    movi v1.4h, #128, lsl #8
; CHECK-SD-NOFP16-NEXT:    eor v0.8b, v0.8b, v1.8b
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fabs_v4f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fneg v0.4h, v0.4h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fabs_v4f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    movi v1.4h, #128, lsl #8
; CHECK-GI-NOFP16-NEXT:    eor v0.8b, v0.8b, v1.8b
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fabs_v4f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fneg v0.4h, v0.4h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fneg <4 x half> %a
  ret <4 x half> %c
}

define <8 x half> @fabs_v8f16(<8 x half> %a) {
; CHECK-SD-NOFP16-LABEL: fabs_v8f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    movi v1.8h, #128, lsl #8
; CHECK-SD-NOFP16-NEXT:    eor v0.16b, v0.16b, v1.16b
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fabs_v8f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fneg v0.8h, v0.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fabs_v8f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    movi v1.8h, #128, lsl #8
; CHECK-GI-NOFP16-NEXT:    eor v0.16b, v0.16b, v1.16b
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fabs_v8f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fneg v0.8h, v0.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fneg <8 x half> %a
  ret <8 x half> %c
}

define <16 x half> @fabs_v16f16(<16 x half> %a) {
; CHECK-SD-NOFP16-LABEL: fabs_v16f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    movi v2.8h, #128, lsl #8
; CHECK-SD-NOFP16-NEXT:    eor v0.16b, v0.16b, v2.16b
; CHECK-SD-NOFP16-NEXT:    eor v1.16b, v1.16b, v2.16b
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fabs_v16f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fneg v0.8h, v0.8h
; CHECK-SD-FP16-NEXT:    fneg v1.8h, v1.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fabs_v16f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    movi v2.8h, #128, lsl #8
; CHECK-GI-NOFP16-NEXT:    eor v0.16b, v0.16b, v2.16b
; CHECK-GI-NOFP16-NEXT:    eor v1.16b, v1.16b, v2.16b
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fabs_v16f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fneg v0.8h, v0.8h
; CHECK-GI-FP16-NEXT:    fneg v1.8h, v1.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fneg <16 x half> %a
  ret <16 x half> %c
}
