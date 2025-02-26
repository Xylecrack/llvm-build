; ModuleID = 'scev2.ll'
source_filename = "scev2.ll"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define dso_local i32 @main() {
  br label %1

1:                                                ; preds = %3, %0
  %.01 = phi i32 [ 0, %0 ], [ %7, %3 ]
  %.0 = phi i32 [ 0, %0 ], [ %8, %3 ]
  %2 = icmp ult i32 %.0, 10
  br i1 %2, label %3, label %9

3:                                                ; preds = %1
  %4 = add nuw i32 %.0, 2
  %5 = mul i32 %.0, %4
  %6 = add nsw i32 %5, 1
  %7 = add nsw i32 %.01, %6
  %8 = add nuw nsw i32 %.0, 1
  br label %1

9:                                                ; preds = %1
  %10 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %.01)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...)
