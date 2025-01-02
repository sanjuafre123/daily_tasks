import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String usersApiUrl = 'https://dummyjson.com/users';
  final String authApiUrl = 'https://dummyjson.com/auth/login';

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(authApiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(usersApiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body)['users'];
    }
    throw Exception('Failed to fetch users');
  }
}
