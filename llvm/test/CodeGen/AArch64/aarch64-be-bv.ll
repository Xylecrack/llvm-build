; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64_be--linux-gnu < %s | FileCheck %s

@vec_v8i16 = dso_local global <8 x i16> <i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8>

define dso_local void @movi_modimm_t1() nounwind {
; CHECK-LABEL: movi_modimm_t1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.4s, #1
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 1, i16 0, i16 1, i16 0, i16 1, i16 0, i16 1, i16 0>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @movi_modimm_t2() nounwind {
; CHECK-LABEL: movi_modimm_t2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.4s, #1, lsl #8
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 256, i16 0, i16 256, i16 0, i16 256, i16 0, i16 256, i16 0>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @movi_modimm_t3() nounwind {
; CHECK-LABEL: movi_modimm_t3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.4s, #1, lsl #16
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 0, i16 1, i16 0, i16 1, i16 0, i16 1, i16 0, i16 1>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @movi_modimm_t4() nounwind {
; CHECK-LABEL: movi_modimm_t4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.4s, #1, lsl #24
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 0, i16 256, i16 0, i16 256, i16 0, i16 256, i16 0, i16 256>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @movi_modimm_t5() nounwind {
; CHECK-LABEL: movi_modimm_t5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8h, #1
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @movi_modimm_t6() nounwind {
; CHECK-LABEL: movi_modimm_t6:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8h, #1, lsl #8
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 256, i16 256, i16 256, i16 256, i16 256, i16 256, i16 256, i16 256>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @movi_modimm_t7() nounwind {
; CHECK-LABEL: movi_modimm_t7:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.4s, #1, msl #8
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 511, i16 0, i16 511, i16 0, i16 511, i16 0, i16 511, i16 0>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @movi_modimm_t8() nounwind {
; CHECK-LABEL: movi_modimm_t8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.4s, #1, msl #16
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 65535, i16 1, i16 65535, i16 1, i16 65535, i16 1, i16 65535, i16 1>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @movi_modimm_t9() nounwind {
; CHECK-LABEL: movi_modimm_t9:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.16b, #1
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257, i16 257>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @movi_modimm_t10() nounwind {
; CHECK-LABEL: movi_modimm_t10:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0x00ffff0000ffff
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 -1, i16 0, i16 -1, i16 0, i16 -1, i16 0, i16 -1, i16 0>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @fmov_modimm_t11() nounwind {
; CHECK-LABEL: fmov_modimm_t11:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v0.4s, #3.00000000
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 0, i16 16448, i16 0, i16 16448, i16 0, i16 16448, i16 0, i16 16448>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @fmov_modimm_t12() nounwind {
; CHECK-LABEL: fmov_modimm_t12:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v0.2d, #0.17968750
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v1.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v1.8h, v0.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 0, i16 0, i16 0, i16 16327, i16 0, i16 0, i16 0, i16 16327>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @mvni_modimm_t1() nounwind {
; CHECK-LABEL: mvni_modimm_t1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    mvni v1.4s, #1
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 65534, i16 65535, i16 65534, i16 65535, i16 65534, i16 65535, i16 65534, i16 65535>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @mvni_modimm_t2() nounwind {
; CHECK-LABEL: mvni_modimm_t2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    mvni v1.4s, #1, lsl #8
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 65279, i16 65535, i16 65279, i16 65535, i16 65279, i16 65535, i16 65279, i16 65535>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @mvni_modimm_t3() nounwind {
; CHECK-LABEL: mvni_modimm_t3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    mvni v1.4s, #1, lsl #16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 65535, i16 65534, i16 65535, i16 65534, i16 65535, i16 65534, i16 65535, i16 65534>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @mvni_modimm_t4() nounwind {
; CHECK-LABEL: mvni_modimm_t4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    mvni v1.4s, #1, lsl #24
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 65535, i16 65279, i16 65535, i16 65279, i16 65535, i16 65279, i16 65535, i16 65279>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @mvni_modimm_t5() nounwind {
; CHECK-LABEL: mvni_modimm_t5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    mvni v1.8h, #1
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @mvni_modimm_t6() nounwind {
; CHECK-LABEL: mvni_modimm_t6:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    mvni v1.8h, #1, lsl #8
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 65279, i16 65279, i16 65279, i16 65279, i16 65279, i16 65279, i16 65279, i16 65279>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @mvni_modimm_t7() nounwind {
; CHECK-LABEL: mvni_modimm_t7:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    mvni v1.4s, #1, msl #8
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 65024, i16 65535, i16 65024, i16 65535, i16 65024, i16 65535, i16 65024, i16 65535>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @mvni_modimm_t8() nounwind {
; CHECK-LABEL: mvni_modimm_t8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    mvni v1.4s, #1, msl #16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    add v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = add <8 x i16> %in, <i16 0, i16 65534, i16 0, i16 65534, i16 0, i16 65534, i16 0, i16 65534>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @bic_modimm_t1() nounwind {
; CHECK-LABEL: bic_modimm_t1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    bic v0.4s, #1
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = and <8 x i16> %in, <i16 65534, i16 65535, i16 65534, i16 65535, i16 65534, i16 65535, i16 65534, i16 65535>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @bic_modimm_t2() nounwind {
; CHECK-LABEL: bic_modimm_t2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    bic v0.4s, #1, lsl #8
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = and <8 x i16> %in, <i16 65279, i16 65535, i16 65279, i16 65535, i16 65279, i16 65535, i16 65279, i16 65535>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @bic_modimm_t3() nounwind {
; CHECK-LABEL: bic_modimm_t3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    bic v0.4s, #1, lsl #16
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = and <8 x i16> %in, <i16 65535, i16 65534, i16 65535, i16 65534, i16 65535, i16 65534, i16 65535, i16 65534>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @bic_modimm_t4() nounwind {
; CHECK-LABEL: bic_modimm_t4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    bic v0.4s, #1, lsl #24
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = and <8 x i16> %in, <i16 65535, i16 65279, i16 65535, i16 65279, i16 65535, i16 65279, i16 65535, i16 65279>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @bic_modimm_t5() nounwind {
; CHECK-LABEL: bic_modimm_t5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    bic v0.8h, #1
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = and <8 x i16> %in, <i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @bic_modimm_t6() nounwind {
; CHECK-LABEL: bic_modimm_t6:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    bic v0.8h, #1, lsl #8
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = and <8 x i16> %in, <i16 65279, i16 65279, i16 65279, i16 65279, i16 65279, i16 65279, i16 65279, i16 65279>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @orr_modimm_t1() nounwind {
; CHECK-LABEL: orr_modimm_t1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    orr v0.4s, #1
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = or <8 x i16> %in, <i16 1, i16 0, i16 1, i16 0, i16 1, i16 0, i16 1, i16 0>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @orr_modimm_t2() nounwind {
; CHECK-LABEL: orr_modimm_t2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    orr v0.4s, #1, lsl #8
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = or <8 x i16> %in, <i16 256, i16 0, i16 256, i16 0, i16 256, i16 0, i16 256, i16 0>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @orr_modimm_t3() nounwind {
; CHECK-LABEL: orr_modimm_t3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    orr v0.4s, #1, lsl #16
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = or <8 x i16> %in, <i16 0, i16 1, i16 0, i16 1, i16 0, i16 1, i16 0, i16 1>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @orr_modimm_t4() nounwind {
; CHECK-LABEL: orr_modimm_t4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    orr v0.4s, #1, lsl #24
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = or <8 x i16> %in, <i16 0, i16 256, i16 0, i16 256, i16 0, i16 256, i16 0, i16 256>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @orr_modimm_t5() nounwind {
; CHECK-LABEL: orr_modimm_t5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    orr v0.8h, #1
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = or <8 x i16> %in, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

define dso_local void @orr_modimm_t6() nounwind {
; CHECK-LABEL: orr_modimm_t6:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, vec_v8i16
; CHECK-NEXT:    add x8, x8, :lo12:vec_v8i16
; CHECK-NEXT:    ld1 { v0.8h }, [x8]
; CHECK-NEXT:    orr v0.8h, #1, lsl #8
; CHECK-NEXT:    st1 { v0.8h }, [x8]
; CHECK-NEXT:    ret
  %in = load <8 x i16>, ptr @vec_v8i16
  %rv = or <8 x i16> %in, <i16 256, i16 256, i16 256, i16 256, i16 256, i16 256, i16 256, i16 256>
  store <8 x i16> %rv, ptr @vec_v8i16
  ret void
}

declare i8 @f_v8i8(<8 x i8> %arg)
declare i16 @f_v4i16(<4 x i16> %arg)
declare i32 @f_v2i32(<2 x i32> %arg)
declare i64 @f_v1i64(<1 x i64> %arg)
declare i8 @f_v16i8(<16 x i8> %arg)
declare i16 @f_v8i16(<8 x i16> %arg)
declare i32 @f_v4i32(<4 x i32> %arg)
declare i64 @f_v2i64(<2 x i64> %arg)

define dso_local void @modimm_t1_call() {
; CHECK-LABEL: modimm_t1_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2s, #8
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    movi v0.2s, #7
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    movi v0.2s, #6
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    movi v0.2s, #5
; CHECK-NEXT:    bl f_v1i64
; CHECK-NEXT:    movi v0.4s, #5
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    movi v0.4s, #4
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    movi v0.4s, #3
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    movi v0.4s, #2
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v2i64
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 8, i8 0, i8 0, i8 0, i8 8, i8 0, i8 0, i8 0>)
  call i16 @f_v4i16(<4 x i16> <i16 7, i16 0, i16 7, i16 0>)
  call i32 @f_v2i32(<2 x i32> <i32 6, i32 6>)
  call i64 @f_v1i64(<1 x i64> <i64 21474836485>)
  call i8 @f_v16i8(<16 x i8> <i8 5, i8 0, i8 0, i8 0, i8 5, i8 0, i8 0, i8 0, i8 5, i8 0, i8 0, i8 0, i8 5, i8 0, i8 0, i8 0>)
  call i16 @f_v8i16(<8 x i16> <i16 4, i16 0, i16 4, i16 0, i16 4, i16 0, i16 4, i16 0>)
  call i32 @f_v4i32(<4 x i32> <i32 3, i32 3, i32 3, i32 3>)
  call i64 @f_v2i64(<2 x i64> <i64 8589934594, i64 8589934594>)

  ret void
}

define dso_local void @modimm_t2_call() {
; CHECK-LABEL: modimm_t2_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2s, #8, lsl #8
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    movi v0.2s, #7, lsl #8
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    movi v0.2s, #6, lsl #8
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    movi v0.2s, #5, lsl #8
; CHECK-NEXT:    bl f_v1i64
; CHECK-NEXT:    movi v0.4s, #5, lsl #8
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    movi v0.4s, #4, lsl #8
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    movi v0.4s, #3, lsl #8
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    movi v0.4s, #2, lsl #8
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v2i64
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 0, i8 8, i8 0, i8 0, i8 0, i8 8, i8 0, i8 0>)
  call i16 @f_v4i16(<4 x i16> <i16 1792, i16 0, i16 1792, i16 0>)
  call i32 @f_v2i32(<2 x i32> <i32 1536, i32 1536>)
  call i64 @f_v1i64(<1 x i64> <i64 5497558140160>)
  call i8 @f_v16i8(<16 x i8> <i8 0, i8 5, i8 0, i8 0, i8 0, i8 5, i8 0, i8 0, i8 0, i8 5, i8 0, i8 0, i8 0, i8 5, i8 0, i8 0>)
  call i16 @f_v8i16(<8 x i16> <i16 1024, i16 0, i16 1024, i16 0, i16 1024, i16 0, i16 1024, i16 0>)
  call i32 @f_v4i32(<4 x i32> <i32 768, i32 768, i32 768, i32 768>)
  call i64 @f_v2i64(<2 x i64> <i64 2199023256064, i64 2199023256064>)

  ret void
}

define dso_local void @modimm_t3_call() {
; CHECK-LABEL: modimm_t3_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2s, #8, lsl #16
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    movi v0.2s, #7, lsl #16
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    movi v0.2s, #6, lsl #16
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    movi v0.2s, #5, lsl #16
; CHECK-NEXT:    bl f_v1i64
; CHECK-NEXT:    movi v0.4s, #5, lsl #16
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    movi v0.4s, #4, lsl #16
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    movi v0.4s, #3, lsl #16
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    movi v0.4s, #2, lsl #16
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v2i64
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 0, i8 0, i8 8, i8 0, i8 0, i8 0, i8 8, i8 0>)
  call i16 @f_v4i16(<4 x i16> <i16 0, i16 7, i16 0, i16 7>)
  call i32 @f_v2i32(<2 x i32> <i32 393216, i32 393216>)
  call i64 @f_v1i64(<1 x i64> <i64 1407374883880960>)
  call i8 @f_v16i8(<16 x i8> <i8 0, i8 0, i8 5, i8 0, i8 0, i8 0, i8 5, i8 0, i8 0, i8 0, i8 5, i8 0, i8 0, i8 0, i8 5, i8 0>)
  call i16 @f_v8i16(<8 x i16> <i16 0, i16 4, i16 0, i16 4, i16 0, i16 4, i16 0, i16 4>)
  call i32 @f_v4i32(<4 x i32> <i32 196608, i32 196608, i32 196608, i32 196608>)
  call i64 @f_v2i64(<2 x i64> <i64 562949953552384, i64 562949953552384>)

  ret void
}

define dso_local void @modimm_t4_call() {
; CHECK-LABEL: modimm_t4_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2s, #8, lsl #24
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    movi v0.2s, #7, lsl #24
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    movi v0.2s, #6, lsl #24
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    movi v0.2s, #5, lsl #24
; CHECK-NEXT:    bl f_v1i64
; CHECK-NEXT:    movi v0.4s, #5, lsl #24
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    movi v0.4s, #4, lsl #24
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    movi v0.4s, #3, lsl #24
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    movi v0.4s, #2, lsl #24
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v2i64
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 0, i8 0, i8 0, i8 8, i8 0, i8 0, i8 0, i8 8>)
  call i16 @f_v4i16(<4 x i16> <i16 0, i16 1792, i16 0, i16 1792>)
  call i32 @f_v2i32(<2 x i32> <i32 100663296, i32 100663296>)
  call i64 @f_v1i64(<1 x i64> <i64 360287970273525760>)
  call i8 @f_v16i8(<16 x i8> <i8 0, i8 0, i8 0, i8 5, i8 0, i8 0, i8 0, i8 5, i8 0, i8 0, i8 0, i8 5, i8 0, i8 0, i8 0, i8 5>)
  call i16 @f_v8i16(<8 x i16> <i16 0, i16 1024, i16 0, i16 1024, i16 0, i16 1024, i16 0, i16 1024>)
  call i32 @f_v4i32(<4 x i32> <i32 50331648, i32 50331648, i32 50331648, i32 50331648>)
  call i64 @f_v2i64(<2 x i64> <i64 144115188109410304, i64 144115188109410304>)

  ret void
}

define dso_local void @modimm_t5_call() {
; CHECK-LABEL: modimm_t5_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.4h, #8
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    movi v0.4h, #7
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    movi v0.4h, #6
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    movi v0.4h, #5
; CHECK-NEXT:    bl f_v1i64
; CHECK-NEXT:    movi v0.8h, #5
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    movi v0.8h, #4
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    movi v0.8h, #3
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    movi v0.8h, #2
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v2i64
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 8, i8 0, i8 8, i8 0, i8 8, i8 0, i8 8, i8 0>)
  call i16 @f_v4i16(<4 x i16> <i16 7, i16 7, i16 7, i16 7>)
  call i32 @f_v2i32(<2 x i32> <i32 393222, i32 393222>)
  call i64 @f_v1i64(<1 x i64> <i64 1407396358717445>)
  call i8 @f_v16i8(<16 x i8> <i8 5, i8 0, i8 5, i8 0, i8 5, i8 0, i8 5, i8 0, i8 5, i8 0, i8 5, i8 0, i8 5, i8 0, i8 5, i8 0>)
  call i16 @f_v8i16(<8 x i16> <i16 4, i16 4, i16 4, i16 4, i16 4, i16 4, i16 4, i16 4>)
  call i32 @f_v4i32(<4 x i32> <i32 196611, i32 196611, i32 196611, i32 196611>)
  call i64 @f_v2i64(<2 x i64> <i64 562958543486978, i64 562958543486978>)

  ret void
}

define dso_local void @modimm_t6_call() {
; CHECK-LABEL: modimm_t6_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.4h, #8, lsl #8
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    movi v0.4h, #7, lsl #8
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    movi v0.4h, #6, lsl #8
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    movi v0.4h, #5, lsl #8
; CHECK-NEXT:    bl f_v1i64
; CHECK-NEXT:    movi v0.8h, #5, lsl #8
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    movi v0.8h, #4, lsl #8
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    movi v0.8h, #3, lsl #8
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    movi v0.8h, #2, lsl #8
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v2i64
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 0, i8 8, i8 0, i8 8, i8 0, i8 8, i8 0, i8 8>)
  call i16 @f_v4i16(<4 x i16> <i16 1792, i16 1792, i16 1792, i16 1792>)
  call i32 @f_v2i32(<2 x i32> <i32 100664832, i32 100664832>)
  call i64 @f_v1i64(<1 x i64> <i64 360293467831665920>)
  call i8 @f_v16i8(<16 x i8> <i8 0, i8 5, i8 0, i8 5, i8 0, i8 5, i8 0, i8 5, i8 0, i8 5, i8 0, i8 5, i8 0, i8 5, i8 0, i8 5>)
  call i16 @f_v8i16(<8 x i16> <i16 1024, i16 1024, i16 1024, i16 1024, i16 1024, i16 1024, i16 1024, i16 1024>)
  call i32 @f_v4i32(<4 x i32> <i32 50332416, i32 50332416, i32 50332416, i32 50332416>)
  call i64 @f_v2i64(<2 x i64> <i64 144117387132666368, i64 144117387132666368>)

  ret void
}

define dso_local void @modimm_t7_call() {
; CHECK-LABEL: modimm_t7_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2s, #8, msl #8
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    movi v0.2s, #7, msl #8
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    movi v0.2s, #6, msl #8
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    movi v0.2s, #5, msl #8
; CHECK-NEXT:    bl f_v1i64
; CHECK-NEXT:    movi v0.4s, #5, msl #8
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    movi v0.4s, #4, msl #8
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    movi v0.4s, #3, msl #8
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    movi v0.4s, #2, msl #8
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v2i64
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 255, i8 8, i8 0, i8 0, i8 255, i8 8, i8 0, i8 0>)
  call i16 @f_v4i16(<4 x i16> <i16 2047, i16 0, i16 2047, i16 0>)
  call i32 @f_v2i32(<2 x i32> <i32 1791, i32 1791>)
  call i64 @f_v1i64(<1 x i64> <i64 6592774800895>)
  call i8 @f_v16i8(<16 x i8> <i8 255, i8 5, i8 0, i8 0, i8 255, i8 5, i8 0, i8 0, i8 255, i8 5, i8 0, i8 0, i8 255, i8 5, i8 0, i8 0>)
  call i16 @f_v8i16(<8 x i16> <i16 1279, i16 0, i16 1279, i16 0, i16 1279, i16 0, i16 1279, i16 0>)
  call i32 @f_v4i32(<4 x i32> <i32 1023, i32 1023, i32 1023, i32 1023>)
  call i64 @f_v2i64(<2 x i64> <i64 3294239916799, i64 3294239916799>)

  ret void
}

define dso_local void @modimm_t8_call() {
; CHECK-LABEL: modimm_t8_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.2s, #8, msl #16
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    movi v0.2s, #7, msl #16
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    movi v0.2s, #6, msl #16
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    movi v0.2s, #5, msl #16
; CHECK-NEXT:    bl f_v1i64
; CHECK-NEXT:    movi v0.4s, #5, msl #16
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    movi v0.4s, #4, msl #16
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    movi v0.4s, #3, msl #16
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    movi v0.4s, #2, msl #16
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v2i64
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 255, i8 255, i8 8, i8 0, i8 255, i8 255, i8 8, i8 0>)
  call i16 @f_v4i16(<4 x i16> <i16 65535, i16 7, i16 65535, i16 7>)
  call i32 @f_v2i32(<2 x i32> <i32 458751, i32 458751>)
  call i64 @f_v1i64(<1 x i64> <i64 1688845565689855>)
  call i8 @f_v16i8(<16 x i8> <i8 255, i8 255, i8 5, i8 0, i8 255, i8 255, i8 5, i8 0, i8 255, i8 255, i8 5, i8 0, i8 255, i8 255, i8 5, i8 0>)
  call i16 @f_v8i16(<8 x i16> <i16 65535, i16 4, i16 65535, i16 4, i16 65535, i16 4, i16 65535, i16 4>)
  call i32 @f_v4i32(<4 x i32> <i32 262143, i32 262143, i32 262143, i32 262143>)
  call i64 @f_v2i64(<2 x i64> <i64 844420635361279, i64 844420635361279>)

  ret void
}

define dso_local void @modimm_t9_call() {
; CHECK-LABEL: modimm_t9_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi v0.8b, #8
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    movi v0.8b, #7
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    movi v0.8b, #6
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    movi v0.16b, #5
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    movi v0.16b, #4
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    movi v0.16b, #3
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8>)
  call i16 @f_v4i16(<4 x i16> <i16 1799, i16 1799, i16 1799, i16 1799>)
  call i32 @f_v2i32(<2 x i32> <i32 101058054, i32 101058054>)
  call i8 @f_v16i8(<16 x i8> <i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5, i8 5>)
  call i16 @f_v8i16(<8 x i16> <i16 1028, i16 1028, i16 1028, i16 1028, i16 1028, i16 1028, i16 1028, i16 1028>)
  call i32 @f_v4i32(<4 x i32> <i32 50529027, i32 50529027, i32 50529027, i32 50529027>)

  ret void
}

define dso_local void @modimm_t10_call() {
; CHECK-LABEL: modimm_t10_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    movi d0, #0x0000ff000000ff
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    movi d0, #0x00ffff0000ffff
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    movi v0.2d, #0xffffffffffffffff
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    movi v0.2d, #0xffffff00ffffff
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    movi v0.2d, #0xffffffffffff0000
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    movi v0.2d, #0xffffffff00000000
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 -1, i8 0, i8 0, i8 0, i8 -1, i8 0, i8 0, i8 0>)
  call i16 @f_v4i16(<4 x i16> <i16 -1, i16 0, i16 -1, i16 0>)
  call i32 @f_v2i32(<2 x i32> <i32 -1, i32 -1>)
  call i8 @f_v16i8(<16 x i8> <i8 -1, i8 -1, i8 -1, i8 0, i8 -1, i8 -1, i8 -1, i8 0, i8 -1, i8 -1, i8 -1, i8 0, i8 -1, i8 -1, i8 -1, i8 0>)
  call i16 @f_v8i16(<8 x i16> <i16 0, i16 -1, i16 -1, i16 -1, i16 0, i16 -1, i16 -1, i16 -1>)
  call i32 @f_v4i32(<4 x i32> <i32 0, i32 -1, i32 0, i32 -1>)

  ret void
}

define dso_local void @modimm_t11_call() {
; CHECK-LABEL: modimm_t11_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    fmov v0.2s, #4.00000000
; CHECK-NEXT:    rev64 v0.8b, v0.8b
; CHECK-NEXT:    bl f_v8i8
; CHECK-NEXT:    fmov v0.2s, #3.75000000
; CHECK-NEXT:    rev64 v0.4h, v0.4h
; CHECK-NEXT:    bl f_v4i16
; CHECK-NEXT:    fmov v0.2s, #3.50000000
; CHECK-NEXT:    rev64 v0.2s, v0.2s
; CHECK-NEXT:    bl f_v2i32
; CHECK-NEXT:    fmov v0.2s, #0.39062500
; CHECK-NEXT:    bl f_v1i64
; CHECK-NEXT:    fmov v0.4s, #3.25000000
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    fmov v0.4s, #3.00000000
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    fmov v0.4s, #2.75000000
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    fmov v0.4s, #2.50000000
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v2i64
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v8i8(<8 x i8> <i8 0, i8 0, i8 128, i8 64, i8 0, i8 0, i8 128, i8 64>)
  call i16 @f_v4i16(<4 x i16> <i16 0, i16 16496, i16 0, i16 16496>)
  call i32 @f_v2i32(<2 x i32> <i32 1080033280, i32 1080033280>)
  call i64 @f_v1i64(<1 x i64> <i64 4523865826746957824>)
  call i8 @f_v16i8(<16 x i8> <i8 0, i8 0, i8 80, i8 64, i8 0, i8 0, i8 80, i8 64, i8 0, i8 0, i8 80, i8 64, i8 0, i8 0, i8 80, i8 64>)
  call i16 @f_v8i16(<8 x i16> <i16 0, i16 16448, i16 0, i16 16448, i16 0, i16 16448, i16 0, i16 16448>)
  call i32 @f_v4i32(<4 x i32> <i32 1076887552, i32 1076887552, i32 1076887552, i32 1076887552>)
  call i64 @f_v2i64(<2 x i64> <i64 4620693218757967872, i64 4620693218757967872>)

  ret void
}

define dso_local void @modimm_t12_call() {
; CHECK-LABEL: modimm_t12_call:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    fmov v0.2d, #0.18750000
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v16i8
; CHECK-NEXT:    fmov v0.2d, #0.17968750
; CHECK-NEXT:    rev64 v0.8h, v0.8h
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v8i16
; CHECK-NEXT:    fmov v0.2d, #0.17187500
; CHECK-NEXT:    rev64 v0.4s, v0.4s
; CHECK-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    bl f_v4i32
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  call i8 @f_v16i8(<16 x i8> <i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 200, i8 63, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 200, i8 63>)
  call i16 @f_v8i16(<8 x i16> <i16 0, i16 0, i16 0, i16 16327, i16 0, i16 0, i16 0, i16 16327>)
  call i32 @f_v4i32(<4 x i32> <i32 0, i32 1069940736, i32 0, i32 1069940736>)

  ret void
}

define <2 x double> @test_v1f64(<1 x double> %0, ptr %1) {
; CHECK-LABEL: test_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v1.2s, #31, msl #16
; CHECK-NEXT:    mov v1.d[1], v0.d[0]
; CHECK-NEXT:    ext v0.16b, v1.16b, v1.16b, #8
; CHECK-NEXT:    ret
  %vec = shufflevector <1 x double> <double 0xFFE00000FFE00000>, <1 x double> %0, <2 x i32> <i32 0, i32 1>
  ret <2 x double> %vec
}
