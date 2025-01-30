import 'package:flutter/material.dart';
import '../modelos/planeta.dart';

class TelaDetalhesPlaneta extends StatelessWidget {
  final Planeta planeta;

  const TelaDetalhesPlaneta({super.key, required this.planeta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          planeta.nome,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000428), Color(0xFF004e92)], // Azul espacial
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("🌍", "Nome:", planeta.nome),
            _buildInfoRow("🌞", "Distância do Sol:", "${planeta.distancia} km"),
            _buildInfoRow("📏", "Tamanho:", "${planeta.tamanho} km"),
            if (planeta.apelido != null && planeta.apelido!.isNotEmpty)
              _buildInfoRow("🏷️", "Apelido:", planeta.apelido!),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 18),
                children: [
                  TextSpan(
                    text: "$label ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
