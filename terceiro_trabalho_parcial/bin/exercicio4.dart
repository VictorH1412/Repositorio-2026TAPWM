import 'dart:io';

void main() {
  int num = 1;
  int soma = 0;
  int count = 0;

  while (num != 0) {
    num = int.parse(stdin.readLineSync()!);

    if (num != 0) {
      soma += num;
      count++;
    }
  }

  print("Soma: $soma");
  print("Quantidade: $count");
}