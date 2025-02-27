@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 19, ptr %2, align 4
  br label %3

3:                                                ; preds = %17, %0
  %4 = load i32, ptr %2, align 4
  %5 = icmp sgt i32 %4, 1
  br i1 %5, label %6, label %18

6:                                                ; preds = %3
  %7 = load i32, ptr %2, align 4
  %8 = srem i32 %7, 2
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %10, label %13

10:                                               ; preds = %6
  %11 = load i32, ptr %2, align 4
  %12 = sdiv i32 %11, 2
  store i32 %12, ptr %2, align 4
  br label %17

13:                                               ; preds = %6
  %14 = load i32, ptr %2, align 4
  %15 = mul nsw i32 3, %14
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr %2, align 4
  br label %17

17:                                               ; preds = %13, %10
  br label %3

18:                                               ; preds = %3
  %19 = load i32, ptr %2, align 4
  %20 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %19)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1