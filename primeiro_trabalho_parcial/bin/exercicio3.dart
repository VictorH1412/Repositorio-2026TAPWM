import 'dart:io';

void main() {
  print('digite a temperatura em Celsius:');
  double celsius = double.parse(stdin.readLineSync()!);

  double fahrenheit = (celsius *9/5) + 32;

  print('resultado: $celsius°C = $fahrenheit°F');
}