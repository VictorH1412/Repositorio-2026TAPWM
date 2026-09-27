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
      title: 'Exercício 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CadastroPedido(),
    );
  }
}

class CadastroPedido extends StatefulWidget {
  const CadastroPedido({super.key});

  @override
  State<CadastroPedido> createState() => _CadastroPedidoState();
}

class _CadastroPedidoState extends State<CadastroPedido> {
  final _formKey = GlobalKey<FormState>();

  final nomeClienteController = TextEditingController();
  final valorPedidoController = TextEditingController();
  final quantidadeItensController = TextEditingController();
  final percentualDescontoController = TextEditingController();

  @override
  void dispose() {
    nomeClienteController.dispose();
    valorPedidoController.dispose();
    quantidadeItensController.dispose();
    percentualDescontoController.dispose();
    super.dispose();
  }

  String? validarNomeCliente(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Nome do cliente é obrigatório.';
    if (texto.length < 3 || texto.length > 60) {
      return 'Nome do cliente deve possuir entre 3 e 60 caracteres.';
    }
    return null;
  }

  String? validarValorPedido(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Valor do pedido é obrigatório.';
    if (!RegExp(r'^\d+([.,]\d{1,2})?$').hasMatch(texto)) {
      return 'Valor do pedido deve possuir no máximo duas casas decimais.';
    }
    final valor = double.tryParse(texto.replaceAll(',', '.'));
    if (valor == null) return 'Valor do pedido deve ser um valor decimal válido.';
    if (valor < 1 || valor > 99999.99) {
      return 'Valor do pedido deve estar entre R\$ 1,00 e R\$ 99.999,99.';
    }
    return null;
  }

  String? validarQuantidadeItens(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Quantidade de itens é obrigatória.';
    final quantidade = int.tryParse(texto);
    if (quantidade == null) {
      return 'Quantidade de itens deve ser um número inteiro.';
    }
    if (quantidade < 1 || quantidade > 100) {
      return 'Quantidade de itens deve estar entre 1 e 100.';
    }
    return null;
  }

  String? validarPercentualDesconto(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty) return 'Percentual de desconto é obrigatório.';
    final percentual = int.tryParse(texto);
    if (percentual == null) {
      return 'Percentual de desconto deve ser um número inteiro.';
    }
    if (percentual < 0 || percentual > 100) {
      return 'Percentual de desconto deve estar entre 0 e 100.';
    }
    return null;
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pedido salvo com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Pedido')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeClienteController,
                decoration: const InputDecoration(
                  labelText: 'Nome do cliente',
                  border: OutlineInputBorder(),
                ),
                validator: validarNomeCliente,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: valorPedidoController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Valor do pedido',
                  border: OutlineInputBorder(),
                ),
                validator: validarValorPedido,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: quantidadeItensController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade de itens',
                  border: OutlineInputBorder(),
                ),
                validator: validarQuantidadeItens,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: percentualDescontoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Percentual de desconto',
                  border: OutlineInputBorder(),
                ),
                validator: validarPercentualDesconto,
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
