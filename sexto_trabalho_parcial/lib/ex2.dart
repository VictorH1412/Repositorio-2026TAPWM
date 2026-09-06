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
      title: 'Exercício 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroFilme(),
    );
  }
}

class CadastroFilme extends StatefulWidget {
  const CadastroFilme({super.key});

  @override
  State<CadastroFilme> createState() => _CadastroFilmeState();
}

class _CadastroFilmeState extends State<CadastroFilme> {
  final nomeController = TextEditingController();
  final dataController = TextEditingController();
  final duracaoController = TextEditingController();

  String mensagem = '';
  bool sucesso = false;

  @override
  void dispose() {
    nomeController.dispose();
    dataController.dispose();
    duracaoController.dispose();
    super.dispose();
  }

  void salvar() {
    final nome = nomeController.text.trim();
    final data = dataController.text.trim();
    final duracaoTexto = duracaoController.text.trim();

    if (nome.isEmpty) {
      mostrarMensagem('Nome do filme é obrigatório.');
      return;
    }

    if (nome.length < 2 || nome.length > 100) {
      mostrarMensagem(
        'Nome do filme deve possuir entre 2 e 100 caracteres.',
      );
      return;
    }

    if (data.isEmpty) {
      mostrarMensagem('Data de lançamento é obrigatória.');
      return;
    }

    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(data)) {
      mostrarMensagem('Data deve estar no formato dd/mm/aaaa.');
      return;
    }

    if (duracaoTexto.isEmpty) {
      mostrarMensagem('Duração é obrigatória.');
      return;
    }

    final duracao = int.tryParse(duracaoTexto);

    if (duracao == null) {
      mostrarMensagem('Duração deve ser um número inteiro.');
      return;
    }

    if (duracao < 1 || duracao > 500) {
      mostrarMensagem('Duração deve estar entre 1 e 500 minutos.');
      return;
    }

    setState(() {
      mensagem = 'Filme salvo com sucesso';
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
        title: const Text('Cadastro de Filme'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do filme',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: dataController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: 'Data de lançamento (dd/mm/aaaa)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: duracaoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Duração em minutos',
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