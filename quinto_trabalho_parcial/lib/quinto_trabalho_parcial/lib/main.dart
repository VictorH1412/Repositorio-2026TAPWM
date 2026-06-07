import 'package:flutter/material.dart';
import 'imc_page.dart';
import 'temperatura_page.dart';
import 'media_page.dart';
import 'adivinhe_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atividade Flutter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Exercício 1 - IMC'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ImcPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Exercício 2 - Temperatura'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TemperaturaPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Exercício 3 - Média'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MediaPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Exercício 4 - Adivinhe'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AdivinhePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
