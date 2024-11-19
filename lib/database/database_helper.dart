import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pas_mobile_11pplg1_10/menu/efootball/efootball_model.dart';

class animes {
  final int idTeam;
  final String strTeam;
  final String strLeague;
  final String strLogo;

  animes({
    required this.idTeam,
    required this.strTeam,
    required this.strLeague,
    required this.strLogo,
  });

  factory animes.fromJson(Map<String, dynamic> json) {
    return animes(
      idTeam: json['idTeam'],
      strTeam: json['strTeam'],
      strLeague: json['strLeague'],
      strLogo: json['strLogo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idTeam': idTeam,
      'strTeams': strTeam,
      'strLeague': strLeague,
      'imageUrl': strLogo,
    };
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('anime.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const animeTable = '''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        type TEXT NOT NULL,
        imageUrl TEXT NOT NULL
      )
    ''';

    await db.execute(animeTable);
  }

  Future<void> addFavorite(PostModel anime) async {
    final db = await instance.database;
    await db.insert('favorites', {
      'idTeam': anime.idTeam,
      'strTeam': anime.strTeam,
      'strLeague': anime.strLeague,
      'strLogo': anime.strLogo,
    });
  }

  Future<List<PostModel>> getFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');
    return result.map((map) => PostModel(
      idTeam: map['idTeam'] as int,
      strTeam: map['strTeam'] as String,
      strLeague: map['strLeague'] as String,
      strLogo: map['strLogo'] as String,
    )).toList();
  }

  Future<void> removeFavorite(int id) async {
    final db = await instance.database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> checkFavorite(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }

  Future<List<int>> getFavoriteIds() async {
    final db = await instance.database;
    final result = await db.query('favorites', columns: ['id']);
    return result.map((row) => row['id'] as int).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
