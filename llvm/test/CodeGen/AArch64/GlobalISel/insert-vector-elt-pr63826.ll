; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -o - -verify-machineinstrs -global-isel=1 -global-isel-abort=1 | FileCheck %s --check-prefixes=CHECK
; RUN: llc < %s -o - -verify-machineinstrs -global-isel=0 | FileCheck %s --check-prefixes=CHECK

target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-ios14.5.0"

define <2 x i16> @pr63826_v2s16(<2 x i16> %vec) {
; CHECK-LABEL: pr63826_v2s16:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w8, #1 ; =0x1
; CHECK-NEXT:    mov.s v0[0], w8
; CHECK-NEXT:    ret
  %vec1 = insertelement <2 x i16> %vec, i16 1, i32 0
  ret <2 x i16> %vec1
}

define <2 x i8> @pr63826_v2s8(<2 x i8> %vec) {
; CHECK-LABEL: pr63826_v2s8:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w8, #1 ; =0x1
; CHECK-NEXT:    mov.s v0[0], w8
; CHECK-NEXT:    ret
  %vec1 = insertelement <2 x i8> %vec, i8 1, i32 0
  ret <2 x i8> %vec1
}

define <4 x i8> @pr63826_v4s8(<4 x i8> %vec) {
; CHECK-LABEL: pr63826_v4s8:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    mov w8, #1 ; =0x1
; CHECK-NEXT:    mov.h v0[0], w8
; CHECK-NEXT:    ret
  %vec1 = insertelement <4 x i8> %vec, i8 1, i32 0
  ret <4 x i8> %vec1
}
