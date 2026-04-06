import 'dart:io';

void main() {
  stdout.write("Digite o nome do estado: ");
  String estado = stdin.readLineSync()!.toLowerCase();

  String regiao = "";

  if (["acre", "amapá", "amazonas", "pará", "rondônia", "roraima", "tocantins"].contains(estado)) {
    regiao = "Norte";
  } 
  else if (["alagoas", "bahia", "ceará", "maranhão", "paraíba", "pernambuco", "piauí", "rio grande do norte", "sergipe"].contains(estado)) {
    regiao = "Nordeste";
  } 
  else if (["goiás", "mato grosso", "mato grosso do sul", "distrito federal"].contains(estado)) {
    regiao = "Centro-Oeste";
  } 
  else if (["espírito santo", "minas gerais", "rio de janeiro", "são paulo"].contains(estado)) {
    regiao = "Sudeste";
  } 
  else if (["paraná", "rio grande do sul", "santa catarina"].contains(estado)) {
    regiao = "Sul";
  } 
  else {
    print("Estado não reconhecido.");
    return;
  }

  print("Região: $regiao");
}