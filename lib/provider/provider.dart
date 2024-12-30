import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/helper.dart';
import '../modal/modal.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> todos = [];
  bool isGrid = false;
  bool isDarkTheme = false;
  ApiHelper apiHelper = ApiHelper();


  Future<void> fetchTodos() async {
    List jsonResponse = await apiHelper.fetchApi();
    todos = jsonResponse.map((data) => Todo.fromJson(data)).toList();
    notifyListeners();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    isGrid = prefs.getBool('isGrid') ?? false;
    isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  Future<void> toggleView() async {
    isGrid = !isGrid;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isGrid', isGrid);
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    isDarkTheme = !isDarkTheme;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme);
    notifyListeners();
  }

  TodoProvider() {
    loadPreferences();
    fetchTodos();
  }
}