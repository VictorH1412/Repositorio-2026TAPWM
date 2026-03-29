import 'dart:io';

void main() {
  print('digite o valor em metros:');
  double metros = double.parse(stdin.readLineSync()!);

  double centimetros = metros*100;

  print('resultado: $metros metros = $centimetros centímetros');
}