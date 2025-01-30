class Planeta {
  int? id; // Identificador único do planeta
  String nome; // Nome do planeta
  double tamanho; // Tamanho do planeta em quilômetros
  double distancia; // Distância do planeta em relação a uma referência (em km)
  String? apelido; // Apelido opcional para o planeta

  // Construtor da classe Planeta
  Planeta({
    this.id,
    required this.nome,
    required this.tamanho,
    required this.distancia,
    this.apelido,
  });

  // Construtor alternativo para inicializar com valores padrão
  Planeta.vazio()
      : nome = '',
        tamanho = 0.0,
        distancia = 0.0,
        apelido = '';

  // Converte um mapa de dados em um objeto Planeta
  factory Planeta.fromMap(Map<String, dynamic> map) {
    return Planeta(
      id: map['id'],
      nome: map['nome'],
      tamanho: map['tamanho'],
      distancia: map['distancia'],
      apelido: map['apelido'],
    );
  }

  // Converte um objeto Planeta em um mapa de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tamanho': tamanho,
      'distancia': distancia,
      'apelido': apelido,
    };
  }
}
