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
      home: const CadastroContaBancaria(),
    );
  }
}

class CadastroContaBancaria extends StatefulWidget {
  const CadastroContaBancaria({super.key});

  @override
  State<CadastroContaBancaria> createState() => _CadastroContaBancariaState();
}

class _CadastroContaBancariaState extends State<CadastroContaBancaria> {
  final _formKey = GlobalKey<FormState>();

  final nomeTitularController = TextEditingController();
  final numeroBancoController = TextEditingController();
  final agenciaController = TextEditingController();
  final numeroContaController = TextEditingController();
  final saldoInicialController = TextEditingController();

  @override
  void dispose() {
    nomeTitularController.dispose();
    numeroBancoController.dispose();
    agenciaController.dispose();
    numeroContaController.dispose();
    saldoInicialController.dispose();
    super.dispose();
  }

  String? validarNomeTitular(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Nome do titular é obrigatório.';
    if (texto.length < 3 || texto.length > 80) {
      return 'Nome do titular deve possuir entre 3 e 80 caracteres.';
    }
    return null;
  }

  String? validarNumeroBanco(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Número do banco é obrigatório.';
    if (!RegExp(r'^\d+$').hasMatch(texto)) {
      return 'Número do banco deve conter apenas números.';
    }
    if (int.tryParse(texto) == null) {
      return 'Número do banco deve ser um número inteiro válido.';
    }
    if (texto.length != 3) {
      return 'Número do banco deve possuir exatamente 3 dígitos.';
    }
    return null;
  }

  String? validarAgencia(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Agência é obrigatória.';
    if (!RegExp(r'^\d+$').hasMatch(texto)) {
      return 'Agência deve conter apenas números.';
    }
    if (int.tryParse(texto) == null) {
      return 'Agência deve ser um número inteiro válido.';
    }
    if (texto.length < 4 || texto.length > 5) {
      return 'Agência deve possuir entre 4 e 5 dígitos.';
    }
    return null;
  }

  String? validarNumeroConta(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Número da conta é obrigatório.';
    if (!RegExp(r'^\d+$').hasMatch(texto)) {
      return 'Número da conta deve conter apenas números.';
    }
    if (int.tryParse(texto) == null) {
      return 'Número da conta deve ser um número inteiro válido.';
    }
    if (texto.length < 5 || texto.length > 10) {
      return 'Número da conta deve possuir entre 5 e 10 dígitos.';
    }
    return null;
  }

  String? validarSaldoInicial(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Saldo inicial é obrigatório.';
    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(texto)) {
      return 'Saldo inicial deve possuir no máximo duas casas decimais.';
    }
    final saldo = double.tryParse(texto.replaceAll(',', '.'));
    if (saldo == null) return 'Saldo inicial deve ser um valor decimal válido.';
    if (saldo < 0) return 'Saldo inicial não pode ser negativo.';
    if (saldo > 1000000) {
      return 'Saldo inicial deve ser no máximo R\$ 1.000.000,00.';
    }
    return null;
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta bancária cadastrada com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Conta Bancária')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeTitularController,
                decoration: const InputDecoration(
                  labelText: 'Nome do titular',
                  border: OutlineInputBorder(),
                ),
                validator: validarNomeTitular,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: numeroBancoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Número do banco',
                  border: OutlineInputBorder(),
                ),
                validator: validarNumeroBanco,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: agenciaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Agência',
                  border: OutlineInputBorder(),
                ),
                validator: validarAgencia,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: numeroContaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Número da conta',
                  border: OutlineInputBorder(),
                ),
                validator: validarNumeroConta,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: saldoInicialController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Saldo inicial',
                  border: OutlineInputBorder(),
                ),
                validator: validarSaldoInicial,
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
