import 'dart:convert';
import 'package:PopcornMovie/data/models/search_model.dart';
import 'package:PopcornMovie/data/models/show_detail.dart';
import 'package:PopcornMovie/data/models/showListModel.dart';
import 'package:PopcornMovie/domain/entities/showList.dart';
import 'package:http/http.dart' show Client;

class TvMazeDatasource {
  static Future<ShowList> showIndex() async {
    Client client = Client();
    String url = 'https://api.tvmaze.com/shows?page=1';

    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.toString());
        return ShowListModel().fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to get API content');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<ShowDetail> showDetail(int id) async {
    Client client = Client();
    String url = 'https://api.tvmaze.com/shows/$id?embed=cast';

    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.toString());
        return ShowDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to get API content');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<SearchModelList> searchShow(String searchTerm) async {
    Client client = Client();
    String url = 'https://api.tvmaze.com/search/shows?q=$searchTerm';

    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return SearchModelList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to get API content');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
