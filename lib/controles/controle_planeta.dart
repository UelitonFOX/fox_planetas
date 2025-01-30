import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modelos/planeta.dart';

class ControlePlaneta {
  static Database? _bd; // Instância única do banco de dados

  // Garante acesso ao banco de dados, inicializando-o caso necessário
  Future<Database> get bd async {
    if (_bd != null) return _bd!;
    _bd = await _initBD('planetas.db');
    return _bd!;
  }

  // Inicializa o banco de dados
  Future<Database> _initBD(String localArquivo) async {
    final caminhoBD = await getDatabasesPath();
    final caminho = join(caminhoBD, localArquivo);
    return await openDatabase(
      caminho,
      version: 1,
      onCreate: _criarBD, // Cria a tabela ao inicializar o banco
    );
  }

  // Cria a tabela 'planetas' no banco de dados
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

  // Retorna uma lista de planetas do banco de dados
  Future<List<Planeta>> lerPlanetas() async {
    final db = await bd;
    final resultado = await db.query('planetas');
    return resultado.map((item) => Planeta.fromMap(item)).toList();
  }

  // Insere um novo planeta no banco de dados
  Future<int> inserirPlaneta(Planeta planeta) async {
    final db = await bd;
    return await db.insert(
      'planetas',
      planeta.toMap(),
    );
  }

  // Altera os dados de um planeta existente
  Future<int> alterarPlaneta(Planeta planeta) async {
    final db = await bd;
    return db.update(
      'planetas',
      planeta.toMap(),
      where: 'id = ?', // Define o planeta a ser alterado pelo ID
      whereArgs: [planeta.id],
    );
  }

  // Exclui um planeta do banco de dados pelo ID
  Future<int> excluirPlaneta(int id) async {
    final db = await bd;
    return await db.delete(
      'planetas',
      where: 'id = ?', // Define o planeta a ser excluído pelo ID
      whereArgs: [id],
    );
  }
}
