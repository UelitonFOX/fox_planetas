import 'package:app_planeta/controles/controle_planeta.dart';
import 'package:app_planeta/modelos/planeta.dart';
import 'package:app_planeta/telas/tela_detalhes_planeta.dart';
import 'package:app_planeta/telas/tela_planeta.dart';
import 'package:app_planeta/telas/tela_splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

/// **Classe principal do aplicativo**
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Planetas',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // Mantendo fundo uniforme
      ),
      home: const TelaSplash(), // Tela inicial do app
    );
  }
}

/// **Página principal do app, onde os planetas são listados**
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

  /// **Atualiza a lista de planetas armazenados no banco de dados**
  Future<void> _atualizarPlanetas() async {
    final resultado = await _controlePlaneta.lerPlanetas();
    setState(() {
      _planetas = resultado;
    });
  }

  /// **Abre a tela de inclusão de um novo planeta**
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

  /// **Abre a tela de edição de um planeta existente**
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

  /// **Exibe os detalhes de um planeta**
  void _verDetalhesPlaneta(BuildContext context, Planeta planeta) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => TelaDetalhesPlaneta(planeta: planeta),
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(opacity: anim, child: child);
        },
      ),
    );
  }

  /// **Exibe um alerta de confirmação antes de excluir um planeta**
  Future<bool> _mostrarDialogoConfirmacao() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text("Confirmação", style: TextStyle(color: Colors.white)),
            content: const Text(
              "Tem certeza que deseja excluir este planeta?",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancelar", style: TextStyle(color: Colors.blue)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Excluir", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ?? 
        false;
  }

  /// **Exclui um planeta do banco de dados com confirmação e feedback visual**
  void _excluirPlaneta(int id) async {
    bool confirmar = await _mostrarDialogoConfirmacao();
    if (confirmar) {
      await _controlePlaneta.excluirPlaneta(id);
      _atualizarPlanetas();

      /// ✅ **Correção para evitar erro do BuildContext após um await**
      if (!mounted) return;

      /// **Exibe mensagem de sucesso após a exclusão**
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Planeta excluído com sucesso!",
            style: GoogleFonts.nunito(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900], // Mantendo padrão de fundo cinza escuro
        elevation: 4,
        centerTitle: true,
        title: Text(
          'Aplicativo - Planetas',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: _planetas.isEmpty ? _buildEmptyMessage() : _buildContent(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _incluirPlaneta(context);
        },
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Novo Planeta',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// **Constrói a lista de planetas**
  Widget _buildContent() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _planetas.length,
      itemBuilder: (context, index) {
        final planeta = _planetas[index];
        return _buildPlanetCard(planeta);
      },
    );
  }

  /// **Constrói um card para exibir informações de um planeta**
  Widget _buildPlanetCard(Planeta planeta) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[900],
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          planeta.nome,
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (planeta.apelido != null && planeta.apelido!.isNotEmpty)
              Text(
                planeta.apelido!,
                style: GoogleFonts.nunito(color: Colors.white70, fontSize: 16),
              ),
            Text(
              'Distância do Sol: ${planeta.distanciaDoSol} UA',
              style: GoogleFonts.nunito(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
        leading: const Icon(Icons.public, color: Colors.white70, size: 28),
        onTap: () => _verDetalhesPlaneta(context, planeta),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blueAccent),
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

  /// **Exibe mensagem quando não há planetas cadastrados**
  Widget _buildEmptyMessage() {
    return Center(
      child: Text(
        'Nenhum planeta cadastrado',
        style: GoogleFonts.nunito(fontSize: 20, color: Colors.white70),
      ),
    );
  }
}
