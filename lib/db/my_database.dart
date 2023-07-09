import 'package:database_app/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MainDatabase {
  MainDatabase._init();
  static MainDatabase instance = MainDatabase._init();
  static Database? database;

  Future<Database?> getDatabase() async {
    if (database != null) {
      return database;
    } else {
      database = await createDatabase("mydatabase");
      return database;
    }
  }

  Future<Database> createDatabase(String databaseName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        const String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
        const String textType = "TEXT NOT NULL";
        const String digitType = "INTEGER NOT NULL";
        return await db.execute('''
            CREATE TABLE $table(
              ${FiledDatabase.id} $idType,
              ${FiledDatabase.age} $digitType,
              ${FiledDatabase.name} $textType,
              ${FiledDatabase.occupation} $textType
            )
          ''');
      },
    );
  }

  Future<List<MainModel>> getAllData() async {
    final db = await MainDatabase.instance.getDatabase();

    final result = await db!.query(
      table,
    );

    return List<MainModel>.from(
      result.map(
        (v) => MainModel.fromJson(v),
      ),
    );
  }

  Future<MainModel> getById(int? id) async {
    final db = await MainDatabase.instance.getDatabase();
    final result = await db!.query(
      table,
      columns: FiledDatabase.allValues,
      where: "${FiledDatabase.id} = ?",
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return MainModel.fromJson(result.first);
    } else {
      throw Exception("Can't load the data!!");
    }
  }

  Future<MainModel> postData(MainModel data) async {
    final db = await MainDatabase.instance.getDatabase();

    final result = await db!.insert(
      table,
      data.toJson(),
    );
    return data.copy(
      id: result,
    );
  }

  Future<int> updateData(MainModel data) async {
    final db = await MainDatabase.instance.getDatabase();
    final result = await db!.update(
      table,
      data.toJson(),
      where: "${FiledDatabase.id} = ?",
      whereArgs: [data.id],
    );
    return result;
  }

  Future<int> deleteData(int? id) async {
    final db = await MainDatabase.instance.getDatabase();
    final result = await db!.delete(
      table,
      where: "${FiledDatabase.id} = ?",
      whereArgs: [id],
    );
    return result;
  }

  Future closeDatabase() async {
    final db = await MainDatabase.instance.getDatabase();
    await db!.close();
  }
}
