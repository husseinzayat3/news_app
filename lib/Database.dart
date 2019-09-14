import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableWords = 'MyCountryList';
//final String columnId = '_id';
final String columnName = 'name';
//final String columnSymbol = 'symbol';
//int count=1;
// data model class
class Country {

  int id;
  String name;
//  String symbol;

  Country();

  // convenience constructor to create a Word object
  Country.fromMap(Map<String, dynamic> map) {
//    id = map[columnId];
    name = map[columnName];
//    symbol = map[columnSymbol];
  }

  // convenience method to create a Map from this Word object
  /*Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
//      columnSymbol: symbol
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }*/
}
class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
}
// singleton class to manage the database
class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDatabase();

    return _db;
  }

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableWords (
                $columnName TEXT PRIMARY KEY
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(int count,String word) async {
//    count++;
    Database db = await database;
//    int id = await db.insert(tableWords, word.toMap());
    int id = await db.rawInsert(' INSERT INTO $tableWords($columnName) VALUES(?)',
    [ word]);
    return id;
  }
/*
  Future<int> getCount() async {
    Database db = await database;
    int result = await db.rawQuery('SELECT COUNT(*) FROM tableWords');

    return result;
  }
*/
 getCount() async {
    Database db =await database;
    var result = await db.rawQuery('SELECT COUNT(*) FROM $tableWords');

//    return result.length();
  }

 Future<List> getAllCountries() async {
    final db = await database;
//    var result = await db.query(tableWords, columns: [columnId, columnName]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');
   var result = await db.rawQuery("SELECT * FROM $tableWords");

   return result.toList();
  }
 /* Future<Country> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableWords,
        columns: [columnId, columnName],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Country.fromMap(maps.first);
    }
    return null;
  }
  getSymbol(String name) async {
    final db = await database;
//    var res =await  db.query("MyList", where: "name = ?", whereArgs: [name],columns: [columnSymbol]);
    var result = await db.rawQuery("SELECT * FROM $tableWords WHERE name=$name",);

    return result.isNotEmpty ? Country.fromMap(result.first) : Null ;
//    return result.toString();
  }*/
}