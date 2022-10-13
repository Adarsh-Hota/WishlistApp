import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wishlist_app/controller/auth_controller.dart';
import 'package:wishlist_app/utils.dart';

class RegisterWidget extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: TextFormField(
            controller: usernameController,
            style: textStyle(16, Colors.black, FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              hintText: 'Username',
              hintStyle: textStyle(16, Colors.grey, FontWeight.w500),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: TextFormField(
            controller: emailController,
            style: textStyle(16, Colors.black, FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              hintText: 'Email',
              hintStyle: textStyle(16, Colors.grey, FontWeight.w500),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: TextFormField(
            controller: passwordController,
            style: textStyle(16, Colors.black, FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              hintText: 'Password',
              hintStyle: textStyle(16, Colors.grey, FontWeight.w500),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * (0.6),
          height: 45,
          child: TextButton(
            onPressed: () => authController.registerUser(
              emailController.text,
              passwordController.text,
              usernameController.text,
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.lightBlue,
            ),
            child: Text(
              'Register',
              style: textStyle(
                20,
                Colors.white,
                FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
