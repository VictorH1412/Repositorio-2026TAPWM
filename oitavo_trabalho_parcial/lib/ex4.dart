import 'package:all_br_forms/all_br_forms.dart';
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
  final descricaoController = TextEditingController();
  final emailResponsavelController = TextEditingController();
  final dataInicioController = TextEditingController();
  final numeroVagasController = TextEditingController();
  final mensalidadeController = TextEditingController();

  final _formatoData = DateFormat('dd/MM/yyyy');
  final _formatoMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void dispose() {
    nomeCursoController.dispose();
    descricaoController.dispose();
    emailResponsavelController.dispose();
    dataInicioController.dispose();
    numeroVagasController.dispose();
    mensalidadeController.dispose();
    super.dispose();
  }

  // As regras abaixo (data real e posterior a hoje, faixa numerica e faixa
  // decimal) nao sao cobertas pelas bibliotecas do trabalho, entao seguem
  // com validacao propria usando intl para o parse da data.
  String? validarDataInicio(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Data de início é obrigatória.';

    DateTime dataInicio;
    try {
      dataInicio = _formatoData.parseStrict(texto);
    } on FormatException {
      return 'Informe uma data válida no formato dd/MM/yyyy.';
    }

    final hoje = DateTime.now();
    final hojeSemHora = DateTime(hoje.year, hoje.month, hoje.day);
    if (!dataInicio.isAfter(hojeSemHora)) {
      return 'A data de início deve ser posterior à data atual.';
    }
    return null;
  }

  String? validarNumeroVagas(String? value) {
    final texto = value?.trim() ?? '';
    final vagas = int.tryParse(texto);
    if (vagas == null) return 'Número de vagas deve ser um número inteiro.';
    if (vagas < 1 || vagas > 500) {
      return 'Número de vagas deve estar entre 1 e 500.';
    }
    return null;
  }

  String? validarMensalidade(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Mensalidade é obrigatória.';
    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(texto)) {
      return 'Mensalidade deve possuir no máximo duas casas decimais.';
    }
    final mensalidade = double.tryParse(texto.replaceAll(',', '.'));
    if (mensalidade == null) {
      return 'Mensalidade deve ser um valor decimal válido.';
    }
    if (mensalidade < 50 || mensalidade > 10000) {
      return 'Mensalidade deve estar entre ${_formatoMoeda.format(50)} e ${_formatoMoeda.format(10000)}.';
    }
    return null;
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Curso cadastrado com sucesso')),
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
                validator: Validatorless.multiple([
                  Validatorless.required('Nome do curso é obrigatório.'),
                  Validatorless.min(5, 'Nome do curso deve possuir no mínimo 5 caracteres.'),
                  Validatorless.max(100, 'Nome do curso deve possuir no máximo 100 caracteres.'),
                ]),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descricaoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('Descrição é obrigatória.'),
                  Validatorless.min(10, 'Descrição deve possuir no mínimo 10 caracteres.'),
                  Validatorless.max(500, 'Descrição deve possuir no máximo 500 caracteres.'),
                ]),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailResponsavelController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail do responsável',
                  border: OutlineInputBorder(),
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('E-mail do responsável é obrigatório.'),
                  Validatorless.email('Informe um e-mail válido.'),
                ]),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: dataInicioController,
                keyboardType: TextInputType.datetime,
                inputFormatters: const [DateMask()],
                decoration: const InputDecoration(
                  labelText: 'Data de início (dd/MM/yyyy)',
                  border: OutlineInputBorder(),
                ),
                validator: validarDataInicio,
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
              const SizedBox(height: 15),
              TextFormField(
                controller: mensalidadeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Mensalidade',
                  border: OutlineInputBorder(),
                ),
                validator: validarMensalidade,
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
