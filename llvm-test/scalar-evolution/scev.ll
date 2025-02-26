@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1

define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [100 x i32], align 16
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %3, align 4
  br label %5

5:                                                ; preds = %24, %0
  %6 = load i32, ptr %3, align 4
  %7 = icmp slt i32 %6, 100
  br i1 %7, label %8, label %27

8:                                                ; preds = %5
  %9 = load i32, ptr %3, align 4
  %10 = add nsw i32 %9, 1
  %11 = load i32, ptr %3, align 4
  %12 = add nsw i32 %11, 1
  %13 = mul nsw i32 %10, %12
  %14 = load i32, ptr %3, align 4
  %15 = load i32, ptr %3, align 4
  %16 = mul nsw i32 %14, %15
  %17 = sub nsw i32 %13, %16
  %18 = load i32, ptr %3, align 4
  %19 = mul nsw i32 2, %18
  %20 = sub nsw i32 %17, %19
  %21 = load i32, ptr %3, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 %22
  store i32 %20, ptr %23, align 4
  br label %24

24:                                               ; preds = %8
  %25 = load i32, ptr %3, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %3, align 4
  br label %5

27:                                               ; preds = %5
  store i32 0, ptr %4, align 4
  br label %28

28:                                               ; preds = %37, %27
  %29 = load i32, ptr %4, align 4
  %30 = icmp slt i32 %29, 100
  br i1 %30, label %31, label %40

31:                                               ; preds = %28
  %32 = load i32, ptr %4, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [100 x i32], ptr %2, i64 0, i64 %33
  %35 = load i32, ptr %34, align 4
  %36 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %35)
  br label %37

37:                                               ; preds = %31
  %38 = load i32, ptr %4, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, ptr %4, align 4
  br label %28

40:                                               ; preds = %28
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1
