 #include <stdio.h>

int f(int a[], int b) {
  int i, j = 0;

  for (i=0; i < b; i++) {
    if(a[i] % 2 == 0){
      j = j + 1;
    }
  }

  return j;
}

int main() {
    int a[]= {1,2,3,4,5,6,7,8,9,10};
    int j = f(a, 10);

    printf("%d", j);

    return 0;
}