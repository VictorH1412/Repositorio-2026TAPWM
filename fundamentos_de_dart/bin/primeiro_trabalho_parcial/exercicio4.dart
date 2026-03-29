import 'dart:io';

void main() {
  print('digite o valor do depósito:');
  double deposito = double.parse(stdin.readLineSync()!);

  double rendimento = deposito * 0.005;
  double total = deposito + rendimento;

  print('valor após 1 mês: R\$ $total');
}