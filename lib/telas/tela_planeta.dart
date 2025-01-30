import 'package:flutter/material.dart';

import '../controles/controle_planeta.dart';
import '../modelos/planeta.dart';

// Tela de cadastro/edição de planetas
class TelaPlaneta extends StatefulWidget {
  final bool isIncluir; // Indica se a tela está no modo de inclusão
  final Planeta planeta; // Objeto Planeta para edição/cadastro
  final Function() onFinalizado; // Callback para atualizar a lista

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

  // Controladores para os campos de entrada
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _tamanhoController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();
  final TextEditingController _apelidoController = TextEditingController();

  final ControlePlaneta _controlePlaneta = ControlePlaneta();
  late Planeta _planeta;

  @override
  void initState() {
    super.initState();
    _planeta = widget.planeta;

    // Preenchendo os campos com os dados do planeta (se houver)
    _nomeController.text = _planeta.nome;
    _tamanhoController.text = _planeta.tamanho.toString();
    _distanciaController.text = _planeta.distancia.toString();
    _apelidoController.text = _planeta.apelido ?? '';
  }

  // Função para salvar os dados do formulário
  void _submitForm() {
    if (_formKey.currentState == null) return;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Salva os dados no objeto _planeta

      // Verifica se é um novo cadastro ou uma edição e executa a ação correspondente
      widget.isIncluir
          ? _controlePlaneta.inserirPlaneta(_planeta)
          : _controlePlaneta.alterarPlaneta(_planeta);

      // Exibe uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Planeta ${widget.isIncluir ? 'adicionado' : 'alterado'} com sucesso!'),
        ),
      );

      Navigator.of(context).pop(); // Fecha a tela
      widget.onFinalizado(); // Atualiza a lista de planetas
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.isIncluir ? 'Adicionar Planeta' : 'Editar Planeta',
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
            colors: [Color(0xFF000428), Color(0xFF004e92)], // Gradiente azul espacial
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction, // Valida ao interagir com os campos
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInputField(
                controller: _nomeController,
                label: 'Nome',
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
              const SizedBox(height: 10),
              _buildInputField(
                controller: _tamanhoController,
                label: 'Tamanho (km)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Informe um valor numérico válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _planeta.tamanho = double.parse(value!);
                },
              ),
              const SizedBox(height: 10),
              _buildInputField(
                controller: _distanciaController,
                label: 'Distância (km)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Informe um valor numérico válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _planeta.distancia = double.parse(value!);
                },
              ),
              const SizedBox(height: 10),
              _buildInputField(
                controller: _apelidoController,
                label: 'Apelido',
                onSaved: (value) {
                  _planeta.apelido = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Método auxiliar para criar campos de entrada padronizados
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.black.withAlpha((0.5 * 255).toInt()),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
