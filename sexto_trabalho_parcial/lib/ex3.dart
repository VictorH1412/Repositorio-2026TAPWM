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
      title: 'Exercício 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroAluno(),
    );
  }
}

class CadastroAluno extends StatefulWidget {
  const CadastroAluno({super.key});

  @override
  State<CadastroAluno> createState() => _CadastroAlunoState();
}

class _CadastroAlunoState extends State<CadastroAluno> {
  final nomeController = TextEditingController();
  final idadeController = TextEditingController();
  final emailController = TextEditingController();

  String mensagem = '';
  bool sucesso = false;

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void salvar() {
    final nome = nomeController.text.trim();
    final idadeTexto = idadeController.text.trim();
    final email = emailController.text.trim();

    if (nome.isEmpty) {
      mostrarMensagem('Nome é obrigatório.');
      return;
    }

    if (nome.length < 3 || nome.length > 50) {
      mostrarMensagem('Nome deve possuir entre 3 e 50 caracteres.');
      return;
    }

    if (idadeTexto.isEmpty) {
      mostrarMensagem('Idade é obrigatória.');
      return;
    }

    final idade = int.tryParse(idadeTexto);

    if (idade == null) {
      mostrarMensagem('Idade deve ser um número inteiro.');
      return;
    }

    if (idade < 10 || idade > 100) {
      mostrarMensagem('Idade deve estar entre 10 e 100.');
      return;
    }

    if (email.isEmpty) {
      mostrarMensagem('E-mail é obrigatório.');
      return;
    }

    if (!email.contains('@')) {
      mostrarMensagem('E-mail deve conter o caractere @.');
      return;
    }

    setState(() {
      mensagem = 'Aluno salvo com sucesso';
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
        title: const Text('Cadastro de Aluno'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: idadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Idade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
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