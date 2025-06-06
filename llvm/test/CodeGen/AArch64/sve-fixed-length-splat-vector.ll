; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -aarch64-sve-vector-bits-min=256  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_256
; RUN: llc -aarch64-sve-vector-bits-min=512  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512
; RUN: llc -aarch64-sve-vector-bits-min=2048 < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512

target triple = "aarch64-unknown-linux-gnu"

;
; DUP (integer)
;

; Don't use SVE for 64-bit vectors.
define <8 x i8> @splat_v8i8(i8 %a) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.8b, w0
; CHECK-NEXT:    ret
  %insert = insertelement <8 x i8> undef, i8 %a, i64 0
  %splat = shufflevector <8 x i8> %insert, <8 x i8> undef, <8 x i32> zeroinitializer
  ret <8 x i8> %splat
}

; Don't use SVE for 128-bit vectors.
define <16 x i8> @splat_v16i8(i8 %a) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.16b, w0
; CHECK-NEXT:    ret
  %insert = insertelement <16 x i8> undef, i8 %a, i64 0
  %splat = shufflevector <16 x i8> %insert, <16 x i8> undef, <16 x i32> zeroinitializer
  ret <16 x i8> %splat
}

define void @splat_v32i8(i8 %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.b, w0
; CHECK-NEXT:    ptrue p0.b, vl32
; CHECK-NEXT:    st1b { z0.b }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <32 x i8> undef, i8 %a, i64 0
  %splat = shufflevector <32 x i8> %insert, <32 x i8> undef, <32 x i32> zeroinitializer
  store <32 x i8> %splat, ptr %b
  ret void
}

define void @splat_v64i8(i8 %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: splat_v64i8:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov z0.b, w0
; VBITS_GE_256-NEXT:    ptrue p0.b, vl32
; VBITS_GE_256-NEXT:    mov w8, #32 // =0x20
; VBITS_GE_256-NEXT:    st1b { z0.b }, p0, [x1, x8]
; VBITS_GE_256-NEXT:    st1b { z0.b }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: splat_v64i8:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    mov z0.b, w0
; VBITS_GE_512-NEXT:    ptrue p0.b, vl64
; VBITS_GE_512-NEXT:    st1b { z0.b }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %insert = insertelement <64 x i8> undef, i8 %a, i64 0
  %splat = shufflevector <64 x i8> %insert, <64 x i8> undef, <64 x i32> zeroinitializer
  store <64 x i8> %splat, ptr %b
  ret void
}

define void @splat_v128i8(i8 %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: splat_v128i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.b, w0
; CHECK-NEXT:    ptrue p0.b, vl128
; CHECK-NEXT:    st1b { z0.b }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <128 x i8> undef, i8 %a, i64 0
  %splat = shufflevector <128 x i8> %insert, <128 x i8> undef, <128 x i32> zeroinitializer
  store <128 x i8> %splat, ptr %b
  ret void
}

define void @splat_v256i8(i8 %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: splat_v256i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.b, w0
; CHECK-NEXT:    ptrue p0.b, vl256
; CHECK-NEXT:    st1b { z0.b }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <256 x i8> undef, i8 %a, i64 0
  %splat = shufflevector <256 x i8> %insert, <256 x i8> undef, <256 x i32> zeroinitializer
  store <256 x i8> %splat, ptr %b
  ret void
}

; Don't use SVE for 64-bit vectors.
define <4 x i16> @splat_v4i16(i16 %a) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.4h, w0
; CHECK-NEXT:    ret
  %insert = insertelement <4 x i16> undef, i16 %a, i64 0
  %splat = shufflevector <4 x i16> %insert, <4 x i16> undef, <4 x i32> zeroinitializer
  ret <4 x i16> %splat
}

; Don't use SVE for 128-bit vectors.
define <8 x i16> @splat_v8i16(i16 %a) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.8h, w0
; CHECK-NEXT:    ret
  %insert = insertelement <8 x i16> undef, i16 %a, i64 0
  %splat = shufflevector <8 x i16> %insert, <8 x i16> undef, <8 x i32> zeroinitializer
  ret <8 x i16> %splat
}

define void @splat_v16i16(i16 %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, w0
; CHECK-NEXT:    ptrue p0.h, vl16
; CHECK-NEXT:    st1h { z0.h }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <16 x i16> undef, i16 %a, i64 0
  %splat = shufflevector <16 x i16> %insert, <16 x i16> undef, <16 x i32> zeroinitializer
  store <16 x i16> %splat, ptr %b
  ret void
}

define void @splat_v32i16(i16 %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: splat_v32i16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov z0.h, w0
; VBITS_GE_256-NEXT:    ptrue p0.h, vl16
; VBITS_GE_256-NEXT:    mov x8, #16 // =0x10
; VBITS_GE_256-NEXT:    st1h { z0.h }, p0, [x1, x8, lsl #1]
; VBITS_GE_256-NEXT:    st1h { z0.h }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: splat_v32i16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    mov z0.h, w0
; VBITS_GE_512-NEXT:    ptrue p0.h, vl32
; VBITS_GE_512-NEXT:    st1h { z0.h }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %insert = insertelement <32 x i16> undef, i16 %a, i64 0
  %splat = shufflevector <32 x i16> %insert, <32 x i16> undef, <32 x i32> zeroinitializer
  store <32 x i16> %splat, ptr %b
  ret void
}

define void @splat_v64i16(i16 %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: splat_v64i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, w0
; CHECK-NEXT:    ptrue p0.h, vl64
; CHECK-NEXT:    st1h { z0.h }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <64 x i16> undef, i16 %a, i64 0
  %splat = shufflevector <64 x i16> %insert, <64 x i16> undef, <64 x i32> zeroinitializer
  store <64 x i16> %splat, ptr %b
  ret void
}

define void @splat_v128i16(i16 %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: splat_v128i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, w0
; CHECK-NEXT:    ptrue p0.h, vl128
; CHECK-NEXT:    st1h { z0.h }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <128 x i16> undef, i16 %a, i64 0
  %splat = shufflevector <128 x i16> %insert, <128 x i16> undef, <128 x i32> zeroinitializer
  store <128 x i16> %splat, ptr %b
  ret void
}

; Don't use SVE for 64-bit vectors.
define <2 x i32> @splat_v2i32(i32 %a) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.2s, w0
; CHECK-NEXT:    ret
  %insert = insertelement <2 x i32> undef, i32 %a, i64 0
  %splat = shufflevector <2 x i32> %insert, <2 x i32> undef, <2 x i32> zeroinitializer
  ret <2 x i32> %splat
}

; Don't use SVE for 128-bit vectors.
define <4 x i32> @splat_v4i32(i32 %a) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.4s, w0
; CHECK-NEXT:    ret
  %insert = insertelement <4 x i32> undef, i32 %a, i64 0
  %splat = shufflevector <4 x i32> %insert, <4 x i32> undef, <4 x i32> zeroinitializer
  ret <4 x i32> %splat
}

define void @splat_v8i32(i32 %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, w0
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <8 x i32> undef, i32 %a, i64 0
  %splat = shufflevector <8 x i32> %insert, <8 x i32> undef, <8 x i32> zeroinitializer
  store <8 x i32> %splat, ptr %b
  ret void
}

define void @splat_v16i32(i32 %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: splat_v16i32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov z0.s, w0
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    mov x8, #8 // =0x8
; VBITS_GE_256-NEXT:    st1w { z0.s }, p0, [x1, x8, lsl #2]
; VBITS_GE_256-NEXT:    st1w { z0.s }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: splat_v16i32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    mov z0.s, w0
; VBITS_GE_512-NEXT:    ptrue p0.s, vl16
; VBITS_GE_512-NEXT:    st1w { z0.s }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %insert = insertelement <16 x i32> undef, i32 %a, i64 0
  %splat = shufflevector <16 x i32> %insert, <16 x i32> undef, <16 x i32> zeroinitializer
  store <16 x i32> %splat, ptr %b
  ret void
}

define void @splat_v32i32(i32 %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: splat_v32i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, w0
; CHECK-NEXT:    ptrue p0.s, vl32
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <32 x i32> undef, i32 %a, i64 0
  %splat = shufflevector <32 x i32> %insert, <32 x i32> undef, <32 x i32> zeroinitializer
  store <32 x i32> %splat, ptr %b
  ret void
}

define void @splat_v64i32(i32 %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: splat_v64i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, w0
; CHECK-NEXT:    ptrue p0.s, vl64
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <64 x i32> undef, i32 %a, i64 0
  %splat = shufflevector <64 x i32> %insert, <64 x i32> undef, <64 x i32> zeroinitializer
  store <64 x i32> %splat, ptr %b
  ret void
}

; Don't use SVE for 64-bit vectors.
define <1 x i64> @splat_v1i64(i64 %a) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov d0, x0
; CHECK-NEXT:    ret
  %insert = insertelement <1 x i64> undef, i64 %a, i64 0
  %splat = shufflevector <1 x i64> %insert, <1 x i64> undef, <1 x i32> zeroinitializer
  ret <1 x i64> %splat
}

; Don't use SVE for 128-bit vectors.
define <2 x i64> @splat_v2i64(i64 %a) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.2d, x0
; CHECK-NEXT:    ret
  %insert = insertelement <2 x i64> undef, i64 %a, i64 0
  %splat = shufflevector <2 x i64> %insert, <2 x i64> undef, <2 x i32> zeroinitializer
  ret <2 x i64> %splat
}

define void @splat_v4i64(i64 %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, x0
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <4 x i64> undef, i64 %a, i64 0
  %splat = shufflevector <4 x i64> %insert, <4 x i64> undef, <4 x i32> zeroinitializer
  store <4 x i64> %splat, ptr %b
  ret void
}

define void @splat_v8i64(i64 %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: splat_v8i64:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov z0.d, x0
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    mov x8, #4 // =0x4
; VBITS_GE_256-NEXT:    st1d { z0.d }, p0, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    st1d { z0.d }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: splat_v8i64:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    mov z0.d, x0
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    st1d { z0.d }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %insert = insertelement <8 x i64> undef, i64 %a, i64 0
  %splat = shufflevector <8 x i64> %insert, <8 x i64> undef, <8 x i32> zeroinitializer
  store <8 x i64> %splat, ptr %b
  ret void
}

define void @splat_v16i64(i64 %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: splat_v16i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, x0
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <16 x i64> undef, i64 %a, i64 0
  %splat = shufflevector <16 x i64> %insert, <16 x i64> undef, <16 x i32> zeroinitializer
  store <16 x i64> %splat, ptr %b
  ret void
}

define void @splat_v32i64(i64 %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: splat_v32i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, x0
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %insert = insertelement <32 x i64> undef, i64 %a, i64 0
  %splat = shufflevector <32 x i64> %insert, <32 x i64> undef, <32 x i32> zeroinitializer
  store <32 x i64> %splat, ptr %b
  ret void
}

;
; DUP (floating-point)
;

; Don't use SVE for 64-bit vectors.
define <4 x half> @splat_v4f16(half %a) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.4h, v0.h[0]
; CHECK-NEXT:    ret
  %insert = insertelement <4 x half> undef, half %a, i64 0
  %splat = shufflevector <4 x half> %insert, <4 x half> undef, <4 x i32> zeroinitializer
  ret <4 x half> %splat
}

; Don't use SVE for 128-bit vectors.
define <8 x half> @splat_v8f16(half %a) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.8h, v0.h[0]
; CHECK-NEXT:    ret
  %insert = insertelement <8 x half> undef, half %a, i64 0
  %splat = shufflevector <8 x half> %insert, <8 x half> undef, <8 x i32> zeroinitializer
  ret <8 x half> %splat
}

define void @splat_v16f16(half %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    ptrue p0.h, vl16
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <16 x half> undef, half %a, i64 0
  %splat = shufflevector <16 x half> %insert, <16 x half> undef, <16 x i32> zeroinitializer
  store <16 x half> %splat, ptr %b
  ret void
}

define void @splat_v32f16(half %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: splat_v32f16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov z0.h, h0
; VBITS_GE_256-NEXT:    ptrue p0.h, vl16
; VBITS_GE_256-NEXT:    mov x8, #16 // =0x10
; VBITS_GE_256-NEXT:    st1h { z0.h }, p0, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    st1h { z0.h }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: splat_v32f16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    mov z0.h, h0
; VBITS_GE_512-NEXT:    ptrue p0.h, vl32
; VBITS_GE_512-NEXT:    st1h { z0.h }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %insert = insertelement <32 x half> undef, half %a, i64 0
  %splat = shufflevector <32 x half> %insert, <32 x half> undef, <32 x i32> zeroinitializer
  store <32 x half> %splat, ptr %b
  ret void
}

define void @splat_v64f16(half %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: splat_v64f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    ptrue p0.h, vl64
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <64 x half> undef, half %a, i64 0
  %splat = shufflevector <64 x half> %insert, <64 x half> undef, <64 x i32> zeroinitializer
  store <64 x half> %splat, ptr %b
  ret void
}

define void @splat_v128f16(half %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: splat_v128f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    ptrue p0.h, vl128
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <128 x half> undef, half %a, i64 0
  %splat = shufflevector <128 x half> %insert, <128 x half> undef, <128 x i32> zeroinitializer
  store <128 x half> %splat, ptr %b
  ret void
}

; Don't use SVE for 64-bit vectors.
define <2 x float> @splat_v2f32(float %a, <2 x float> %op2) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.2s, v0.s[0]
; CHECK-NEXT:    ret
  %insert = insertelement <2 x float> undef, float %a, i64 0
  %splat = shufflevector <2 x float> %insert, <2 x float> undef, <2 x i32> zeroinitializer
  ret <2 x float> %splat
}

; Don't use SVE for 128-bit vectors.
define <4 x float> @splat_v4f32(float %a, <4 x float> %op2) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.4s, v0.s[0]
; CHECK-NEXT:    ret
  %insert = insertelement <4 x float> undef, float %a, i64 0
  %splat = shufflevector <4 x float> %insert, <4 x float> undef, <4 x i32> zeroinitializer
  ret <4 x float> %splat
}

define void @splat_v8f32(float %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, s0
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <8 x float> undef, float %a, i64 0
  %splat = shufflevector <8 x float> %insert, <8 x float> undef, <8 x i32> zeroinitializer
  store <8 x float> %splat, ptr %b
  ret void
}

define void @splat_v16f32(float %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: splat_v16f32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov z0.s, s0
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    mov x8, #8 // =0x8
; VBITS_GE_256-NEXT:    st1w { z0.s }, p0, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    st1w { z0.s }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: splat_v16f32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    mov z0.s, s0
; VBITS_GE_512-NEXT:    ptrue p0.s, vl16
; VBITS_GE_512-NEXT:    st1w { z0.s }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %insert = insertelement <16 x float> undef, float %a, i64 0
  %splat = shufflevector <16 x float> %insert, <16 x float> undef, <16 x i32> zeroinitializer
  store <16 x float> %splat, ptr %b
  ret void
}

define void @splat_v32f32(float %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: splat_v32f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, s0
; CHECK-NEXT:    ptrue p0.s, vl32
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <32 x float> undef, float %a, i64 0
  %splat = shufflevector <32 x float> %insert, <32 x float> undef, <32 x i32> zeroinitializer
  store <32 x float> %splat, ptr %b
  ret void
}

define void @splat_v64f32(float %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: splat_v64f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, s0
; CHECK-NEXT:    ptrue p0.s, vl64
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <64 x float> undef, float %a, i64 0
  %splat = shufflevector <64 x float> %insert, <64 x float> undef, <64 x i32> zeroinitializer
  store <64 x float> %splat, ptr %b
  ret void
}

; Don't use SVE for 64-bit vectors.
define <1 x double> @splat_v1f64(double %a, <1 x double> %op2) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %insert = insertelement <1 x double> undef, double %a, i64 0
  %splat = shufflevector <1 x double> %insert, <1 x double> undef, <1 x i32> zeroinitializer
  ret <1 x double> %splat
}

; Don't use SVE for 128-bit vectors.
define <2 x double> @splat_v2f64(double %a, <2 x double> %op2) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.2d, v0.d[0]
; CHECK-NEXT:    ret
  %insert = insertelement <2 x double> undef, double %a, i64 0
  %splat = shufflevector <2 x double> %insert, <2 x double> undef, <2 x i32> zeroinitializer
  ret <2 x double> %splat
}

define void @splat_v4f64(double %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: splat_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, d0
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <4 x double> undef, double %a, i64 0
  %splat = shufflevector <4 x double> %insert, <4 x double> undef, <4 x i32> zeroinitializer
  store <4 x double> %splat, ptr %b
  ret void
}

define void @splat_v8f64(double %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: splat_v8f64:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    mov z0.d, d0
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    mov x8, #4 // =0x4
; VBITS_GE_256-NEXT:    st1d { z0.d }, p0, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    st1d { z0.d }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: splat_v8f64:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    mov z0.d, d0
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    st1d { z0.d }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %insert = insertelement <8 x double> undef, double %a, i64 0
  %splat = shufflevector <8 x double> %insert, <8 x double> undef, <8 x i32> zeroinitializer
  store <8 x double> %splat, ptr %b
  ret void
}

define void @splat_v16f64(double %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: splat_v16f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, d0
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <16 x double> undef, double %a, i64 0
  %splat = shufflevector <16 x double> %insert, <16 x double> undef, <16 x i32> zeroinitializer
  store <16 x double> %splat, ptr %b
  ret void
}

define void @splat_v32f64(double %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: splat_v32f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, d0
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <32 x double> undef, double %a, i64 0
  %splat = shufflevector <32 x double> %insert, <32 x double> undef, <32 x i32> zeroinitializer
  store <32 x double> %splat, ptr %b
  ret void
}

;
; DUP (integer immediate)
;

define void @splat_imm_v64i8(ptr %a) vscale_range(4,0) #0 {
; CHECK-LABEL: splat_imm_v64i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.b, #1 // =0x1
; CHECK-NEXT:    ptrue p0.b, vl64
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <64 x i8> undef, i8 1, i64 0
  %splat = shufflevector <64 x i8> %insert, <64 x i8> undef, <64 x i32> zeroinitializer
  store <64 x i8> %splat, ptr %a
  ret void
}

define void @splat_imm_v32i16(ptr %a) vscale_range(4,0) #0 {
; CHECK-LABEL: splat_imm_v32i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #2 // =0x2
; CHECK-NEXT:    ptrue p0.h, vl32
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <32 x i16> undef, i16 2, i64 0
  %splat = shufflevector <32 x i16> %insert, <32 x i16> undef, <32 x i32> zeroinitializer
  store <32 x i16> %splat, ptr %a
  ret void
}

define void @splat_imm_v16i32(ptr %a) vscale_range(4,0) #0 {
; CHECK-LABEL: splat_imm_v16i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, #3 // =0x3
; CHECK-NEXT:    ptrue p0.s, vl16
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <16 x i32> undef, i32 3, i64 0
  %splat = shufflevector <16 x i32> %insert, <16 x i32> undef, <16 x i32> zeroinitializer
  store <16 x i32> %splat, ptr %a
  ret void
}

define void @splat_imm_v8i64(ptr %a) vscale_range(4,0) #0 {
; CHECK-LABEL: splat_imm_v8i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, #4 // =0x4
; CHECK-NEXT:    ptrue p0.d, vl8
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <8 x i64> undef, i64 4, i64 0
  %splat = shufflevector <8 x i64> %insert, <8 x i64> undef, <8 x i32> zeroinitializer
  store <8 x i64> %splat, ptr %a
  ret void
}

;
; DUP (floating-point immediate)
;

define void @splat_imm_v32f16(ptr %a) vscale_range(4,0) #0 {
; CHECK-LABEL: splat_imm_v32f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov z0.h, #5.00000000
; CHECK-NEXT:    ptrue p0.h, vl32
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <32 x half> undef, half 5.0, i64 0
  %splat = shufflevector <32 x half> %insert, <32 x half> undef, <32 x i32> zeroinitializer
  store <32 x half> %splat, ptr %a
  ret void
}

define void @splat_imm_v16f32(ptr %a) vscale_range(4,0) #0 {
; CHECK-LABEL: splat_imm_v16f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov z0.s, #6.00000000
; CHECK-NEXT:    ptrue p0.s, vl16
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <16 x float> undef, float 6.0, i64 0
  %splat = shufflevector <16 x float> %insert, <16 x float> undef, <16 x i32> zeroinitializer
  store <16 x float> %splat, ptr %a
  ret void
}

define void @splat_imm_v8f64(ptr %a) vscale_range(4,0) #0 {
; CHECK-LABEL: splat_imm_v8f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov z0.d, #7.00000000
; CHECK-NEXT:    ptrue p0.d, vl8
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %insert = insertelement <8 x double> undef, double 7.0, i64 0
  %splat = shufflevector <8 x double> %insert, <8 x double> undef, <8 x i32> zeroinitializer
  store <8 x double> %splat, ptr %a
  ret void
}

define void @load_splat_v8f32(ptr %a, ptr %b) vscale_range(2,2) #0 {
; CHECK-LABEL: load_splat_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    mov z0.s, s0
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %v = load <8 x float>, ptr %a
  %splat = shufflevector <8 x float> %v, <8 x float> undef, <8 x i32> zeroinitializer
  store <8 x float> %splat, ptr %b
  ret void
}

define void @load_splat_v4f64(ptr %a, ptr %b) vscale_range(2,2) #0 {
; CHECK-LABEL: load_splat_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    mov z0.d, d0
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %v = load <4 x double>, ptr %a
  %splat = shufflevector <4 x double> %v, <4 x double> undef, <4 x i32> zeroinitializer
  store <4 x double> %splat, ptr %b
  ret void
}

define void @load_splat_v32i8(ptr %a, ptr %b) vscale_range(2,2) #0 {
; CHECK-LABEL: load_splat_v32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    mov z0.b, b0
; CHECK-NEXT:    st1b { z0.b }, p0, [x1]
; CHECK-NEXT:    ret
  %v = load <32 x i8>, ptr %a
  %splat = shufflevector <32 x i8> %v, <32 x i8> undef, <32 x i32> zeroinitializer
  store <32 x i8> %splat, ptr %b
  ret void
}

define void @load_splat_v16i16(ptr %a, ptr %b) vscale_range(2,2) #0 {
; CHECK-LABEL: load_splat_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    st1h { z0.h }, p0, [x1]
; CHECK-NEXT:    ret
  %v = load <16 x i16>, ptr %a
  %splat = shufflevector <16 x i16> %v, <16 x i16> undef, <16 x i32> zeroinitializer
  store <16 x i16> %splat, ptr %b
  ret void
}

define void @load_splat_v8i32(ptr %a, ptr %b) vscale_range(2,2) #0 {
; CHECK-LABEL: load_splat_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    mov z0.s, s0
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %v = load <8 x i32>, ptr %a
  %splat = shufflevector <8 x i32> %v, <8 x i32> undef, <8 x i32> zeroinitializer
  store <8 x i32> %splat, ptr %b
  ret void
}

define void @load_splat_v4i64(ptr %a, ptr %b) vscale_range(2,2) #0 {
; CHECK-LABEL: load_splat_v4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    mov z0.d, d0
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %v = load <4 x i64>, ptr %a
  %splat = shufflevector <4 x i64> %v, <4 x i64> undef, <4 x i32> zeroinitializer
  store <4 x i64> %splat, ptr %b
  ret void
}

attributes #0 = { "target-features"="+sve" }
