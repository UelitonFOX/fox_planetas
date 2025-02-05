import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controles/controle_planeta.dart';
import '../modelos/planeta.dart';

/// **Tela de Cadastro/Edição de Planetas**
/// Permite adicionar ou editar um planeta com validação dos dados.
class TelaPlaneta extends StatefulWidget {
  final bool isIncluir; // Define se é um novo planeta ou edição
  final Planeta planeta; // Planeta a ser cadastrado ou editado
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
  final _formKey = GlobalKey<FormState>(); // Chave global para validação do formulário

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
    _nomeController.text = _planeta.nome;
    _tamanhoController.text = _planeta.tamanho.toString();
    _distanciaController.text = _planeta.distanciaDoSol.toString();
    _apelidoController.text = _planeta.apelido ?? '';
  }

  /// **Valida e envia os dados do formulário**
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      widget.isIncluir
          ? _controlePlaneta.inserirPlaneta(_planeta)
          : _controlePlaneta.alterarPlaneta(_planeta);

      // Exibe mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text(
            'Planeta ${widget.isIncluir ? 'adicionado' : 'alterado'} com sucesso!',
            style: GoogleFonts.nunito(color: Colors.white),
          ),
        ),
      );

      Navigator.of(context).pop(); // Fecha a tela
      widget.onFinalizado(); // Atualiza a lista de planetas
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Evita que o teclado empurre a tela
      appBar: AppBar(
        backgroundColor: Colors.grey[900], // Mantém a padronização do design
        elevation: 2,
        centerTitle: true,
        title: Text(
          widget.isIncluir ? "Novo Planeta" : "Editar Planeta",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction, // Validação instantânea
          child: Column(
            children: [
              _buildInputField(
                controller: _nomeController,
                label: 'Nome do Planeta',
                required: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'Nome precisa ter pelo menos 3 caracteres';
                  }
                  return null;
                },
                onSaved: (value) => _planeta.nome = value!,
              ),
              _buildInputField(
                controller: _distanciaController,
                label: 'Distância do Sol (UA)',
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
                onSaved: (value) => _planeta.distanciaDoSol = double.parse(value!),
              ),
              _buildInputField(
                controller: _tamanhoController,
                label: 'Tamanho (km)',
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
                onSaved: (value) => _planeta.tamanho = double.parse(value!),
              ),

              /// **Campo "Apelido" alinhado corretamente**
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 15), // Mantém alinhamento dos asteriscos
                  Expanded(
                    child: _buildInputField(
                      controller: _apelidoController,
                      label: 'Apelido',
                      onSaved: (value) => _planeta.apelido = value,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  /// **Cria um campo de entrada com estilização e validação**
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Adiciona um asterisco vermelho para campos obrigatórios
          if (required)
            const Padding(
              padding: EdgeInsets.only(top: 15, right: 5),
              child: Text(
                '*',
                style: TextStyle(color: Colors.redAccent, fontSize: 18),
              ),
            ),

          // Campo de entrada
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.nunito(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: GoogleFonts.poppins(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: validator,
              onSaved: onSaved,
            ),
          ),
        ],
      ),
    );
  }

  /// **Cria os botões de Salvar e Cancelar**
  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: _submitForm,
          icon: const Icon(Icons.save, color: Colors.white),
          label: const Text("Salvar"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
        ),
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.cancel, color: Colors.white),
          label: const Text("Cancelar"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
        ),
      ],
    );
  }
}
