import 'dart:io';

void main() {
  print('digite o valor ganho por hora:');
  double valorHora = double.parse(stdin.readLineSync()!);

  print('digite o número de horas trabalhadas no mês;');
  double horas = double.parse(stdin.readLineSync()!);

  double salario = valorHora*horas;

  print('salário mensal: R\$ $salario');
}