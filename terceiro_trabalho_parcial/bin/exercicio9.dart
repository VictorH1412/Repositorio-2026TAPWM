import 'dart:io';

void main() {
  String resp;

  do {
    print("Deseja continuar? (s/n)");
    resp = stdin.readLineSync()!;
  } while (resp.toLowerCase() == 's');

  print("Programa encerrado");
}