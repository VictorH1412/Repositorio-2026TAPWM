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
      home: const CadastroFuncionario(),
    );
  }
}

class CadastroFuncionario extends StatefulWidget {
  const CadastroFuncionario({super.key});

  @override
  State<CadastroFuncionario> createState() => _CadastroFuncionarioState();
}

class _CadastroFuncionarioState extends State<CadastroFuncionario> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final idadeController = TextEditingController();
  final salarioController = TextEditingController();
  final dependentesController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    idadeController.dispose();
    salarioController.dispose();
    dependentesController.dispose();
    super.dispose();
  }

  String? validarNome(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Nome é obrigatório.';
    if (texto.length < 3 || texto.length > 60) {
      return 'Nome deve possuir entre 3 e 60 caracteres.';
    }
    return null;
  }

  String? validarIdade(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Idade é obrigatória.';
    final idade = int.tryParse(texto);
    if (idade == null) return 'Idade deve ser um número inteiro.';
    if (idade < 18 || idade > 100) return 'Idade deve estar entre 18 e 100.';
    return null;
  }

  String? validarSalario(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Salário é obrigatório.';
    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(texto)) {
      return 'Salário deve possuir no máximo duas casas decimais.';
    }
    final salario = double.tryParse(texto.replaceAll(',', '.'));
    if (salario == null) return 'Salário deve ser um valor decimal válido.';
    if (salario < 1000 || salario > 50000) {
      return 'Salário deve estar entre R\$ 1.000,00 e R\$ 50.000,00.';
    }
    return null;
  }

  String? validarDependentes(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Quantidade de dependentes é obrigatória.';
    final dependentes = int.tryParse(texto);
    if (dependentes == null) {
      return 'Quantidade de dependentes deve ser um número inteiro.';
    }
    if (dependentes < 0 || dependentes > 10) {
      return 'Quantidade de dependentes deve estar entre 0 e 10.';
    }
    return null;
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Funcionário salvo com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Funcionário')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: validarNome,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(),
                ),
                validator: validarIdade,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: salarioController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Salário',
                  border: OutlineInputBorder(),
                ),
                validator: validarSalario,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: dependentesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade de dependentes',
                  border: OutlineInputBorder(),
                ),
                validator: validarDependentes,
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
