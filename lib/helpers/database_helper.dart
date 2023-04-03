import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'PocketGPT.db';
  static const _databaseVersion = 3;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    print(path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE chats (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imageUrl TEXT NOT NULL,
        title TEXT NOT NULL,
        category TEXT NOT NULL,
        createTime TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chatId INTEGER NOT NULL,
        data TEXT NOT NULL,
        chatTime TEXT NOT NULL,
        isSentByUser INTEGER NOT NULL,
        FOREIGN KEY (chatId) REFERENCES chats (id) ON DELETE CASCADE
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // if (oldVersion < 2) {
    //   await db.execute('''
    //   ALTER TABLE messages ADD COLUMN isSentByUser INTEGER NOT NULL DEFAULT 0
    // ''');
    // }
    // Add more upgrade steps if needed for future versions
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {List<String>? whereConditions,
      List<List<dynamic>>? whereArgsLists,
      int? limit,
      int? offset,
      String? orderby}) async {
    Database db = await instance.database;

    String? where;
    List<dynamic>? whereArgs;

    if (whereConditions != null && whereArgsLists != null) {
      where = whereConditions.join(' AND ');
      whereArgs = whereArgsLists.expand((args) => args).toList();
    }

    return await db.query(table,
        where: where,
        whereArgs: whereArgs,
        limit: limit,
        offset: offset,
        orderBy: orderby);
  }

  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
