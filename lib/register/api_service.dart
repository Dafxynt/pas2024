import 'dart:convert';
import 'package:http/http.dart' as http;
import 'postmodel.dart';

class ApiService {
  final String baseUrl = 'https://mediadwi.com/api/latihan/register-user';

  Future<PostModel> registerUser(String username, String password, String fullName, String email) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {
        'username': username,
        'password': password,
        'full_name': fullName,
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return PostModel.fromJson(jsonResponse); // Mengembalikan model
    } else {
      throw Exception('Failed to register user');
    }
  }
}
