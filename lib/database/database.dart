import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;
List listaDeViagens = [];

class LocalDatabase {
  Future get database async {

    if(_database != null) {
      return database;
    }

    _database = await _iniciarBancoDeDados('BancoLocal.db');

    return _database;
  }

  // path do banco de dados
  Future _iniciarBancoDeDados(String _path) async {
    final pathBanco = await getDatabasesPath();
    final path = join(pathBanco, _path);
    return await openDatabase(path, version: 1, onCreate: _criarBanco);
  }

  Future _criarBanco(Database db, int version) async {
    await db.execute('''
        CREATE TABLE Viagens(id INTEGER PRIMARY KEY,
                objetoJson JSON NOT NULL
        );
    '''
    );
  }

  Future gravarDadosLocalmente({dadosJson}) async {
    final bancoDeDados = await database;
    await bancoDeDados.insert("Viagens", {"objetoJson": dadosJson});
    print('${dadosJson} adicionados com sucesso');
    return 'adicionado';
  }

  Future lerDadosLocalmente() async {
    final bancoDeDados = await database;
    final todasAsViagens = await bancoDeDados!.query("Viagens");
    listaDeViagens = todasAsViagens;
    print(listaDeViagens);
    return 'dados lidos';
  }
}