void foo(int a[], int n) {
  int i;
  for (i = 0; i < n; i += 3) { //{0,+,3}
    a[i] = i;                  // {0,+,3}
    a[i + 1] = i + 1;          //{1,+,3}
    a[i + 2] = i + 2;          //{2,+,3}
  }
}