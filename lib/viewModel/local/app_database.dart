import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:users_details_mvvm/utils/app_constant.dart';
import 'package:users_details_mvvm/utils/app_string.dart';

class AppDatabase {
  Database? _database;
  static AppDatabase? _appDatabase;

  static AppDatabase getInstance() {
    _appDatabase ??= AppDatabase();
    return _appDatabase!;
  }


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('userDetailsApp.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
  CREATE TABLE ${AppConstant.tblUserDetails} ( 
    ${UserDetailsFields.id} $idType,
    ${UserDetailsFields.name} $textType,
    ${UserDetailsFields.email} $textType,
    ${UserDetailsFields.dob} $textType,
    ${UserDetailsFields.joinDate} $textType,
    ${UserDetailsFields.profileImage} $textType,
    ${UserDetailsFields.country} $textType,
    ${UserDetailsFields.city} $textType,
    ${UserDetailsFields.state} $textType,
    ${UserDetailsFields.postcode} $textType,
    ${UserDetailsFields.age} $integerType
  )
''');
  }
}
