import 'dart:io';

void main() {
  stdout.write("Distância percorrida: ");
  var entrada = stdin.readLineSync();

  double metros = double.parse(entrada!);

  String resultado;

  if (metros > 1500) {
    resultado = "R\$ 15000";
  } else if (metros >= 800) {
    resultado = "R\$ 10000";
  } else {
    resultado = "R\$ 5000";
  }

  print("Prêmio recebido: $resultado");
}