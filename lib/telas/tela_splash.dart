import 'package:flutter/material.dart';
import '../main.dart';

class TelaSplash extends StatelessWidget {
  const TelaSplash({super.key});

  /// Método que navega para a tela principal quando o usuário toca na tela
  void _navegarParaHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navegarParaHome(context), // Detecta toque na tela para avançar
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center( // Garante que tudo fique centralizado
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo do curso
              Image.asset(
                'assets/logos/talento_tech_logo.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 10),
              // Nome do curso
              Image.asset(
                'assets/logos/talento_tech_text.png',
                width: 160,
              ),
              const SizedBox(height: 20),
              // Nome fixo do app (agora centralizado corretamente)
              const Text(
                'APP PLANETAS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              // Ícone de toque e mensagem
              Column(
                children: [
                  const Icon(
                    Icons.touch_app,
                    size: 30,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Toque para iniciar',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Rodapé com assinatura discreta
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Desenvolvido por Ueliton Fermino\nCurso Talento Tech - PR',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
