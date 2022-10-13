import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:wishlist_app/controller/auth_controller.dart';
import 'package:wishlist_app/screens/auth_screen.dart';
import 'package:wishlist_app/screens/home_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Constructor
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<FirebaseApp>(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else {
              return Root();
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class Root extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return authController.user.value != null ? HomeScreen() : AuthScreen();
    });
  }
}
