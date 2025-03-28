; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-none-linux-gnu -mattr=+sve | FileCheck %s

define <2 x i64> @test_mul_add_2x64(<2 x i64> %a, <2 x i64> %b, <2 x i64> %c) {
; CHECK-LABEL: test_mul_add_2x64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    mla z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    ret
  %mul = mul <2 x i64> %b, %c
  %add = add <2 x i64> %a, %mul
  ret <2 x i64> %add
}

define <1 x i64> @test_mul_add_1x64(<1 x i64> %a, <1 x i64> %b, <1 x i64> %c) {
; CHECK-LABEL: test_mul_add_1x64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    mla z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    ret
  %mul = mul <1 x i64> %b, %c
  %add = add <1 x i64> %mul, %a
  ret <1 x i64> %add
}

define <2 x i64> @test_mul_sub_2x64(<2 x i64> %a, <2 x i64> %b, <2 x i64> %c) {
; CHECK-LABEL: test_mul_sub_2x64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    mls z0.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    ret
  %mul = mul <2 x i64> %b, %c
  %sub = sub <2 x i64> %a, %mul
  ret <2 x i64> %sub
}

define <2 x i64> @test_mul_sub_2x64_2(<2 x i64> %a, <2 x i64> %b, <2 x i64> %c, <2 x i64> %d) {
; CHECK-LABEL: test_mul_sub_2x64_2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    sdiv z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    movprfx z1, z2
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z3.d
; CHECK-NEXT:    sub v0.2d, v1.2d, v0.2d
; CHECK-NEXT:    ret
  %div = sdiv <2 x i64> %a, %b
  %mul = mul <2 x i64> %c, %d
  %sub = sub <2 x i64> %mul, %div
  ret <2 x i64> %sub
}

define <2 x i64> @test_mul_sub_2x64_3(<2 x i64> %a, <2 x i64> %b, <2 x i64> %c, <2 x i64> %d) {
; CHECK-LABEL: test_mul_sub_2x64_3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl2
; CHECK-NEXT:    sdiv z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    mls z0.d, p0/m, z2.d, z3.d
; CHECK-NEXT:    ret
  %div = sdiv <2 x i64> %a, %b
  %mul = mul <2 x i64> %c, %d
  %sub = sub <2 x i64> %div, %mul
  ret <2 x i64> %sub
}

define <1 x i64> @test_mul_sub_1x64(<1 x i64> %a, <1 x i64> %b, <1 x i64> %c) {
; CHECK-LABEL: test_mul_sub_1x64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl1
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z2.d
; CHECK-NEXT:    sub d0, d1, d0
; CHECK-NEXT:    ret
  %mul = mul <1 x i64> %b, %c
  %sub = sub <1 x i64> %mul, %a
  ret <1 x i64> %sub
}
