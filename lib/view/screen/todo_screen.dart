import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List todos = [];
  bool isGridView = false;
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    _fetchTodos();
    _loadPreferences();
  }

  Future<void> _fetchTodos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200) {
      setState(() {
        todos = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isGridView = prefs.getBool('isGridView') ?? false;
      isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGridView', isGridView);
    await prefs.setBool('isDarkTheme', isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todos'),
          actions: [
            IconButton(
              icon: Icon(isGridView ? Icons.list : Icons.grid_view),
              onPressed: () {
                setState(() {
                  isGridView = !isGridView;
                  _savePreferences();
                });
              },
            ),
            IconButton(
              icon: Icon(isDarkTheme ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  isDarkTheme = !isDarkTheme;
                  _savePreferences();
                });
              },
            ),
          ],
        ),
        body: todos.isEmpty
            ? Center(child: CircularProgressIndicator())
            : isGridView
            ? GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return _buildTodoCard(todos[index]);
          },
        )
            : ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return _buildTodoCard(todos[index]);
          },
        ),
      ),
    );
  }

  Widget _buildTodoCard(todo) {
    return Card(
      color: todo['completed'] ? Colors.green.shade100 : Colors.red.shade100,
      child: ListTile(
        title: Text(todo['title']),
        trailing: Icon(
          todo['completed'] ? Icons.check_circle : Icons.pending,
          color: todo['completed'] ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
