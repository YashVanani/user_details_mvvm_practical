import 'package:sqflite/sqflite.dart';
import 'package:users_details_mvvm/model/db_user_model/user_data_model.dart';
import 'package:users_details_mvvm/utils/app_constant.dart';
import 'package:users_details_mvvm/utils/app_string.dart';
import 'app_database.dart';

class DBOperations {
  static Database? _db;

  static final DBOperations _dbOperations = DBOperations._internal();

  factory DBOperations() {
    return _dbOperations;
  }

  Future<void> initDB() async {
    _db = await (AppDatabase.getInstance()).database;
  }

  DBOperations._internal();

  Future<int> storeUserDetails(UserDetailsDBModel userDetailsModel) async {
    final id = await _db!.insert(AppConstant.tblUserDetails, userDetailsModel.toJson());
    return id;
  }

  static Future<List<UserDetailsDBModel>> readAllUserDetailsPagination(int currentPage) async {
    if (currentPage == 1) {
      String orderBy;
      orderBy = '${UserDetailsFields.id} ASC';
      final result = await _db!.query(AppConstant.tblUserDetails, orderBy: orderBy, limit: 10);
      return result.map((json) => UserDetailsDBModel.fromJson(json)).toList();
    } else {
      String orderBy;
      orderBy = '${UserDetailsFields.id} ASC';
      final result = await _db!.query(AppConstant.tblUserDetails, orderBy: orderBy, limit: 10 * currentPage);
      return result.map((json) => UserDetailsDBModel.fromJson(json)).toList();
    }
  }

  Future<List<UserDetailsDBModel>> readUserDetail(int id) async {
    String orderBy;
    orderBy = '${UserDetailsFields.id} ASC';
    final result = await _db!.query(AppConstant.tblUserDetails, orderBy: orderBy, where: '${UserDetailsFields.id} = ?', whereArgs: [id]);
    return result.map((json) => UserDetailsDBModel.fromJson(json)).toList();
  }

  static deleteAll() async {
    await DBOperations().initDB();
    return await _db!.rawDelete("Delete from ${AppConstant.tblUserDetails}");
  }
}
