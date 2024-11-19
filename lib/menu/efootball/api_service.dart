import 'dart:convert';
import 'package:http/http.dart' as http;
import 'efootball_model.dart';

class ApiService {
  final String baseUrl = 'https://www.thesportsdb.com/api/v1/json/3/search_all_teams.php?l=English%20Premier%20League';

  Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> postsData = jsonResponse['teams'];

      return postsData.map((json) => PostModel.fromJson(json)).toList();
    } else {
      print('Failed to load posts: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load posts');
    }
  }
}
