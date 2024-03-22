import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path2;
import '../models/todoModel.dart';

class DatabaseHelper {
  static Database? _database;
  static const String TABLE_NAME = 'todos';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final String path = path2.join(await getDatabasesPath(), 'todo.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, is_completed INTEGER, created_at TEXT, updated_at TEXT)',
        );
      },
    );
  }

  Future<void> insertTodo(TodoModel todo) async {
    final Database db = await database;
    await db.insert(TABLE_NAME, todo.toMap());
  }

  Future<List<TodoModel>> getTodos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
    return List.generate(maps.length, (i) {
      return TodoModel(
        id: maps[i]['id'],
        title: maps[i]['title'],
        isCompleted: maps[i]['is_completed'],
        createdAt: maps[i]['created_at'],
        updatedAt: maps[i]['updated_at'],
      );
    });
  }

  Future<void> updateTodo(TodoModel todo) async {
    final Database db = await database;
    await db.update(
      TABLE_NAME,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> taskStatus(int id,int isCompleted) async {
    final Database db = await database;
    await db.update(
      TABLE_NAME,
      {"is_completed":isCompleted},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTodo(int id) async {
    final Database db = await database;
    await db.delete(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
