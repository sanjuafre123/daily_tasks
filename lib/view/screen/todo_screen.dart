import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modal/modal.dart';
import '../../provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  TodoScreenState createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.1,
        title: const Text(
          'Todos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(provider.isGrid ? Icons.list : Icons.grid_view),
            onPressed: provider.toggleView,
          ),
          IconButton(
            icon: Icon(
                provider.isDarkTheme ? Icons.dark_mode : Icons.light_mode),
            onPressed: provider.toggleTheme,
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          if (provider.todos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: provider.isGrid
                ? GridView.builder(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: provider.todos.length,
              itemBuilder: (context, index) {
                return _buildGridTodoCard(provider.todos[index]);
              },
            )
                : ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder: (context, index) {
                return _buildListTodoTile(provider.todos[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildListTodoTile(Todo todo) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: todo.completed ? Colors.green.shade100 : Colors.red.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            todo.completed ? Icons.check_circle : Icons.pending,
            color: todo.completed ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          todo.title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          todo.completed ? 'Completed' : 'Pending',
          style: TextStyle(
            color: todo.completed ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }

  Widget _buildGridTodoCard(Todo todo) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: todo.completed
              ? [Colors.green.shade300, Colors.green.shade100]
              : [Colors.red.shade300, Colors.red.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  todo.completed ? 'Completed' : 'Pending',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                Icon(
                  todo.completed ? Icons.check_circle : Icons.pending,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
