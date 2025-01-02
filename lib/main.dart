// import 'package:flutter/material.dart';
// import 'package:placement_tasks/provider/provider.dart';
// import 'package:placement_tasks/view/screen/todo_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// bool isDark = false;
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   sharedPreferences.getBool('isDarkTheme') ?? false;
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => TodoProvider(),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<TodoProvider>(context);
//     return MaterialApp(
//       themeMode: provider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       debugShowCheckedModeBanner: false,
//       home: TodoScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:placement_tasks/task2/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login System App',
      home: LoginScreen(),
    );
  }
}
