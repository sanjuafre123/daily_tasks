import 'package:flutter/material.dart';
import '../utils/storage_helper.dart';
import 'details_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    user = await StorageHelper.getUserDetails();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await StorageHelper.clearUserDetails();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          )
        ],
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          ListTile(
            title: Text('${user!['firstName']} ${user!['lastName']}'),
            subtitle: Text(user!['email']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(user: user!),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
