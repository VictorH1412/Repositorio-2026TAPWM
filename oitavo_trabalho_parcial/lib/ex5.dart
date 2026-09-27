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
      title: 'Exercício 5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroImovel(),
    );
  }
}

class CadastroImovel extends StatefulWidget {
  const CadastroImovel({super.key});

  @override
  State<CadastroImovel> createState() => _CadastroImovelState();
}

class _CadastroImovelState extends State<CadastroImovel> {
  final _formKey = GlobalKey<FormState>();

  final nomeProprietarioController = TextEditingController();
  final cpfProprietarioController = TextEditingController();
  final cepController = TextEditingController();
  final enderecoController = TextEditingController();
  final numeroController = TextEditingController();
  final areaController = TextEditingController();
  final valorImovelController = TextEditingController();

  final _formatoMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void dispose() {
    nomeProprietarioController.dispose();
    cpfProprietarioController.dispose();
    cepController.dispose();
    enderecoController.dispose();
    numeroController.dispose();
    areaController.dispose();
    valorImovelController.dispose();
    super.dispose();
  }

  // Faixa numerica, faixa decimal e formato decimal nao tem validador pronto
  // nas bibliotecas do trabalho, entao seguem com validacao propria.
  String? validarNumero(String? value) {
    final texto = value?.trim() ?? '';
    final numero = int.tryParse(texto);
    if (numero == null) return 'Número deve ser um número inteiro.';
    if (numero < 1 || numero > 99999) {
      return 'Número deve estar entre 1 e 99.999.';
    }
    return null;
  }

  String? validarArea(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Área do imóvel é obrigatória.';
    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(texto)) {
      return 'Área deve possuir no máximo duas casas decimais.';
    }
    final area = double.tryParse(texto.replaceAll(',', '.'));
    if (area == null) return 'Área deve ser um valor decimal válido.';
    if (area < 10 || area > 10000) {
      return 'Área deve estar entre 10 e 10.000 m².';
    }
    return null;
  }

  String? validarValorImovel(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Valor do imóvel é obrigatório.';
    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(texto)) {
      return 'Valor do imóvel deve possuir no máximo duas casas decimais.';
    }
    final valor = double.tryParse(texto.replaceAll(',', '.'));
    if (valor == null) return 'Valor do imóvel deve ser um valor decimal válido.';
    if (valor < 20000 || valor > 10000000) {
      return 'Valor do imóvel deve estar entre ${_formatoMoeda.format(20000)} e ${_formatoMoeda.format(10000000)}.';
    }
    return null;
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imóvel cadastrado com sucesso')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Imóvel')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeProprietarioController,
                decoration: const InputDecoration(
                  labelText: 'Nome do proprietário',
                  border: OutlineInputBorder(),
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('Nome do proprietário é obrigatório.'),
                  Validatorless.min(3, 'Nome deve possuir no mínimo 3 caracteres.'),
                  Validatorless.max(80, 'Nome deve possuir no máximo 80 caracteres.'),
                ]),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: cpfProprietarioController,
                keyboardType: TextInputType.number,
                inputFormatters: const [CpfMask()],
                decoration: const InputDecoration(
                  labelText: 'CPF do proprietário',
                  border: OutlineInputBorder(),
                ),
                validator: BrZod().required().cpf().build,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: cepController,
                keyboardType: TextInputType.number,
                inputFormatters: const [CepMask()],
                decoration: const InputDecoration(
                  labelText: 'CEP',
                  border: OutlineInputBorder(),
                ),
                validator: BrZod().required().cep().build,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: enderecoController,
                decoration: const InputDecoration(
                  labelText: 'Endereço',
                  border: OutlineInputBorder(),
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('Endereço é obrigatório.'),
                  Validatorless.min(5, 'Endereço deve possuir no mínimo 5 caracteres.'),
                  Validatorless.max(100, 'Endereço deve possuir no máximo 100 caracteres.'),
                ]),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: numeroController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Número',
                  border: OutlineInputBorder(),
                ),
                validator: validarNumero,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: areaController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Área do imóvel (m²)',
                  border: OutlineInputBorder(),
                ),
                validator: validarArea,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: valorImovelController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Valor do imóvel',
                  border: OutlineInputBorder(),
                ),
                validator: validarValorImovel,
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
