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
      home: const CadastroCurso(),
    );
  }
}

class CadastroCurso extends StatefulWidget {
  const CadastroCurso({super.key});

  @override
  State<CadastroCurso> createState() => _CadastroCursoState();
}

class _CadastroCursoState extends State<CadastroCurso> {
  final _formKey = GlobalKey<FormState>();

  final nomeCursoController = TextEditingController();
  final codigoCursoController = TextEditingController();
  final cargaHorariaController = TextEditingController();
  final numeroVagasController = TextEditingController();

  @override
  void dispose() {
    nomeCursoController.dispose();
    codigoCursoController.dispose();
    cargaHorariaController.dispose();
    numeroVagasController.dispose();
    super.dispose();
  }

  String? validarNomeCurso(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Nome do curso é obrigatório.';
    if (texto.length < 5 || texto.length > 100) {
      return 'Nome do curso deve possuir entre 5 e 100 caracteres.';
    }
    return null;
  }

  String? validarCodigoCurso(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Código do curso é obrigatório.';
    if (!RegExp(r'^[A-Za-z]{3}-\d{4}$').hasMatch(texto)) {
      return 'Código deve seguir o formato ABC-1234.';
    }
    return null;
  }

  String? validarCargaHoraria(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Carga horária é obrigatória.';
    final carga = int.tryParse(texto);
    if (carga == null) return 'Carga horária deve ser um número inteiro.';
    if (carga < 20 || carga > 2000) {
      return 'Carga horária deve estar entre 20 e 2.000 horas.';
    }
    return null;
  }

  String? validarNumeroVagas(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Número de vagas é obrigatório.';
    final vagas = int.tryParse(texto);
    if (vagas == null) return 'Número de vagas deve ser um número inteiro.';
    if (vagas < 1 || vagas > 500) {
      return 'Número de vagas deve estar entre 1 e 500.';
    }
    return null;
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Curso cadastrado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Curso')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeCursoController,
                decoration: const InputDecoration(
                  labelText: 'Nome do curso',
                  border: OutlineInputBorder(),
                ),
                validator: validarNomeCurso,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: codigoCursoController,
                decoration: const InputDecoration(
                  labelText: 'Código do curso (ex: ABC-1234)',
                  border: OutlineInputBorder(),
                ),
                validator: validarCodigoCurso,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: cargaHorariaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Carga horária',
                  border: OutlineInputBorder(),
                ),
                validator: validarCargaHoraria,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: numeroVagasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Número de vagas',
                  border: OutlineInputBorder(),
                ),
                validator: validarNumeroVagas,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
