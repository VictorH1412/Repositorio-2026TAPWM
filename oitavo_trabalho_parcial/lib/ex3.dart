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
      title: 'Exercício 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroEmpresa(),
    );
  }
}

class CadastroEmpresa extends StatefulWidget {
  const CadastroEmpresa({super.key});

  @override
  State<CadastroEmpresa> createState() => _CadastroEmpresaState();
}

class _CadastroEmpresaState extends State<CadastroEmpresa> {
  final _formKey = GlobalKey<FormState>();

  final razaoSocialController = TextEditingController();
  final cnpjController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final capitalSocialController = TextEditingController();

  final _formatoMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void dispose() {
    razaoSocialController.dispose();
    cnpjController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    capitalSocialController.dispose();
    super.dispose();
  }

  // Faixa de valor e formato decimal nao tem validador pronto nas
  // bibliotecas do trabalho, entao seguem com validacao propria.
  String? validarCapitalSocial(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Capital social é obrigatório.';
    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(texto)) {
      return 'Capital social deve possuir no máximo duas casas decimais.';
    }
    final capital = double.tryParse(texto.replaceAll(',', '.'));
    if (capital == null) return 'Capital social deve ser um valor decimal válido.';
    if (capital < 1000 || capital > 100000000) {
      return 'Capital social deve estar entre ${_formatoMoeda.format(1000)} e ${_formatoMoeda.format(100000000)}.';
    }
    return null;
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Empresa cadastrada com sucesso')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Empresa')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: razaoSocialController,
                decoration: const InputDecoration(
                  labelText: 'Razão social',
                  border: OutlineInputBorder(),
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('Razão social é obrigatória.'),
                  Validatorless.min(3, 'Razão social deve possuir no mínimo 3 caracteres.'),
                  Validatorless.max(100, 'Razão social deve possuir no máximo 100 caracteres.'),
                ]),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: cnpjController,
                keyboardType: TextInputType.number,
                inputFormatters: const [CnpjMask()],
                decoration: const InputDecoration(
                  labelText: 'CNPJ',
                  border: OutlineInputBorder(),
                ),
                validator: BrZod().required().cnpj().build,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('E-mail é obrigatório.'),
                  Validatorless.email('Informe um e-mail válido.'),
                ]),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: telefoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: const [PhoneMask()],
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                ),
                validator: BrZod().required().phone().build,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: capitalSocialController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Capital social',
                  border: OutlineInputBorder(),
                ),
                validator: validarCapitalSocial,
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
