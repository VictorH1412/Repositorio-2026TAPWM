import 'dart:math';
import 'package:flutter/material.dart';

class AdivinhePage extends StatefulWidget {
  const AdivinhePage({super.key});

  @override
  State<AdivinhePage> createState() => _AdivinhePageState();
}

class _AdivinhePageState extends State<AdivinhePage> {
  final palpiteController = TextEditingController();

  final int numeroSecreto = Random().nextInt(100) + 1;

  int tentativas = 0;
  String mensagem = '';

  void tentar() {
    int palpite = int.parse(palpiteController.text);

    tentativas++;

    setState(() {
      if (palpite < numeroSecreto) {
        mensagem = 'Maior';
      } else if (palpite > numeroSecreto) {
        mensagem = 'Menor';
      } else {
        mensagem = 'Acertou!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adivinhe o Número')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: palpiteController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Digite um número'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: tentar, child: const Text('Tentar')),
            const SizedBox(height: 20),
            Text(mensagem),
            Text('Tentativas: $tentativas'),
          ],
        ),
      ),
    );
  }
}
