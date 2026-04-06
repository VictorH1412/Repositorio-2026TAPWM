import 'dart:io';

void main() {
  stdout.write("Digite o salário: ");
  double salario = double.parse(stdin.readLineSync()!);

  double taxa = calcularTaxa(salario);

  double imposto = salario * taxa;
  double liquido = salario - imposto;

  print("Salário bruto: R\$ ${salario.toStringAsFixed(2)}");
  print("Imposto: R\$ ${imposto.toStringAsFixed(2)}");
  print("Salário líquido: R\$ ${liquido.toStringAsFixed(2)}");
}

double calcularTaxa(double valor) {
  if (valor <= 2000) {
    return 0;
  } else if (valor <= 5000) {
    return 0.10;
  } else if (valor <= 10000) {
    return 0.15;
  } else {
    return 0.20;
  }
}