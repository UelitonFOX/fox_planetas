import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../modelos/planeta.dart';

/// **ControlePlaneta: Gerencia o banco de dados local**
/// Contém métodos para criar, ler, inserir, atualizar e excluir planetas no banco SQLite.
class ControlePlaneta {
  static Database? _bd; // Instância única do banco de dados

  /// **Garante o acesso ao banco de dados**
  /// - Se o banco já estiver aberto, retorna a instância existente.
  /// - Caso contrário, inicializa e retorna uma nova instância.
  Future<Database> get bd async {
    if (_bd != null) return _bd!;
    _bd = await _initBD('planetas.db');
    return _bd!;
  }

  /// **Inicializa o banco de dados SQLite**
  Future<Database> _initBD(String nomeArquivo) async {
    final caminhoBD = await getDatabasesPath();
    final caminhoCompleto = join(caminhoBD, nomeArquivo);
    return await openDatabase(
      caminhoCompleto,
      version: 1,
      onCreate: _criarBD,
    );
  }

  /// **Cria a tabela 'planetas' no banco de dados**
  Future<void> _criarBD(Database bd, int versao) async {
    const sql = '''
      CREATE TABLE planetas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        tamanho REAL NOT NULL,
        distancia REAL NOT NULL,
        apelido TEXT
      );
    ''';
    await bd.execute(sql);
  }

  /// **Retorna todos os planetas armazenados no banco**
  Future<List<Planeta>> lerPlanetas() async {
    final db = await bd;
    final resultado = await db.query('planetas');
    return resultado.map((item) => Planeta.fromMap(item)).toList();
  }

  /// **Insere um novo planeta no banco**
  Future<int> inserirPlaneta(Planeta planeta) async {
    final db = await bd;
    return await db.insert('planetas', planeta.toMap());
  }

  /// **Atualiza os dados de um planeta existente**
  Future<int> alterarPlaneta(Planeta planeta) async {
    final db = await bd;
    return db.update(
      'planetas',
      planeta.toMap(),
      where: 'id = ?',
      whereArgs: [planeta.id],
    );
  }

  /// **Exclui um planeta do banco pelo ID**
  Future<int> excluirPlaneta(int id) async {
    final db = await bd;
    return await db.delete(
      'planetas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
