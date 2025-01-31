import 'package:app_planeta/controles/controle_planeta.dart';
import 'package:app_planeta/modelos/planeta.dart';
import 'package:app_planeta/telas/tela_detalhes_planeta.dart';
import 'package:app_planeta/telas/tela_planeta.dart';
import 'package:app_planeta/telas/tela_splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Planetas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TelaSplash(), // Inicia com a tela Splash
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ControlePlaneta _controlePlaneta = ControlePlaneta();
  List<Planeta> _planetas = [];

  @override
  void initState() {
    super.initState();
    _atualizarPlanetas();
  }

  /// Atualiza a lista de planetas no banco de dados
  Future<void> _atualizarPlanetas() async {
    final resultado = await _controlePlaneta.lerPlanetas();
    setState(() {
      _planetas = resultado;
    });
  }

  /// Navega para a tela de inclusão de um novo planeta
  void _incluirPlaneta(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => TelaPlaneta(
          isIncluir: true,
          planeta: Planeta.vazio(),
          onFinalizado: _atualizarPlanetas,
        ),
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(opacity: anim, child: child);
        },
      ),
    );
  }

  /// Navega para a tela de edição de um planeta existente
  void _alterarPlaneta(BuildContext context, Planeta planeta) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => TelaPlaneta(
          isIncluir: false,
          planeta: planeta,
          onFinalizado: _atualizarPlanetas,
        ),
        transitionsBuilder: (_, anim, __, child) {
          return ScaleTransition(scale: anim, child: child);
        },
      ),
    );
  }

  /// Exibe detalhes do planeta em uma nova tela
  void _verDetalhesPlaneta(BuildContext context, Planeta planeta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDetalhesPlaneta(planeta: planeta),
      ),
    );
  }

  /// Exibe um alerta para confirmar a exclusão de um planeta
  Future<bool> _mostrarDialogoConfirmacao() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirmação"),
            content: const Text("Tem certeza que deseja excluir este planeta?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Excluir"),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// Exclui um planeta após confirmação do usuário
  void _excluirPlaneta(int id) async {
    bool confirmar = await _mostrarDialogoConfirmacao();
    if (confirmar) {
      await _controlePlaneta.excluirPlaneta(id);
      _atualizarPlanetas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar com fundo branco
        elevation: 0, // Sem elevação para um visual mais limpo
        centerTitle: true, // Centraliza o título
        title: const Text(
          'Aplicativo - Planetas',
          style: TextStyle(
            color: Colors.grey, // Título cinza
            fontWeight: FontWeight.bold,
            fontSize: 26, // Tamanho de fonte maior
          ),
        ),
      ),
      body: Stack(
        children: [
          _buildBackground(), // Fundo branco
          _planetas.isEmpty ? _buildEmptyMessage() : _buildContent(), // Exibe conteúdo ou mensagem de vazio
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _incluirPlaneta(context);
        },
        backgroundColor: const Color(0xFF0639E2),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Novo Planeta',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 3), // Sombra no texto do botão
            ],
          ),
        ),
      ),
    );
  }

  /// Constrói o fundo branco
  Widget _buildBackground() {
    return Positioned.fill( // Preenche toda a área do fundo
      child: Container(
        color: Colors.white, // Fundo branco
      ),
    );
  }

  /// Constrói a lista de planetas na tela principal
  Widget _buildContent() {
    return ListView.builder(
      shrinkWrap: true, // Evita que o ListView ocupe todo o espaço
      itemCount: _planetas.length,
      itemBuilder: (context, index) {
        final planeta = _planetas[index];
        return _buildPlanetCard(planeta);
      },
    );
  }

  /// Constrói um card de exibição para cada planeta na lista
  Widget _buildPlanetCard(Planeta planeta) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFFE0E0E0), // Cor neutra para os cards
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          planeta.nome,
          style: const TextStyle(
            color: Colors.black, // Texto preto para o nome
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: planeta.apelido != null && planeta.apelido!.isNotEmpty
            ? Text(
                planeta.apelido!,
                style: const TextStyle(color: Colors.black54, fontSize: 16),
              )
            : null,
        leading: const Icon(Icons.public, color: Colors.black), // Ícone de planeta restaurado
        onTap: () => _verDetalhesPlaneta(context, planeta),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.amberAccent),
              onPressed: () => _alterarPlaneta(context, planeta),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _excluirPlaneta(planeta.id!),
            ),
          ],
        ),
      ),
    );
  }

  /// Exibe uma mensagem quando não há planetas cadastrados
  Widget _buildEmptyMessage() {
    return Center(
      child: Text(
        'Nenhum planeta cadastrado',
        style: TextStyle(fontSize: 20, color: Colors.grey),
      ),
    );
  }
}
