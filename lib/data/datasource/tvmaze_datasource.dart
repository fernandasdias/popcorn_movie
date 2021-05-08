import 'dart:convert';

import 'package:PopcornMovie/data/models/show.dart';
import 'package:PopcornMovie/domain/entities/show.dart';
import 'package:http/http.dart' show Client;

class TvMazeDatasource {
  static Future<ShowList> showIndex() async {
    Client client = Client();
    String url = 'https://api.tvmaze.com/shows?page=1';

    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.toString());
        return ShowList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to get API content');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}