import 'package:flutter/material.dart';
import '../controles/controle_planeta.dart';
import '../modelos/planeta.dart';

class TelaPlaneta extends StatefulWidget {
  final bool isIncluir;
  final Planeta planeta;
  final Function() onFinalizado;

  const TelaPlaneta({
    super.key,
    required this.isIncluir,
    required this.planeta,
    required this.onFinalizado,
  });

  @override
  State<TelaPlaneta> createState() => _TelaPlanetaState();
}

class _TelaPlanetaState extends State<TelaPlaneta> {
  final _formKey = GlobalKey<FormState>(); // Chave para o formulário

  // Controladores para capturar entrada de dados
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _tamanhoController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();

  final ControlePlaneta _controlePlaneta = ControlePlaneta();
  late Planeta _planeta;

  @override
  void initState() {
    _planeta = widget.planeta;
    _nomeController.text = _planeta.nome;
    _tamanhoController.text = _planeta.tamanho.toString();
    _distanciaController.text = _planeta.distancia.toString();
    _apelidoController.text = _planeta.apelido ?? '';
    super.initState();
  }

  /// Submete o formulário após validação
  void _submitForm() {
    if (_formKey.currentState == null) return;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.isIncluir ? _controlePlaneta.inserirPlaneta(_planeta) : _controlePlaneta.alterarPlaneta(_planeta);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Planeta ${widget.isIncluir ? 'adicionado' : 'alterado'} com sucesso!'),
        ),
      );
      Navigator.of(context).pop();
      widget.onFinalizado();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: SingleChildScrollView(  // Permite que a tela seja rolada, ideal para telas pequenas
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction, // Garante que a validação aconteça
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo de entrada para Nome do Planeta
              _buildInputField(
                controller: _nomeController,
                label: 'Nome do Planeta',
                required: true,  // Indica que o campo é obrigatório
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'Nome precisa ter pelo menos 3 caracteres';
                  }
                  return null;
                },
                onSaved: (value) {
                  _planeta.nome = value!;
                },
              ),
              const SizedBox(height: 16),
              
              // Campo de entrada para Distância do Planeta
              _buildInputField(
                controller: _distanciaController,
                label: 'Distância (km) *',
                required: true,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Informe um valor numérico válido';
                  }
                  if (double.parse(value) <= 0) {
                    return 'A distância deve ser maior que zero';
                  }
                  return null;
                },
                onSaved: (value) {
                  _planeta.distancia = double.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              
              // Campo de entrada para Tamanho do Planeta
              _buildInputField(
                controller: _tamanhoController,
                label: 'Tamanho (km) *',
                required: true,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Informe um valor numérico válido';
                  }
                  if (double.parse(value) <= 0) {
                    return 'O tamanho deve ser maior que zero';
                  }
                  return null;
                },
                onSaved: (value) {
                  _planeta.tamanho = double.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              
              // Campo de entrada para Apelido do Planeta (opcional)
              _buildInputField(
                controller: _apelidoController,
                label: 'Apelido',
                onSaved: (value) {
                  _planeta.apelido = value;
                },
              ),
              const SizedBox(height: 24),
              
              // Botões "Salvar" e "Cancelar"
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões
                children: [
                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0639E2), // Cor azul do Talento Tech
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text('Salvar'),
                  ),
                  const SizedBox(width: 16), // Espaçamento entre os botões
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Cor vermelha
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    label: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Função para construir campos de entrada reutilizáveis
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold), // Fonte preta
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold), // Cor da label preta
        filled: true,
        fillColor: Colors.white, // Fundo branco
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none, // Remover bordas
        ),
        suffixIcon: required ? const Icon(Icons.star, color: Colors.red) : null, // Asterisco para campos obrigatórios
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
