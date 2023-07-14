import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges =>
      _firebaseAuth
          .authStateChanges(); //PRENDE IN MANIERA COSTANTI I CAMBIAMENTI

  Future<void> signInWithEmailAndPassword({required String email, required String password }) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({required String email, required String password }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  String getCurrentUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String email = user.email!;
      return email;
    } else {
      return '';
    }
  }
}