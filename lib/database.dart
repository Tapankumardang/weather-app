import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

class Database {

  connection(String city, String country) async {
    try {
      var settings = new ConnectionSettings(
          host: 'sql6.freemysqlhosting.net',
          port: 3306,
          user: 'sql6449788',
          password: 'EJF1AwDlpm',
          db: 'sql6449788');

      var conn = await MySqlConnection.connect(settings);
      if (conn != null) {
        print("Database connected");
      } else {
        print("Database connection failed");
      }
      print(conn.toString());

      var result = await conn.query(
          'insert into tapan_search_history (city,country) values (?, ?)',
          [city, country]);
      var results = await conn.query('select * from tapan_search_history');

      print(results.toString());
    } catch (e) {
      print(e);
    }
  }
}
