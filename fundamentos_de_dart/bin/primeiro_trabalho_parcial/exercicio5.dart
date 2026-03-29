import 'dart:io';

void main() {
  print('digite o hodômetro inicial:');
  double inicio = double.parse(stdin.readLineSync()!);

  print('digite o hodômetro final:');
  double fim = double.parse(stdin.readLineSync()!);

  print('digite os litros de combustível consumidos:');
  double litros = double.parse(stdin.readLineSync()!);

  print('digite o valor total recebido:');
  double ganho = double.parse(stdin.readLineSync()!);

  double distancia = fim - inicio;
  double consumo = distancia / litros;

  double custoCombustivel = litros *6.50;
  double lucro = ganho - custoCombustivel;

  print('consumo médio: $consumo km/l');
  print('lucro líquido: R\$ $lucro');
}