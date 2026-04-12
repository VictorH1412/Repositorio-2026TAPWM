import 'dart:io';

void main() {
  int N = int.parse(stdin.readLineSync()!);

  for (int i = N; i >= 0; i-) {
    print(i);
  }
}