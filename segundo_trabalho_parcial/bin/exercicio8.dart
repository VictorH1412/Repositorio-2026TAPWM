import 'dart:io';

void main() {
  stdout.write("Consumo (kWh): ");
  double consumo = double.parse(stdin.readLineSync()!);

  double valorKwh;

  if (consumo <= 100) {
    valorKwh = 0.80;
  } else if (consumo <= 300) {
    valorKwh = 1.10;
  } else if (consumo <= 500) {
    valorKwh = 1.40;
  } else {
    valorKwh = 1.80;
  }

  double valorBase = consumo * valorKwh;
  double taxaExtra = 0;

  if (consumo > 400) {
    taxaExtra = valorBase * 0.10;
  }

  double total = valorBase + taxaExtra;

  print("Consumo: $consumo kWh");
  print("Valor base: R\$ ${valorBase.toStringAsFixed(2)}");
  print("Taxa extra: R\$ ${taxaExtra.toStringAsFixed(2)}");
  print("Total: R\$ ${total.toStringAsFixed(2)}");
}