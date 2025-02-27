; ModuleID = 'scev3.ll'
source_filename = "scev3.ll"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

define dso_local i32 @main() {
  br label %1

1:                                                ; preds = %11, %0
  %.0 = phi i32 [ 19, %0 ], [ %.1, %11 ]
  %2 = icmp sgt i32 %.0, 1
  br i1 %2, label %3, label %12

3:                                                ; preds = %1
  %4 = and i32 %.0, 1
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %8

6:                                                ; preds = %3
  %7 = sdiv i32 %.0, 2
  br label %11

8:                                                ; preds = %3
  %9 = mul nsw i32 %.0, 3
  %10 = add nsw i32 %9, 1
  br label %11

11:                                               ; preds = %8, %6
  %.1 = phi i32 [ %7, %6 ], [ %10, %8 ]
  br label %1

12:                                               ; preds = %1
  %13 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %.0)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...)
