import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício 1',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroVeiculo(),
    );
  }
}

class CadastroVeiculo extends StatefulWidget {
  const CadastroVeiculo({super.key});

  @override
  State<CadastroVeiculo> createState() => _CadastroVeiculoState();
}

class _CadastroVeiculoState extends State<CadastroVeiculo> {
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final anoController = TextEditingController();
  final precoController = TextEditingController();

  String mensagem = '';
  bool sucesso = false;

  @override
  void dispose() {
    marcaController.dispose();
    modeloController.dispose();
    anoController.dispose();
    precoController.dispose();
    super.dispose();
  }

  void salvar() {
    final marca = marcaController.text.trim();
    final modelo = modeloController.text.trim();
    final anoTexto = anoController.text.trim();
    final precoTexto = precoController.text.trim();

    setState(() {
      mensagem = '';
      sucesso = false;
    });

    if (marca.isEmpty) {
      mostrarMensagem('Marca é obrigatória.');
      return;
    }

    if (marca.length < 2 || marca.length > 50) {
      mostrarMensagem('Marca deve possuir entre 2 e 50 caracteres.');
      return;
    }

    if (modelo.isEmpty) {
      mostrarMensagem('Modelo é obrigatório.');
      return;
    }

    if (modelo.length < 2 || modelo.length > 50) {
      mostrarMensagem('Modelo deve possuir entre 2 e 50 caracteres.');
      return;
    }

    if (anoTexto.isEmpty) {
      mostrarMensagem('Ano é obrigatório.');
      return;
    }

    final ano = int.tryParse(anoTexto);

    if (ano == null) {
      mostrarMensagem('Ano deve ser um número inteiro.');
      return;
    }

    if (ano < 1900 || ano > 2026) {
      mostrarMensagem('Ano deve estar entre 1900 e 2026.');
      return;
    }

    if (precoTexto.isEmpty) {
      mostrarMensagem('Preço é obrigatório.');
      return;
    }

    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(precoTexto)) {
      mostrarMensagem('Preço deve possuir no máximo duas casas decimais.');
      return;
    }

    final preco = double.tryParse(precoTexto.replaceAll(',', '.'));

    if (preco == null) {
      mostrarMensagem('Preço deve ser um número decimal válido.');
      return;
    }

    if (preco < 1000 || preco > 1000000) {
      mostrarMensagem(
        'Preço deve estar entre R\$ 1.000,00 e R\$ 1.000.000,00.',
      );
      return;
    }

    setState(() {
      mensagem = 'Veículo salvo com sucesso';
      sucesso = true;
    });
  }

  void mostrarMensagem(String texto) {
    setState(() {
      mensagem = texto;
      sucesso = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Veículo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: marcaController,
              decoration: const InputDecoration(
                labelText: 'Marca',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: modeloController,
              decoration: const InputDecoration(
                labelText: 'Modelo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: anoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ano',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: precoController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Preço',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: salvar,
              child: const Text('Salvar'),
            ),

            const SizedBox(height: 20),

            if (mensagem.isNotEmpty)
              Text(
                mensagem,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: sucesso ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}