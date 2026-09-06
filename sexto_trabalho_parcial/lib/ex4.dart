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
      title: 'Exercício 4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroLivro(),
    );
  }
}

class CadastroLivro extends StatefulWidget {
  const CadastroLivro({super.key});

  @override
  State<CadastroLivro> createState() => _CadastroLivroState();
}

class _CadastroLivroState extends State<CadastroLivro> {
  final tituloController = TextEditingController();
  final autorController = TextEditingController();
  final paginasController = TextEditingController();
  final codigoController = TextEditingController();

  String mensagem = '';
  bool sucesso = false;

  @override
  void dispose() {
    tituloController.dispose();
    autorController.dispose();
    paginasController.dispose();
    codigoController.dispose();
    super.dispose();
  }

  void salvar() {
    final titulo = tituloController.text.trim();
    final autor = autorController.text.trim();
    final paginasTexto = paginasController.text.trim();
    final codigo = codigoController.text.trim();

    if (titulo.isEmpty) {
      mostrarMensagem('Título é obrigatório.');
      return;
    }

    if (titulo.length < 2 || titulo.length > 100) {
      mostrarMensagem('Título deve possuir entre 2 e 100 caracteres.');
      return;
    }

    if (autor.isEmpty) {
      mostrarMensagem('Autor é obrigatório.');
      return;
    }

    if (autor.length < 3 || autor.length > 100) {
      mostrarMensagem('Autor deve possuir entre 3 e 100 caracteres.');
      return;
    }

    if (paginasTexto.isEmpty) {
      mostrarMensagem('Número de páginas é obrigatório.');
      return;
    }

    final paginas = int.tryParse(paginasTexto);

    if (paginas == null) {
      mostrarMensagem(
        'Número de páginas deve aceitar apenas números inteiros.',
      );
      return;
    }

    if (paginas < 1 || paginas > 10000) {
      mostrarMensagem(
        'Número de páginas deve estar entre 1 e 10.000.',
      );
      return;
    }

    if (!RegExp(r'^[A-Za-z]{3}-\d{4}$').hasMatch(codigo)) {
      mostrarMensagem('Código deve seguir o formato ABC-1234.');
      return;
    }

    setState(() {
      mensagem = 'Livro salvo com sucesso';
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
        title: const Text('Cadastro de Livro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: autorController,
              decoration: const InputDecoration(
                labelText: 'Autor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: paginasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número de páginas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: codigoController,
              decoration: const InputDecoration(
                labelText: 'Código do livro (ABC-1234)',
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