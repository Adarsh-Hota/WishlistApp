import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wishlist_app/controller/auth_controller.dart';
import 'package:wishlist_app/utils.dart';
import 'package:wishlist_app/widgets/login_widget.dart';
import 'package:wishlist_app/widgets/register_widget.dart';

class AuthScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  AuthScreen({Key? key}) : super(key: key);

  Widget buildTab(String text, bool selected, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 40,
      child: Center(
        child: Text(
          text,
          style: selected
              ? textStyle(
                  22,
                  Colors.lightBlueAccent,
                  FontWeight.bold,
                  fontType: 4,
                )
              : textStyle(
                  22,
                  Colors.grey,
                  FontWeight.bold,
                  fontType: 4,
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wishly',
                    style: textStyle(
                      35,
                      Colors.lightBlue,
                      FontWeight.bold,
                      fontType: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => authController.changeTab('Login'),
                          child: buildTab(
                            'Login',
                            authController.tab.value == 'Login',
                            context,
                          ),
                        ),
                        InkWell(
                          onTap: () => authController.changeTab('Register'),
                          child: buildTab(
                            'Register',
                            authController.tab.value == 'Register',
                            context,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => authController.tab.value == 'Login'
                      ? LoginWidget()
                      : RegisterWidget())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
