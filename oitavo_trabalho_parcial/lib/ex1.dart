import 'package:all_br_forms/all_br_forms.dart';
import 'package:all_br_validations/br_zod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

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
  final cpfController = TextEditingController();
  final idadeController = TextEditingController();
  final salarioController = TextEditingController();
  final dependentesController = TextEditingController();

  final _formatoMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    idadeController.dispose();
    salarioController.dispose();
    dependentesController.dispose();
    super.dispose();
  }

  // Regras que o validatorless/all_br_forms não cobrem (faixa numerica e
  // formato decimal) continuam com validacao propria, conforme permitido
  // pelo enunciado.
  String? validarIdade(String? value) {
    final texto = value?.trim() ?? '';
    final idade = int.tryParse(texto);
    if (idade == null) return 'Idade deve ser um número inteiro.';
    if (idade < 18 || idade > 100) return 'Idade deve estar entre 18 e 100.';
    return null;
  }

  String? validarSalario(String? value) {
    final texto = value?.trim() ?? '';
    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(texto)) {
      return 'Salário deve possuir no máximo duas casas decimais.';
    }
    final salario = double.tryParse(texto.replaceAll(',', '.'));
    if (salario == null) return 'Salário deve ser um valor decimal válido.';
    if (salario < 1000 || salario > 50000) {
      return 'Salário deve estar entre ${_formatoMoeda.format(1000)} e ${_formatoMoeda.format(50000)}.';
    }
    return null;
  }

  String? validarDependentes(String? value) {
    final texto = value?.trim() ?? '';
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
      final salario = double.parse(
        salarioController.text.trim().replaceAll(',', '.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Funcionário salvo com sucesso! Salário: ${_formatoMoeda.format(salario)}',
          ),
        ),
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
                validator: Validatorless.multiple([
                  Validatorless.required('Nome é obrigatório.'),
                  Validatorless.min(3, 'Nome deve possuir no mínimo 3 caracteres.'),
                  Validatorless.max(60, 'Nome deve possuir no máximo 60 caracteres.'),
                ]),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: cpfController,
                keyboardType: TextInputType.number,
                inputFormatters: const [CpfMask()],
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
                validator: BrZod().required().cpf().build,
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
