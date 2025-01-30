import 'package:flutter/material.dart';

import 'controles/controle_planeta.dart';
import 'modelos/planeta.dart';
import 'telas/tela_planeta.dart';
import 'telas/tela_detalhes_planeta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Planetas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Aplicativo - Planeta'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

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

  /// Método responsável por atualizar a lista de planetas cadastrados
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
    ) ?? false;
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
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        elevation: 4,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000428), Color(0xFF004e92)], // Azul espacial
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: _planetas.length,
          itemBuilder: (context, index) {
            final planeta = _planetas[index];
            return _buildPlanetCard(planeta);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _incluirPlaneta(context);
        },
        backgroundColor: Colors.deepPurpleAccent,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Novo Planeta',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
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
      color: Colors.black.withAlpha((0.6 * 255).toInt()),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          planeta.nome,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: planeta.apelido != null && planeta.apelido!.isNotEmpty
            ? Text(
                planeta.apelido!,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              )
            : null,
        leading: const Icon(Icons.public, color: Colors.white),
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
}
