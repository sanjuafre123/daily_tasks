import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static Future<void> saveUserDetails(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(user));
  }

  static Future<Map<String, dynamic>?> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user != null) {
      return json.decode(user);
    }
    return null;
  }

  static Future<void> clearUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }
}
