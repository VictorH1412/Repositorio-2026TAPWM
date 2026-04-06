import 'dart:io';

void main() {
  stdout.write("Digite o preço do produto: ");
  double preco = double.parse(stdin.readLineSync()!);

  stdout.write("Digite o código de origem (1 a 5): ");
  int codigo = int.parse(stdin.readLineSync()!);

  double porcentagem;

  switch (codigo) {
    case 1:
      porcentagem = 0.05;
      break;
    case 2:
      porcentagem = 0.15;
      break;
    case 3:
      porcentagem = 0.07;
      break;
    case 4:
      porcentagem = 0.12;
      break;
    case 5:
      porcentagem = 0.20;
      break;
    default:
      porcentagem = 0;
  }

  double desconto = preco * porcentagem;
  double valorFinal = preco - desconto;

  print("Desconto aplicado: R\$ ${desconto.toStringAsFixed(2)}");
  print("Valor final: R\$ ${valorFinal.toStringAsFixed(2)}");
}