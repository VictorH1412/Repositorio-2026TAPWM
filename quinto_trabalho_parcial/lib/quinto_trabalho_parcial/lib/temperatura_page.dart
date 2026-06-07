import 'package:flutter/material.dart';

class TemperaturaPage extends StatefulWidget {
  const TemperaturaPage({super.key});

  @override
  State<TemperaturaPage> createState() => _TemperaturaPageState();
}

class _TemperaturaPageState extends State<TemperaturaPage> {
  final tempController = TextEditingController();

  String opcao = 'C→F';
  String resultado = '';

  void converter() {
    double temp = double.parse(tempController.text);

    setState(() {
      if (opcao == 'C→F') {
        resultado = '${((temp * 9 / 5) + 32).toStringAsFixed(2)} °F';
      } else {
        resultado = '${((temp - 32) * 5 / 9).toStringAsFixed(2)} °C';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de Temperatura')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: tempController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Temperatura'),
            ),
            DropdownButton<String>(
              value: opcao,
              items: const [
                DropdownMenuItem(value: 'C→F', child: Text('C→F')),
                DropdownMenuItem(value: 'F→C', child: Text('F→C')),
              ],
              onChanged: (value) {
                setState(() {
                  opcao = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: converter,
              child: const Text('Converter'),
            ),
            const SizedBox(height: 20),
            Text(resultado),
          ],
        ),
      ),
    );
  }
}
