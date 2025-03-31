 #include <stdio.h>

int esPar(int numero) {
  return numero % 2 == 0;
}

int contarPares(int numeros[], int tamanio) {
  int i, contador = 0;

  for (i=0; i < tamanio; i++) {
    if(esPar(numeros[i]))
      contador++;
  }

  return contador;
}


int main() {
    int a[]= {2,2,4,4,2,6,6,8,6,2};
    int j = contarPares(a, 10);

    printf("%d", j);

    return 0;
}