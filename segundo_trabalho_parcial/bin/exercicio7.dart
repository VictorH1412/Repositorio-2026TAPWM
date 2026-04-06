import 'dart:io';

void main() {
  stdout.write("Tipo (1-Gasolina comum, 2-Premium, 3-Diesel, 4-Álcool): ");
  int tipo = int.parse(stdin.readLineSync()!);

  stdout.write("Litros: ");
  double litros = double.parse(stdin.readLineSync()!);

  Map<int, Map<String, dynamic>> tabela = {
    1: {"nome": "Gasolina comum", "preco": 6.50},
    2: {"nome": "Gasolina premium", "preco": 7.80},
    3: {"nome": "Diesel", "preco": 5.90},
    4: {"nome": "Álcool", "preco": 4.20},
  };

  if (!tabela.containsKey(tipo)) {
    print("Combustível inválido.");
    return;
  }

  var dados = tabela[tipo]!;

  double precoUnit = dados["preco"];
  double total = precoUnit * litros;

  print("Combustível: ${dados["nome"]}");
  print("Litros: $litros");
  print("Preço por litro: R\$ ${precoUnit.toStringAsFixed(2)}");
  print("Total: R\$ ${total.toStringAsFixed(2)}");
}