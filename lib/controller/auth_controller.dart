// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxString tab = 'Login'.obs;
  Rx<User?> user = Rx<User?>(FirebaseAuth.instance.currentUser);
  final db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  void changeTab(String value) {
    tab.value = value;
  }

  Future<void> registerUser(
    String emailAddress,
    String password,
    String userName,
  ) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      final userStore = <String, dynamic>{
        "uid": userCredential.user!.uid,
        "userName": userName,
      };
      db
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(userStore)
          .onError((e, _) => print("Error writing document: $e"));
    } on FirebaseAuthException catch (e) {
      print(e.code);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loginUser(
    String emailAddress,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}
