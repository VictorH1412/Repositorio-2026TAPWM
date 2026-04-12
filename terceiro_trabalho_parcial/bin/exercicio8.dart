import 'dart:io';

void main() {
  double nota;

  do {
    print("Digite uma nota (0 a 10):");
    nota = double.parse(stdin.readLineSync()!);
  } while (nota < 0 || nota >10);

  print("Nota válida: $nota");
}