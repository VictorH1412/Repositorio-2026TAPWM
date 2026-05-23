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
      title: 'Quarto Trabalho Parcial',
      home: const MenuPrincipal(),
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quarto Trabalho Parcial'),
      ),
      body: ListView(
        children: [
          itemMenu(context, 'Exercício 1 - Login', const TelaLogin()),
          itemMenu(context, 'Exercício 2 - Cadastro', const TelaCadastro()),
          itemMenu(
            context,
            'Exercício 3 - Preferências',
            const TelaPreferencias(),
          ),
          itemMenu(
            context,
            'Exercício 4 - Escolha de Turno',
            const TelaTurno(),
          ),
          itemMenu(
            context,
            'Exercício 5 - Configurações',
            const TelaConfiguracoes(),
          ),
          itemMenu(
            context,
            'Exercício 6 - Seleção de Curso',
            const TelaCurso(),
          ),
          itemMenu(
            context,
            'Exercício 7 - Matrícula Completa',
            const TelaMatricula(),
          ),
        ],
      ),
    );
  }

  Widget itemMenu(BuildContext context, String titulo, Widget tela) {
    return ListTile(
      title: Text(titulo),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => tela),
        );
      },
    );
  }
}

// EXERCÍCIO 1
class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}

// EXERCÍCIO 2
class TelaCadastro extends StatelessWidget {
  const TelaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Idade',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

// EXERCÍCIO 3
class TelaPreferencias extends StatefulWidget {
  const TelaPreferencias({super.key});

  @override
  State<TelaPreferencias> createState() => _TelaPreferenciasState();
}

class _TelaPreferenciasState extends State<TelaPreferencias> {
  bool aceita = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferências'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            CheckboxListTile(
              title: const Text('Aceito receber novidades'),
              value: aceita,
              onChanged: (value) {
                setState(() {
                  aceita = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// EXERCÍCIO 4
class TelaTurno extends StatefulWidget {
  const TelaTurno({super.key});

  @override
  State<TelaTurno> createState() => _TelaTurnoState();
}

class _TelaTurnoState extends State<TelaTurno> {
  String turno = 'Manhã';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha de Turno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nome do aluno',
              ),
            ),
            RadioListTile(
              title: const Text('Manhã'),
              value: 'Manhã',
              groupValue: turno,
              onChanged: (value) {
                setState(() {
                  turno = value!;
                });
              },
            ),
            RadioListTile(
              title: const Text('Tarde'),
              value: 'Tarde',
              groupValue: turno,
              onChanged: (value) {
                setState(() {
                  turno = value!;
                });
              },
            ),
            RadioListTile(
              title: const Text('Noite'),
              value: 'Noite',
              groupValue: turno,
              onChanged: (value) {
                setState(() {
                  turno = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// EXERCÍCIO 5
class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  bool notificacoes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SwitchListTile(
              title: const Text('Receber notificações'),
              value: notificacoes,
              onChanged: (value) {
                setState(() {
                  notificacoes = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// EXERCÍCIO 6
class TelaCurso extends StatefulWidget {
  const TelaCurso({super.key});

  @override
  State<TelaCurso> createState() => _TelaCursoState();
}

class _TelaCursoState extends State<TelaCurso> {
  String cursoSelecionado = 'Informática';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção de Curso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nome do aluno',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: cursoSelecionado,
              items: const [
                DropdownMenuItem(
                  value: 'Informática',
                  child: Text('Informática'),
                ),
                DropdownMenuItem(
                  value: 'Administração',
                  child: Text('Administração'),
                ),
                DropdownMenuItem(
                  value: 'Eletrônica',
                  child: Text('Eletrônica'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  cursoSelecionado = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// EXERCÍCIO 7
class TelaMatricula extends StatefulWidget {
  const TelaMatricula({super.key});

  @override
  State<TelaMatricula> createState() => _TelaMatriculaState();
}

class _TelaMatriculaState extends State<TelaMatricula> {
  String turno = 'Manhã';
  String curso = 'Informática';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matrícula Completa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nome do aluno',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Idade',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nome do responsável',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Telefone',
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Selecione o turno:',
              style: TextStyle(fontSize: 16),
            ),

            RadioListTile(
              title: const Text('Manhã'),
              value: 'Manhã',
              groupValue: turno,
              onChanged: (value) {
                setState(() {
                  turno = value!;
                });
              },
            ),
            RadioListTile(
              title: const Text('Tarde'),
              value: 'Tarde',
              groupValue: turno,
              onChanged: (value) {
                setState(() {
                  turno = value!;
                });
              },
            ),
            RadioListTile(
              title: const Text('Noite'),
              value: 'Noite',
              groupValue: turno,
              onChanged: (value) {
                setState(() {
                  turno = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: curso,
              items: const [
                DropdownMenuItem(
                  value: 'Informática',
                  child: Text('Informática'),
                ),
                DropdownMenuItem(
                  value: 'Administração',
                  child: Text('Administração'),
                ),
                DropdownMenuItem(
                  value: 'Eletrônica',
                  child: Text('Eletrônica'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  curso = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: const Text('Enviar matrícula'),
            ),
          ],
        ),
      ),
    );
  }
}