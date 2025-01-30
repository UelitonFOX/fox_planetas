import 'package:flutter/material.dart';

import '../main.dart'; // Importa a tela principal para navegação

class TelaSplash extends StatelessWidget {
  const TelaSplash({super.key});

  /// Método que navega para a tela principal quando o usuário toca na tela
  void _navegarParaHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const MyHomePage(title: "Aplicativo - Planeta")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          _navegarParaHome(context), // Detecta toque na tela para avançar
      child: Scaffold(
        backgroundColor: Colors.white, // Fundo branco para destacar a logo
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logos/talento_tech_logo.png",
                  width: 120), // Exibe a logo do Talento Tech
              const SizedBox(height: 16),
              Image.asset("assets/logos/talento_tech_text.png",
                  width: 180), // Exibe o nome do projeto
              const SizedBox(height: 24),
              const Text(
                "Desenvolvido por Ueliton Fermino",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              const Text(
                "Curso Talento Tech - PR",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              const SizedBox(height: 32),
              const Icon(Icons.touch_app,
                  size: 50, color: Colors.deepPurple), // Ícone indicando toque
              const SizedBox(height: 16),
              const Text(
                "Toque em qualquer lugar para iniciar",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
