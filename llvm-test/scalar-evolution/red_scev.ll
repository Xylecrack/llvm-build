; ModuleID = 'scev.ll'
source_filename = "scev.ll"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1

define dso_local i32 @main() {
  %1 = alloca [100 x i32], align 16
  br label %2

2:                                                ; preds = %4, %0
  %.01 = phi i32 [ 0, %0 ], [ %13, %4 ]
  %3 = icmp ult i32 %.01, 100
  br i1 %3, label %4, label %14

4:                                                ; preds = %2
  %5 = add nuw nsw i32 %.01, 1
  %6 = add nuw nsw i32 %.01, 1
  %7 = mul nsw i32 %5, %6
  %8 = add nuw i32 %.01, 2
  %9 = mul i32 %.01, %8
  %10 = sub i32 %7, %9
  %11 = zext i32 %.01 to i64
  %12 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 %11
  store i32 %10, ptr %12, align 4
  %13 = add nuw nsw i32 %.01, 1
  br label %2

14:                                               ; preds = %2, %16
  %.0 = phi i32 [ %21, %16 ], [ 0, %2 ]
  %15 = icmp ult i32 %.0, 100
  br i1 %15, label %16, label %22

16:                                               ; preds = %14
  %17 = zext i32 %.0 to i64
  %18 = getelementptr inbounds [100 x i32], ptr %1, i64 0, i64 %17
  %19 = load i32, ptr %18, align 4
  %20 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %19)
  %21 = add nuw nsw i32 %.0, 1
  br label %14

22:                                               ; preds = %14
  ret i32 0
}

declare i32 @printf(ptr noundef, ...)


