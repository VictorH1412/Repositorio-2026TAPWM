import 'dart:io';

void main() {
  String palavra = "";
  int count = 0;

  while (palavra.toLowerCase() != "sair") {
    palavra = stdin.readLineSync()!;

    if (palavra.toLowerCase() != "sair") {
      count++;
    }
  }

  print("Quantidade: $count");
}