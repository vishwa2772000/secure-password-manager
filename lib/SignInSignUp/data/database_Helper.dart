import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal/SignInSignUp/models/User.dart';

class DatabaseHelper {

  static String path;
  static final _databaseName = "personal.db";
  static final _databaseVersion = 1;

  static final table_user = 'user_table';


  static final columnId = '_id';
  static final columnEmail = 'email';
  static final columnPassword = 'password';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table_user (
            $columnId INTEGER PRIMARY KEY,
            $columnEmail TEXT NOT NULL,
            $columnPassword TEXT NOT NULL
          )
          ''');

  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  static Future getFileData() async {
    return getDatabasesPath().then((s){
      return path=s;
    });
  }
  Future<int> insert(User user) async {
    Database db = await instance.database;
    return  await db.insert("user_table",user.toUserMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future checkUserLogin(String password) async
  {
    Database db = await instance.database;
    var res=await  db.rawQuery("select * from user_table where password = '$password'");
    if(res.length>0)
    {
      List list =
      res.toList().map((c) => User.fromMap(c)).toList() ;
      return list[0];
    }
    return null;
  }
 /* Future getUser() async{
    Database db = await instance.database;
    var logins=await  db.rawQuery("select * from logins");
    if(logins==null)
      return 0;
    return logins.length;

  }

  Future getUserData() async{
    Database db = await instance.database;
    var res=await  db.rawQuery("select * from logins");
    print("result user data $res");
    print("result user data "+res.toString());
    List list =
    res.toList().map((c) => User.fromMap(c)).toList() ;
    return list[0];

  }

  Future deleteUser(String email) async {
    Database db = await instance.database;
    var logins = db.delete('logins', where: "email = ?", whereArgs: [email]);
    return logins;
  }
*/
  Future update(User user,String email) async {
    Database db = await instance.database;
    var result=await db.update("user_table",user.toUserMap(),where: "email=?",whereArgs: [email]);
    return result;

  }}
