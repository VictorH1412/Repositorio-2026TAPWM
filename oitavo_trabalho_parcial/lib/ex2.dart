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
      title: 'Exercício 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroCliente(),
    );
  }
}

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({super.key});

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final nascimentoController = TextEditingController();

  final _formatoData = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    nascimentoController.dispose();
    super.dispose();
  }

  // A data valida e a regra de maioridade nao sao cobertas pelas bibliotecas
  // do trabalho, entao seguem com validacao propria usando intl para o parse.
  String? validarNascimento(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Data de nascimento é obrigatória.';

    DateTime nascimento;
    try {
      nascimento = _formatoData.parseStrict(texto);
    } on FormatException {
      return 'Informe uma data válida no formato dd/MM/yyyy.';
    }

    final hoje = DateTime.now();
    var idade = hoje.year - nascimento.year;
    final aniversarioJaOcorreu = (hoje.month > nascimento.month) ||
        (hoje.month == nascimento.month && hoje.day >= nascimento.day);
    if (!aniversarioJaOcorreu) idade--;

    if (idade < 18) {
      return 'O cliente deve possuir pelo menos 18 anos.';
    }
    return null;
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente cadastrado com sucesso')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Cliente')),
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
                  Validatorless.max(80, 'Nome deve possuir no máximo 80 caracteres.'),
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
                controller: nascimentoController,
                keyboardType: TextInputType.datetime,
                inputFormatters: const [DateMask()],
                decoration: const InputDecoration(
                  labelText: 'Data de nascimento (dd/MM/yyyy)',
                  border: OutlineInputBorder(),
                ),
                validator: validarNascimento,
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
