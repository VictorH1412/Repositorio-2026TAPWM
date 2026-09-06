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
      title: 'Exercício 5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroEvento(),
    );
  }
}

class CadastroEvento extends StatefulWidget {
  const CadastroEvento({super.key});

  @override
  State<CadastroEvento> createState() => _CadastroEventoState();
}

class _CadastroEventoState extends State<CadastroEvento> {
  final nomeController = TextEditingController();
  final minimoController = TextEditingController();
  final maximoController = TextEditingController();
  final ingressoController = TextEditingController();

  String mensagem = '';
  bool sucesso = false;

  @override
  void dispose() {
    nomeController.dispose();
    minimoController.dispose();
    maximoController.dispose();
    ingressoController.dispose();
    super.dispose();
  }

  void salvar() {
    final nome = nomeController.text.trim();
    final minimoTexto = minimoController.text.trim();
    final maximoTexto = maximoController.text.trim();
    final ingressoTexto = ingressoController.text.trim();

    if (nome.isEmpty) {
      mostrarMensagem('Nome do evento é obrigatório.');
      return;
    }

    if (nome.length < 5 || nome.length > 100) {
      mostrarMensagem(
        'Nome do evento deve possuir entre 5 e 100 caracteres.',
      );
      return;
    }

    if (minimoTexto.isEmpty) {
      mostrarMensagem(
        'Quantidade mínima de participantes é obrigatória.',
      );
      return;
    }

    final minimo = int.tryParse(minimoTexto);

    if (minimo == null) {
      mostrarMensagem(
        'Quantidade mínima deve ser um número inteiro.',
      );
      return;
    }

    if (minimo < 1) {
      mostrarMensagem(
        'Quantidade mínima não pode ser menor que 1.',
      );
      return;
    }

    if (maximoTexto.isEmpty) {
      mostrarMensagem(
        'Quantidade máxima de participantes é obrigatória.',
      );
      return;
    }

    final maximo = int.tryParse(maximoTexto);

    if (maximo == null) {
      mostrarMensagem(
        'Quantidade máxima deve ser um número inteiro.',
      );
      return;
    }

    if (maximo < 1 || maximo > 50000) {
      mostrarMensagem(
        'Quantidade máxima deve estar entre 1 e 50.000.',
      );
      return;
    }

    if (maximo < minimo) {
      mostrarMensagem(
        'Quantidade máxima não pode ser menor que a quantidade mínima.',
      );
      return;
    }

    if (ingressoTexto.isEmpty) {
      mostrarMensagem('Valor do ingresso é obrigatório.');
      return;
    }

    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(ingressoTexto)) {
      mostrarMensagem(
        'Valor do ingresso deve possuir no máximo duas casas decimais.',
      );
      return;
    }

    final ingresso = double.tryParse(
      ingressoTexto.replaceAll(',', '.'),
    );

    if (ingresso == null) {
      mostrarMensagem(
        'Valor do ingresso deve ser um número decimal válido.',
      );
      return;
    }

    if (ingresso < 0 || ingresso > 10000) {
      mostrarMensagem(
        'Valor do ingresso deve estar entre R\$ 0,00 e R\$ 10.000,00.',
      );
      return;
    }

    setState(() {
      mensagem = 'Evento salvo com sucesso';
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
        title: const Text('Cadastro de Evento'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do evento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: minimoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade mínima de participantes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: maximoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade máxima de participantes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: ingressoController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Valor do ingresso',
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