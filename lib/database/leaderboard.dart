import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LeaderboardDatabase {
  static final LeaderboardDatabase _instance = LeaderboardDatabase._internal();
  Database? _database;

  LeaderboardDatabase._internal();

  factory LeaderboardDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'leaderboard.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE leaderboard(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            playerName TEXT,
            score INTEGER
          )
          ''',
        );
      },
    );
  }

  Future<void> insertScore(String category, String playerName, int score) async {
    final db = await database;
    await db.insert(
      'leaderboard',
      {'category': category, 'playerName': playerName, 'score': score},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> fetchLeaderboard(String category) async {
    final db = await database;
    return await db.query(
      'leaderboard',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'score DESC',
      limit: 10,
    );
  }
}
