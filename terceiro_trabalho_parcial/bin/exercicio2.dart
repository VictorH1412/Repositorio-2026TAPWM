import 'dart:io';

void main() {
  int N = int.parse(stdin.readLineSync()!);
  int soma = 0;

  for (int i = 1; i <= N; i++) {
    soma += i;
  }

  print("Soma: $soma");
}