import 'package:flutter/material.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  final nota1 = TextEditingController();
  final nota2 = TextEditingController();
  final recuperacao = TextEditingController();

  bool temRecuperacao = false;
  String resultado = '';

  void calcular() {
    double n1 = double.parse(nota1.text);
    double n2 = double.parse(nota2.text);

    double media = (n1 + n2) / 2;

    if (temRecuperacao) {
      double rec = double.parse(recuperacao.text);
      media = (media + rec) / 2;
    }

    setState(() {
      resultado = media >= 6
          ? 'Aprovado (${media.toStringAsFixed(1)})'
          : 'Reprovado (${media.toStringAsFixed(1)})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Média do Aluno')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nota1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nota 1'),
            ),
            TextField(
              controller: nota2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nota 2'),
            ),
            CheckboxListTile(
              title: const Text('Tem recuperação?'),
              value: temRecuperacao,
              onChanged: (value) {
                setState(() {
                  temRecuperacao = value!;
                });
              },
            ),
            if (temRecuperacao)
              TextField(
                controller: recuperacao,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Recuperação'),
              ),
            ElevatedButton(onPressed: calcular, child: const Text('Calcular')),
            const SizedBox(height: 20),
            Text(resultado),
          ],
        ),
      ),
    );
  }
}
