import 'dart:io';

void main() {
  int op;

  do {
    print("1 -Somar");
    print("2 - Subtrair");
    print("0 -Sair");

    op = int.parse(stdin.readLineSync()!);

  } while (op != 0);
}