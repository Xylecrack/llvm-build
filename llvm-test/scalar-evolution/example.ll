; ModuleID = 'example.ll'
source_filename = "example.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

define dso_local void @foo(ptr noundef %0, i32 noundef %1) {
  br label %3

3:                                                ; preds = %5, %2
  %.0 = phi i32 [ 0, %2 ], [ %16, %5 ]
  %4 = icmp slt i32 %.0, %1
  br i1 %4, label %5, label %17

5:                                                ; preds = %3
  %6 = zext nneg i32 %.0 to i64
  %7 = getelementptr inbounds i32, ptr %0, i64 %6
  store i32 %.0, ptr %7, align 4
  %8 = add nuw nsw i32 %.0, 1
  %9 = zext nneg i32 %.0 to i64
  %10 = getelementptr inbounds i32, ptr %0, i64 %9
  %11 = getelementptr inbounds i8, ptr %10, i64 4
  store i32 %8, ptr %11, align 4
  %12 = add nuw nsw i32 %.0, 2
  %13 = zext nneg i32 %.0 to i64
  %14 = getelementptr inbounds i32, ptr %0, i64 %13
  %15 = getelementptr inbounds i8, ptr %14, i64 8
  store i32 %12, ptr %15, align 4
  %16 = add nuw nsw i32 %.0, 3
  br label %3

17:                                               ; preds = %3
  ret void
}
