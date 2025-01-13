import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:placement_tasks/task2/screens/component/text_field.dart';
import 'package:provider/provider.dart';

import '../../modal/user_modal.dart';
import '../../provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _toastShownOnline = false;
  bool _toastShownOffline = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);
    final userProviderFalse =
        Provider.of<UsersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: const Text(
          'User Manager',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.contains(ConnectivityResult.mobile) ||
              snapshot.data!.contains(ConnectivityResult.wifi)) {
            if (!_toastShownOnline) {
              Fluttertoast.showToast(
                msg: "Data has been restored in database",
                backgroundColor: Colors.green,
              );
              _toastShownOnline = true;
              _toastShownOffline = false; // Reset offline flag
            }
            return FutureBuilder(
              future: userProvider.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: userProvider.usersModal.length,
                      itemBuilder: (context, index) {
                        UsersModal users = userProvider.usersModal[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(users.avatar),
                            ),
                            title: Text(
                              users.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    users.email,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Role: ${users.role.name}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Created: ${users.creationAt}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Updated: ${users.updatedAt}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            if (!_toastShownOffline) {
              Fluttertoast.showToast(
                msg: "You're currently offline! Showing offline data!",
                backgroundColor: Colors.red,
              );
              _toastShownOffline = true;
              _toastShownOnline = false;
            }
            return FutureBuilder(
              future: userProvider.readDataFromDb(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  List<DatabaseUsers> usersModal = userProvider.databaseData
                      .map((e) => DatabaseUsers.fromMap(e))
                      .toList();

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: usersModal.length,
                      itemBuilder: (context, index) {
                        DatabaseUsers users = usersModal[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(users.avatar),
                            ),
                            title: Text(
                              users.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    users.email,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Role: ${users.role}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Created: ${users.creationAt}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Updated: ${users.updatedAt}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    var txtName = TextEditingController();
                                    var txtEmail = TextEditingController();
                                    var txtRole = TextEditingController();
                                    DateTime updatedDate = DateTime.now();
                                    txtName.text = users.name;
                                    txtEmail.text = users.email;
                                    txtRole.text = users.role;
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        title: const Text('Update Data'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomTextField(
                                              hintText: "Name",
                                              controller: txtName,
                                              prefixIcon: Icons.person,
                                            ),
                                            const SizedBox(height: 10),
                                            CustomTextField(
                                              hintText: "Email",
                                              controller: txtEmail,
                                              prefixIcon: Icons.mail,
                                            ),
                                            const SizedBox(height: 10),
                                            CustomTextField(
                                              hintText: "Role",
                                              controller: txtRole,
                                              prefixIcon: Icons.business,
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          Consumer<UsersProvider>(
                                            builder: (context, value, child) =>
                                                TextButton(
                                              onPressed: () async {
                                                users.email = txtEmail.text;
                                                users.name = txtName.text;
                                                users.role = txtRole.text;
                                                users.updatedAt =
                                                    "${updatedDate.day}/${updatedDate.month}/${updatedDate.year}  ${updatedDate.hour}:${updatedDate.minute}:${updatedDate.second}";
                                                await value.updateDbData(users);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await userProviderFalse
                                        .deleteDataInDb(users.id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
