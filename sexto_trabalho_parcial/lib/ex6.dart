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
      title: 'Exercício 6',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroUsuario(),
    );
  }
}

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({super.key});

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  String mensagem = '';
  bool sucesso = false;

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  void salvar() {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final senha = senhaController.text;
    final confirmarSenha = confirmarSenhaController.text;

    if (nome.isEmpty) {
      mostrarMensagem('Nome é obrigatório.');
      return;
    }

    if (nome.length < 3 || nome.length > 50) {
      mostrarMensagem('Nome deve possuir entre 3 e 50 caracteres.');
      return;
    }

    if (email.isEmpty) {
      mostrarMensagem('E-mail é obrigatório.');
      return;
    }

    if (!email.contains('@')) {
      mostrarMensagem('E-mail deve conter @.');
      return;
    }

    final posicaoArroba = email.indexOf('@');

    if (email.indexOf('.', posicaoArroba + 1) == -1) {
      mostrarMensagem(
        'E-mail deve conter pelo menos um ponto após o @.',
      );
      return;
    }

    if (senha.isEmpty) {
      mostrarMensagem('Senha é obrigatória.');
      return;
    }

    if (senha.length < 6 || senha.length > 20) {
      mostrarMensagem(
        'Senha deve possuir entre 6 e 20 caracteres.',
      );
      return;
    }

    if (confirmarSenha.isEmpty) {
      mostrarMensagem('Confirmar senha é obrigatório.');
      return;
    }

    if (senha != confirmarSenha) {
      mostrarMensagem('As senhas são diferentes.');
      return;
    }

    setState(() {
      mensagem = 'Usuário cadastrado com sucesso';
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
        title: const Text('Cadastro de Usuário'),
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
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: confirmarSenhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar senha',
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