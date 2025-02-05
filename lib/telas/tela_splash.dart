import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

/// **Tela Splash do aplicativo**
/// Apresenta uma introdução animada antes de carregar a tela principal.
/// O usuário pode tocar na tela para continuar.
class TelaSplash extends StatefulWidget {
  const TelaSplash({super.key});

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controlador da animação
  late Animation<double> _fadeAnimation; // Animação de fade-in

  @override
  void initState() {
    super.initState();

    // Configuração da animação de fade-in
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Tempo da animação
    );

    // Transição de opacidade de 0 a 1 para criar o efeito de fade-in
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward(); // Inicia a animação automaticamente ao carregar a tela
  }

  /// **Navega para a tela principal do aplicativo**
  void _navegarParaHome() {
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
      onTap: _navegarParaHome, // Permite avançar ao tocar na tela
      child: Scaffold(
        backgroundColor: Colors.black, // Mantém o fundo escuro uniforme
        body: Column(
          children: [
            // Área central onde ficam os elementos visuais
            Expanded(
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation, // Aplica a animação de fade-in
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo da Talento Tech
                      Image.asset(
                        'assets/logos/talento_tech_logo.png',
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(height: 10),

                      // Nome da Talento Tech
                      Image.asset(
                        'assets/logos/talento_tech_text.png',
                        width: 160,
                      ),
                      const SizedBox(height: 20),

                      // Nome do aplicativo estilizado
                      Text(
                        'APP PLANETAS',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Ícone de toque e mensagem para iniciar o app
                      Column(
                        children: [
                          const Icon(
                            Icons.touch_app,
                            size: 30,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Toque para iniciar',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Rodapé do aplicativo com fade-in
            FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Desenvolvido por Ueliton Fermino\nCurso Talento Tech - PR',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera os recursos da animação para evitar vazamento de memória
    super.dispose();
  }
}
