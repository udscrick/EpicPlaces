import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper{

  static Future<Database> database() async{
    final dbPath =  await sql.getDatabasesPath();//WIll give the correct path of db in ios and android
    return sql.openDatabase(
     //Will create new if not already present
     path.join(dbPath,'places.db'),
     onCreate: (db,version){
       //Code to initialize db when it is creaed for the first time
       return db.execute("CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)");//Execute can run sql queries
     },
     version: 1
   );
  }

  static Future<void> insert(String table, Map<String,Object> data)async{
   
   final db = await DBHelper.database();
   db.insert(table, data,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>> getData(String table)async{
    final db = await DBHelper.database();
    return db.query(table);
  }
}