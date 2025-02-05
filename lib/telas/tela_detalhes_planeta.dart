import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../modelos/planeta.dart';
import '../controles/controle_planeta.dart';
import 'tela_planeta.dart';

/// **Tela de Detalhes do Planeta**
/// Exibe informações do planeta e permite edição ou exclusão.
class TelaDetalhesPlaneta extends StatelessWidget {
  final Planeta planeta;
  final ControlePlaneta _controlePlaneta = ControlePlaneta(); // Controle para excluir

  TelaDetalhesPlaneta({super.key, required this.planeta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900], // Mantendo o padrão do design
        iconTheme: const IconThemeData(color: Colors.white), // Ícone de voltar branco
        title: Text(
          planeta.nome,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          // Ícone de editar no AppBar
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blueAccent),
            onPressed: () => _editarPlaneta(context),
          ),

          // Ícone de excluir no AppBar
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () => _excluirPlaneta(context),
          ),
        ],
      ),
      body: Container(
        color: Colors.black, // Fundo preto sólido
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoCard(Icons.language, "Nome", planeta.nome),
            _buildInfoCard(Icons.wb_sunny, "Distância do Sol", "${planeta.distanciaDoSol} UA"),
            _buildInfoCard(Icons.straighten, "Tamanho", "${planeta.tamanho} km"),
            if (planeta.apelido != null && planeta.apelido!.isNotEmpty)
              _buildInfoCard(Icons.label, "Apelido", planeta.apelido!),
          ],
        ),
      ),
    );
  }

  /// **Abre a tela de edição do planeta**
  void _editarPlaneta(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPlaneta(
          isIncluir: false,
          planeta: planeta,
          onFinalizado: () {
            Navigator.pop(context, true); // Atualiza a tela ao voltar
          },
        ),
      ),
    );
  }

  /// **Exclui o planeta, exibe a mensagem de confirmação e atualiza a tela principal**
  void _excluirPlaneta(BuildContext context) async {
    bool confirmar = await _mostrarDialogoConfirmacao(context);

    if (confirmar) {
      await _controlePlaneta.excluirPlaneta(planeta.id!);

      if (context.mounted) {
        // Exibe mensagem de sucesso
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

        // Fecha a tela de detalhes e volta para a tela principal, passando um sinal para atualizar a lista
        Navigator.pop(context, true);
      }
    }
  }

  /// **Mostra um diálogo de confirmação antes de excluir**
  Future<bool> _mostrarDialogoConfirmacao(BuildContext context) async {
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
                child: const Text("Cancelar", style: TextStyle(color: Colors.blueAccent)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Excluir", style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          ),
        ) ??
        false;
  }

  /// **Cria um card estilizado para exibir cada informação do planeta**
  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent, size: 28),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
