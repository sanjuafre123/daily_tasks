import 'package:flutter/foundation.dart';
import 'package:placement_tasks/modal/modal.dart';
import 'package:placement_tasks/services/auth_services.dart';
import 'package:placement_tasks/services/firestor_services.dart';

class UserProvider with ChangeNotifier {
  List userData = [];

  void signUpUserUsingEmailAndPassword(UserModal user, String password) {
    AuthService.authService
        .signUpUserWithEmailAndPassword(user.email, password);
    FirestoreServices.firestoreServices.addUserToFirestore(user);
  }

  Future<void> signOutUser()
  async {
    await AuthService.authService.logout();
  }

  Future<void> signInUsingEmailAndPassword(String email,String password)
  async {
    await AuthService.authService.signInUserWithEmailAndPassword(email, password);
  }

  void signInWithGoogle()
  {
    AuthService.authService.signInWithGoogle();
  }
}
