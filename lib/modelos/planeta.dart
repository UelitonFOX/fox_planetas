/// Representa um Planeta com suas principais características.
class Planeta {
  int? id; // Identificador único (opcional)
  String nome; // Nome do planeta
  double tamanho; // Tamanho em km
  double distanciaDoSol; // Distância do Sol em UA (Unidades Astronômicas)
  String? apelido; // Apelido opcional

  /// Construtor principal
  Planeta({
    this.id,
    required this.nome,
    required this.tamanho,
    required this.distanciaDoSol,
    this.apelido,
  });

  /// Construtor para criar um planeta vazio (valores padrão)
  Planeta.vazio()
      : nome = '',
        tamanho = 0.0,
        distanciaDoSol = 0.0,
        apelido = '';

  /// Converte um `Map` para um objeto `Planeta`
  factory Planeta.fromMap(Map<String, dynamic> map) {
    return Planeta(
      id: map['id'],
      nome: map['nome'],
      tamanho: map['tamanho'],
      distanciaDoSol: map['distancia'],
      apelido: map['apelido'],
    );
  }

  /// Converte um objeto `Planeta` para `Map`, útil para banco de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tamanho': tamanho,
      'distancia': distanciaDoSol,
      'apelido': apelido,
    };
  }
}
