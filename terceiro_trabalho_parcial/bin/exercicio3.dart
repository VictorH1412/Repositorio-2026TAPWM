import 'dart:io';

void main() {
  int N = int.parse(stdin.readLineSync()!);
  int k = int.parse(stdin.readLineSync()!);

  int count = 0;

  for (int i = 1; i <= N; i++) {
    if (i % k == 0) {
      count++;
    }
  }

  print("Quantidade: $count");
}