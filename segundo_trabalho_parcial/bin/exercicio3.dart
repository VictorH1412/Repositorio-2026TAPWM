import 'dart:io';

void main() {
  stdout.write("Digite o código do lanche: ");
  int codigo = int.parse(stdin.readLineSync()!);

  stdout.write("Digite a quantidade: ");
  int qtd = int.parse(stdin.readLineSync()!);

  Map<int, double> cardapio = {
    101: 14.20,
    102: 12.30,
    103: 13.50,
    104: 10.20,
    105: 15.30,
    106: 10.00
  };

  if (!cardapio.containsKey(codigo)) {
    print("Código do lanche inválido");
    return;
  }

  double precoUnitario = cardapio[codigo]!;
  double total = precoUnitario * qtd;

  print("Total a pagar: R\$ ${total.toStringAsFixed(2)}");
}