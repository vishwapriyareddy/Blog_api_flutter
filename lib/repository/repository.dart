// import 'package:http/http.dart' as http;

// class Repository {
//   final String _baseUrl = "http://192.168.1.67:9000/api";
//   httpGet(String api) async {
//     return await http.get(Uri.parse(_baseUrl + "/" + api));
//   }
// }

import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'db_connection.dart';

class Repository {
  late DatabaseConnection _connection;

  final String _baseUrl = 'https://rentoaapi.tech/public/api';
  Repository() {
    _connection = DatabaseConnection();
  }

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _connection.initDatabase();

    return _database!;
  }

  httpGet(String api) async {
    return await http.get(Uri.parse(_baseUrl + "/" + api));
  }

  httpGetById(String api, categoryId) async {
    return await http
        .get(Uri.parse(_baseUrl + "/" + api + "/" + categoryId.toString()));
  }

  httpPost(String api, data) async {
    return await http.post(Uri.parse(_baseUrl + "/" + api, data));
  }

  getAllLocal(table) async {
    var conn = await database;
    return await conn.query(table);
  }

  saveLocal(table, data) async {
    var conn = await database;
    return await conn.insert(table, data);
  }

  updateLocal(table, columnName, data) async {
    var conn = await database;
    return await conn.update(table, data,
        where: '$columnName =?', whereArgs: [data['productId']]);
  }

  getLocalByCondition(table, columnName, conditionalValue) async {
    var conn = await database;
    return await conn.rawQuery(
        'SELECT * FROM $table WHERE $columnName=?', ['$conditionalValue']);
  }
}
