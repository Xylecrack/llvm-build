; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -verify-machineinstrs -o - %s | FileCheck %s --check-prefixes=CHECK,CHECK-NO16
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+fullfp16 -verify-machineinstrs -o - %s | FileCheck %s --check-prefixes=CHECK,CHECK-FP16

define <2 x i32> @test1(<2 x float> %f) {
; CHECK-LABEL: test1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.2s, v0.2s, #4
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 16.000000e+00, float 16.000000e+00>
  %vcvt.i = fptosi <2 x float> %mul.i to <2 x i32>
  ret <2 x i32> %vcvt.i
}

define <4 x i32> @test2(<4 x float> %f) {
; CHECK-LABEL: test2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.4s, v0.4s, #3
; CHECK-NEXT:    ret
  %mul.i = fmul <4 x float> %f, <float 8.000000e+00, float 8.000000e+00, float 8.000000e+00, float 8.000000e+00>
  %vcvt.i = fptosi <4 x float> %mul.i to <4 x i32>
  ret <4 x i32> %vcvt.i
}

define <2 x i64> @test3(<2 x double> %d) {
; CHECK-LABEL: test3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.2d, v0.2d, #5
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x double> %d, <double 32.000000e+00, double 32.000000e+00>
  %vcvt.i = fptosi <2 x double> %mul.i to <2 x i64>
  ret <2 x i64> %vcvt.i
}

; Truncate double to i32
define <2 x i32> @test4(<2 x double> %d) {
; CHECK-LABEL: test4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.2d, v0.2d, #4
; CHECK-NEXT:    xtn v0.2s, v0.2d
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x double> %d, <double 16.000000e+00, double 16.000000e+00>
  %vcvt.i = fptosi <2 x double> %mul.i to <2 x i32>
  ret <2 x i32> %vcvt.i
}

; Truncate float to i16
define <2 x i16> @test5(<2 x float> %f) {
; CHECK-LABEL: test5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.2s, v0.2s, #4
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 16.000000e+00, float 16.000000e+00>
  %vcvt.i = fptosi <2 x float> %mul.i to <2 x i16>
  ret <2 x i16> %vcvt.i
}

; Don't convert float to i64
define <2 x i64> @test6(<2 x float> %f) {
; CHECK-LABEL: test6:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v1.2s, #16.00000000
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    fcvtl v0.2d, v0.2s
; CHECK-NEXT:    fcvtzs v0.2d, v0.2d
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 16.000000e+00, float 16.000000e+00>
  %vcvt.i = fptosi <2 x float> %mul.i to <2 x i64>
  ret <2 x i64> %vcvt.i
}

define <2 x i32> @test7(<2 x float> %f) {
; CHECK-LABEL: test7:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu v0.2s, v0.2s, #4
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 16.000000e+00, float 16.000000e+00>
  %vcvt.i = fptoui <2 x float> %mul.i to <2 x i32>
  ret <2 x i32> %vcvt.i
}

; Test which should not fold due to non-power of 2.
define <2 x i32> @test8(<2 x float> %f) {
; CHECK-LABEL: test8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v1.2s, #17.00000000
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    fcvtzu v0.2s, v0.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 17.000000e+00, float 17.000000e+00>
  %vcvt.i = fptoui <2 x float> %mul.i to <2 x i32>
  ret <2 x i32> %vcvt.i
}

; Test which should not fold due to non-matching power of 2.
define <2 x i32> @test9(<2 x float> %f) {
; CHECK-LABEL: test9:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI8_0
; CHECK-NEXT:    ldr d1, [x8, :lo12:.LCPI8_0]
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    fcvtzu v0.2s, v0.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 16.000000e+00, float 8.000000e+00>
  %vcvt.i = fptoui <2 x float> %mul.i to <2 x i32>
  ret <2 x i32> %vcvt.i
}

; Combine all undefs.
define <2 x i32> @test10(<2 x float> %f) {
; CHECK-LABEL: test10:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.2s, #63, msl #16
; CHECK-NEXT:    fneg v0.2s, v0.2s
; CHECK-NEXT:    fcvtzu v0.2s, v0.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float undef, float undef>
  %vcvt.i = fptoui <2 x float> %mul.i to <2 x i32>
  ret <2 x i32> %vcvt.i
}

; Combine if mix of undef and pow2.
define <2 x i32> @test11(<2 x float> %f) {
; CHECK-LABEL: test11:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu v0.2s, v0.2s, #3
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float undef, float 8.000000e+00>
  %vcvt.i = fptoui <2 x float> %mul.i to <2 x i32>
  ret <2 x i32> %vcvt.i
}

; Don't combine when multiplied by 0.0.
define <2 x i32> @test12(<2 x float> %f) {
; CHECK-LABEL: test12:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    fcvtzs v0.2s, v0.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 0.000000e+00, float 0.000000e+00>
  %vcvt.i = fptosi <2 x float> %mul.i to <2 x i32>
  ret <2 x i32> %vcvt.i
}

; Test which should not fold due to power of 2 out of range (i.e., 2^33).
define <2 x i32> @test13(<2 x float> %f) {
; CHECK-LABEL: test13:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.2s, #80, lsl #24
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    fcvtzs v0.2s, v0.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 0x4200000000000000, float 0x4200000000000000>
  %vcvt.i = fptosi <2 x float> %mul.i to <2 x i32>
  ret <2 x i32> %vcvt.i
}

; Test case where const is max power of 2 (i.e., 2^32).
define <2 x i32> @test14(<2 x float> %f) {
; CHECK-LABEL: test14:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.2s, v0.2s, #32
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 0x41F0000000000000, float 0x41F0000000000000>
  %vcvt.i = fptosi <2 x float> %mul.i to <2 x i32>
  ret <2 x i32> %vcvt.i
}

define <3 x i32> @test_illegal_fp_to_int(<3 x float> %in) {
; CHECK-LABEL: test_illegal_fp_to_int:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.4s, v0.4s, #2
; CHECK-NEXT:    ret
  %scale = fmul <3 x float> %in, <float 4.0, float 4.0, float 4.0>
  %val = fptosi <3 x float> %scale to <3 x i32>
  ret <3 x i32> %val
}

define <8 x i16> @test_v8f16(<8 x half> %in) {
; CHECK-NO16-LABEL: test_v8f16:
; CHECK-NO16:       // %bb.0:
; CHECK-NO16-NEXT:    movi v1.8h, #68, lsl #8
; CHECK-NO16-NEXT:    fcvtl v2.4s, v0.4h
; CHECK-NO16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-NO16-NEXT:    fcvtl v3.4s, v1.4h
; CHECK-NO16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-NO16-NEXT:    fmul v2.4s, v2.4s, v3.4s
; CHECK-NO16-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-NO16-NEXT:    fcvtn v1.4h, v2.4s
; CHECK-NO16-NEXT:    fcvtn2 v1.8h, v0.4s
; CHECK-NO16-NEXT:    fcvtl2 v0.4s, v1.8h
; CHECK-NO16-NEXT:    fcvtl v1.4s, v1.4h
; CHECK-NO16-NEXT:    fcvtzs v0.4s, v0.4s
; CHECK-NO16-NEXT:    fcvtzs v1.4s, v1.4s
; CHECK-NO16-NEXT:    uzp1 v0.8h, v1.8h, v0.8h
; CHECK-NO16-NEXT:    ret
;
; CHECK-FP16-LABEL: test_v8f16:
; CHECK-FP16:       // %bb.0:
; CHECK-FP16-NEXT:    fcvtzs v0.8h, v0.8h, #2
; CHECK-FP16-NEXT:    ret
  %scale = fmul <8 x half> %in, <half 4.0, half 4.0, half 4.0, half 4.0, half 4.0, half 4.0, half 4.0, half 4.0>
  %val = fptosi <8 x half> %scale to <8 x i16>
  ret <8 x i16> %val
}

define <4 x i16> @test_v4f16(<4 x half> %in) {
; CHECK-NO16-LABEL: test_v4f16:
; CHECK-NO16:       // %bb.0:
; CHECK-NO16-NEXT:    fmov v1.4s, #4.00000000
; CHECK-NO16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NO16-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-NO16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NO16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NO16-NEXT:    fcvtzu v0.4s, v0.4s
; CHECK-NO16-NEXT:    xtn v0.4h, v0.4s
; CHECK-NO16-NEXT:    ret
;
; CHECK-FP16-LABEL: test_v4f16:
; CHECK-FP16:       // %bb.0:
; CHECK-FP16-NEXT:    fcvtzu v0.4h, v0.4h, #2
; CHECK-FP16-NEXT:    ret
  %scale = fmul <4 x half> %in, <half 4.0, half 4.0, half 4.0, half 4.0>
  %val = fptoui <4 x half> %scale to <4 x i16>
  ret <4 x i16> %val
}

define <4 x i32> @test_v4f16_i32(<4 x half> %in) {
; CHECK-NO16-LABEL: test_v4f16_i32:
; CHECK-NO16:       // %bb.0:
; CHECK-NO16-NEXT:    fmov v1.4s, #4.00000000
; CHECK-NO16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NO16-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-NO16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NO16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NO16-NEXT:    fcvtzs v0.4s, v0.4s
; CHECK-NO16-NEXT:    ret
;
; CHECK-FP16-LABEL: test_v4f16_i32:
; CHECK-FP16:       // %bb.0:
; CHECK-FP16-NEXT:    movi v1.4h, #68, lsl #8
; CHECK-FP16-NEXT:    fmul v0.4h, v0.4h, v1.4h
; CHECK-FP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-FP16-NEXT:    fcvtzs v0.4s, v0.4s
; CHECK-FP16-NEXT:    ret
  %scale = fmul <4 x half> %in, <half 4.0, half 4.0, half 4.0, half 4.0>
  %val = fptosi <4 x half> %scale to <4 x i32>
  ret <4 x i32> %val
}


declare <2 x i32> @llvm.fptosi.sat.v2i32.v2f32(<2 x float>)
declare <2 x i32> @llvm.fptoui.sat.v2i32.v2f32(<2 x float>)
declare <2 x i32> @llvm.fptosi.sat.v2i32.v2f64(<2 x double>)
declare <2 x i64> @llvm.fptosi.sat.v2i64.v2f64(<2 x double>)
declare <4 x i32> @llvm.fptosi.sat.v4i32.v4f32(<4 x float>)
declare <2 x i16> @llvm.fptosi.sat.v2i16.v2f32(<2 x float>)
declare <4 x i16> @llvm.fptosi.sat.v4i16.v4f32(<4 x float>)
declare <2 x i64> @llvm.fptosi.sat.v2i64.v2f32(<2 x float>)
declare <3 x i32> @llvm.fptosi.sat.v3i32.v3f32(<3 x float>)
declare <8 x i16> @llvm.fptosi.sat.v8i16.v8f16(<8 x half>)
declare <4 x i16> @llvm.fptoui.sat.v4i16.v4f16(<4 x half>)
declare <4 x i32> @llvm.fptosi.sat.v4i32.v4f16(<4 x half>)
declare <4 x i24> @llvm.fptoui.sat.v4i24.v4f32(<4 x float>)

define <2 x i32> @test1_sat(<2 x float> %f) {
; CHECK-LABEL: test1_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.2s, v0.2s, #4
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 16.000000e+00, float 16.000000e+00>
  %vcvt.i = call <2 x i32> @llvm.fptosi.sat.v2i32.v2f32(<2 x float> %mul.i)
  ret <2 x i32> %vcvt.i
}

define <4 x i32> @test2_sat(<4 x float> %f) {
; CHECK-LABEL: test2_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.4s, v0.4s, #3
; CHECK-NEXT:    ret
  %mul.i = fmul <4 x float> %f, <float 8.000000e+00, float 8.000000e+00, float 8.000000e+00, float 8.000000e+00>
  %vcvt.i = call <4 x i32> @llvm.fptosi.sat.v4i32.v4f32(<4 x float> %mul.i)
  ret <4 x i32> %vcvt.i
}

define <2 x i64> @test3_sat(<2 x double> %d) {
; CHECK-LABEL: test3_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.2d, v0.2d, #5
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x double> %d, <double 32.000000e+00, double 32.000000e+00>
  %vcvt.i = call <2 x i64> @llvm.fptosi.sat.v2i64.v2f64(<2 x double> %mul.i)
  ret <2 x i64> %vcvt.i
}

; Truncate double to i32
define <2 x i32> @test4_sat(<2 x double> %d) {
; CHECK-LABEL: test4_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v1.2d, #16.00000000
; CHECK-NEXT:    fmul v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    mov d1, v0.d[1]
; CHECK-NEXT:    fcvtzs w8, d0
; CHECK-NEXT:    fcvtzs w9, d1
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov v0.s[1], w9
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x double> %d, <double 16.000000e+00, double 16.000000e+00>
  %vcvt.i = call <2 x i32> @llvm.fptosi.sat.v2i32.v2f64(<2 x double> %mul.i)
  ret <2 x i32> %vcvt.i
}

; Truncate float to i16
define <2 x i16> @test5_sat(<2 x float> %f) {
; CHECK-LABEL: test5_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.2s, #127, msl #8
; CHECK-NEXT:    fcvtzs v0.2s, v0.2s, #4
; CHECK-NEXT:    smin v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    mvni v1.2s, #127, msl #8
; CHECK-NEXT:    smax v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 16.000000e+00, float 16.000000e+00>
  %vcvt.i = call <2 x i16> @llvm.fptosi.sat.v2i16.v2f32(<2 x float> %mul.i)
  ret <2 x i16> %vcvt.i
}

; Truncate float to i16
define <4 x i16> @test5l_sat(<4 x float> %f) {
; CHECK-LABEL: test5l_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.4s, v0.4s, #4
; CHECK-NEXT:    sqxtn v0.4h, v0.4s
; CHECK-NEXT:    ret
  %mul.i = fmul <4 x float> %f, <float 16.000000e+00, float 16.000000e+00, float 16.000000e+00, float 16.000000e+00>
  %vcvt.i = call <4 x i16> @llvm.fptosi.sat.v4i16.v4f32(<4 x float> %mul.i)
  ret <4 x i16> %vcvt.i
}

; Don't convert float to i64
define <2 x i64> @test6_sat(<2 x float> %f) {
; CHECK-LABEL: test6_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v1.2s, #16.00000000
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    fcvtl v0.2d, v0.2s
; CHECK-NEXT:    fcvtzs v0.2d, v0.2d
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 16.000000e+00, float 16.000000e+00>
  %vcvt.i = call <2 x i64> @llvm.fptosi.sat.v2i64.v2f32(<2 x float> %mul.i)
  ret <2 x i64> %vcvt.i
}

define <2 x i32> @test7_sat(<2 x float> %f) {
; CHECK-LABEL: test7_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu v0.2s, v0.2s, #4
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 16.000000e+00, float 16.000000e+00>
  %vcvt.i = call <2 x i32> @llvm.fptoui.sat.v2i32.v2f32(<2 x float> %mul.i)
  ret <2 x i32> %vcvt.i
}

; Test which should not fold due to non-power of 2.
define <2 x i32> @test8_sat(<2 x float> %f) {
; CHECK-LABEL: test8_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v1.2s, #17.00000000
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    fcvtzu v0.2s, v0.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 17.000000e+00, float 17.000000e+00>
  %vcvt.i = call <2 x i32> @llvm.fptoui.sat.v2i32.v2f32(<2 x float> %mul.i)
  ret <2 x i32> %vcvt.i
}

; Test which should not fold due to non-matching power of 2.
define <2 x i32> @test9_sat(<2 x float> %f) {
; CHECK-LABEL: test9_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI27_0
; CHECK-NEXT:    ldr d1, [x8, :lo12:.LCPI27_0]
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    fcvtzu v0.2s, v0.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 16.000000e+00, float 8.000000e+00>
  %vcvt.i = call <2 x i32> @llvm.fptoui.sat.v2i32.v2f32(<2 x float> %mul.i)
  ret <2 x i32> %vcvt.i
}

; Combine all undefs.
define <2 x i32> @test10_sat(<2 x float> %f) {
; CHECK-LABEL: test10_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.2s, #63, msl #16
; CHECK-NEXT:    fneg v0.2s, v0.2s
; CHECK-NEXT:    fcvtzu v0.2s, v0.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float undef, float undef>
  %vcvt.i = call <2 x i32> @llvm.fptoui.sat.v2i32.v2f32(<2 x float> %mul.i)
  ret <2 x i32> %vcvt.i
}

; Combine if mix of undef and pow2.
define <2 x i32> @test11_sat(<2 x float> %f) {
; CHECK-LABEL: test11_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzu v0.2s, v0.2s, #3
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float undef, float 8.000000e+00>
  %vcvt.i = call <2 x i32> @llvm.fptoui.sat.v2i32.v2f32(<2 x float> %mul.i)
  ret <2 x i32> %vcvt.i
}

; Don't combine when multiplied by 0.0.
define <2 x i32> @test12_sat(<2 x float> %f) {
; CHECK-LABEL: test12_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    fcvtzs v0.2s, v0.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 0.000000e+00, float 0.000000e+00>
  %vcvt.i = call <2 x i32> @llvm.fptosi.sat.v2i32.v2f32(<2 x float> %mul.i)
  ret <2 x i32> %vcvt.i
}

; Test which should not fold due to power of 2 out of range (i.e., 2^33).
define <2 x i32> @test13_sat(<2 x float> %f) {
; CHECK-LABEL: test13_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.2s, #80, lsl #24
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    fcvtzs v0.2s, v0.2s
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 0x4200000000000000, float 0x4200000000000000>
  %vcvt.i = call <2 x i32> @llvm.fptosi.sat.v2i32.v2f32(<2 x float> %mul.i)
  ret <2 x i32> %vcvt.i
}

; Test case where const is max power of 2 (i.e., 2^32).
define <2 x i32> @test14_sat(<2 x float> %f) {
; CHECK-LABEL: test14_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.2s, v0.2s, #32
; CHECK-NEXT:    ret
  %mul.i = fmul <2 x float> %f, <float 0x41F0000000000000, float 0x41F0000000000000>
  %vcvt.i = call <2 x i32> @llvm.fptosi.sat.v2i32.v2f32(<2 x float> %mul.i)
  ret <2 x i32> %vcvt.i
}

define <3 x i32> @test_illegal_fp_to_int_sat_sat(<3 x float> %in) {
; CHECK-LABEL: test_illegal_fp_to_int_sat_sat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvtzs v0.4s, v0.4s, #2
; CHECK-NEXT:    ret
  %mul.i = fmul <3 x float> %in, <float 4.0, float 4.0, float 4.0>
  %vcvt.i = call <3 x i32> @llvm.fptosi.sat.v3i32.v3f32(<3 x float> %mul.i)
  ret <3 x i32> %vcvt.i
}

define <8 x i16> @test_v8f16_sat(<8 x half> %in) {
; CHECK-NO16-LABEL: test_v8f16_sat:
; CHECK-NO16:       // %bb.0:
; CHECK-NO16-NEXT:    movi v1.8h, #68, lsl #8
; CHECK-NO16-NEXT:    fcvtl v2.4s, v0.4h
; CHECK-NO16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-NO16-NEXT:    fcvtl v3.4s, v1.4h
; CHECK-NO16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-NO16-NEXT:    fmul v2.4s, v2.4s, v3.4s
; CHECK-NO16-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-NO16-NEXT:    fcvtn v1.4h, v2.4s
; CHECK-NO16-NEXT:    fcvtn2 v1.8h, v0.4s
; CHECK-NO16-NEXT:    fcvtl v0.4s, v1.4h
; CHECK-NO16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-NO16-NEXT:    fcvtzs v0.4s, v0.4s
; CHECK-NO16-NEXT:    fcvtzs v1.4s, v1.4s
; CHECK-NO16-NEXT:    sqxtn v0.4h, v0.4s
; CHECK-NO16-NEXT:    sqxtn2 v0.8h, v1.4s
; CHECK-NO16-NEXT:    ret
;
; CHECK-FP16-LABEL: test_v8f16_sat:
; CHECK-FP16:       // %bb.0:
; CHECK-FP16-NEXT:    fcvtzs v0.8h, v0.8h, #2
; CHECK-FP16-NEXT:    ret
  %mul.i = fmul <8 x half> %in, <half 4.0, half 4.0, half 4.0, half 4.0, half 4.0, half 4.0, half 4.0, half 4.0>
  %val = call <8 x i16> @llvm.fptosi.sat.v8i16.v8f16(<8 x half> %mul.i)
  ret <8 x i16> %val
}

define <4 x i16> @test_v4f16_sat(<4 x half> %in) {
; CHECK-NO16-LABEL: test_v4f16_sat:
; CHECK-NO16:       // %bb.0:
; CHECK-NO16-NEXT:    fmov v1.4s, #4.00000000
; CHECK-NO16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NO16-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-NO16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NO16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NO16-NEXT:    fcvtzu v0.4s, v0.4s
; CHECK-NO16-NEXT:    uqxtn v0.4h, v0.4s
; CHECK-NO16-NEXT:    ret
;
; CHECK-FP16-LABEL: test_v4f16_sat:
; CHECK-FP16:       // %bb.0:
; CHECK-FP16-NEXT:    fcvtzu v0.4h, v0.4h, #2
; CHECK-FP16-NEXT:    ret
  %mul.i = fmul <4 x half> %in, <half 4.0, half 4.0, half 4.0, half 4.0>
  %val = call <4 x i16> @llvm.fptoui.sat.v4i16.v4f16(<4 x half> %mul.i)
  ret <4 x i16> %val
}

define <4 x i32> @test_v4f16_i32_sat(<4 x half> %in) {
; CHECK-NO16-LABEL: test_v4f16_i32_sat:
; CHECK-NO16:       // %bb.0:
; CHECK-NO16-NEXT:    fmov v1.4s, #4.00000000
; CHECK-NO16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NO16-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-NO16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-NO16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NO16-NEXT:    fcvtzs v0.4s, v0.4s
; CHECK-NO16-NEXT:    ret
;
; CHECK-FP16-LABEL: test_v4f16_i32_sat:
; CHECK-FP16:       // %bb.0:
; CHECK-FP16-NEXT:    movi v1.4h, #68, lsl #8
; CHECK-FP16-NEXT:    fmul v0.4h, v0.4h, v1.4h
; CHECK-FP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-FP16-NEXT:    fcvtzs v0.4s, v0.4s
; CHECK-FP16-NEXT:    ret
  %mul.i = fmul <4 x half> %in, <half 4.0, half 4.0, half 4.0, half 4.0>
  %val = call <4 x i32> @llvm.fptosi.sat.v4i32.v4f16(<4 x half> %mul.i)
  ret <4 x i32> %val
}

define <4 x i32> @test_extrasat(<4 x float> %f) {
; CHECK-LABEL: test_extrasat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.2d, #0xffffff00ffffff
; CHECK-NEXT:    fcvtzu v0.4s, v0.4s, #3
; CHECK-NEXT:    umin v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
  %mul.i = fmul <4 x float> %f, <float 8.000000e+00, float 8.000000e+00, float 8.000000e+00, float 8.000000e+00>
  %vcvt.i = call <4 x i24> @llvm.fptoui.sat.v4i24.v4f32(<4 x float> %mul.i)
  %t = zext <4 x i24> %vcvt.i to <4 x i32>
  ret <4 x i32> %t
}
