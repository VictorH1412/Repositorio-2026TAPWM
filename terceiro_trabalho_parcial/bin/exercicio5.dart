import 'dart:io';

void main() {
  int num = 1;
  int pares = 0;
  int impares = 0;

  while (num != 0) {
    num = int.parse(stdin.readLineSync()!);

    if (num != 0) {
      if (num % 2 == 0) {
        pares++;
      } else {
        impares++;
      }
    }
  }

  print("Pares: $pares");
  print("Ímpares: $impares");
}