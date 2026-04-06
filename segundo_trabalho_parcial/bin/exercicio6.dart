import 'dart:io';

void main() {
  stdout.write("Digite o lanche: ");
  String lanche = stdin.readLineSync()!.toLowerCase();

  stdout.write("Digite a bebida: ");
  String bebida = stdin.readLineSync()!.toLowerCase();

  bool permitido = true;

  if (lanche == "bauru" && bebida == "guarana") {
    permitido = false;
  }

  if (lanche == "x-frango" && bebida == "agua") {
    permitido = false;
  }

  if (lanche == "pizza" && !(bebida == "vinho" || bebida == "agua")) {
    permitido = false;
  }

  print(permitido ? "Pedido permitido" : "Pedido não permitido");
}