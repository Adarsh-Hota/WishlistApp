import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wishlist_app/controller/home_controller.dart';
import 'package:wishlist_app/modals/wish_modal.dart';
import 'package:wishlist_app/utils.dart';

class WishItem extends StatelessWidget {
  final WishModal wish;
  final HomeController homeController = Get.find<HomeController>();

  WishItem({Key? key, required this.wish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: InkWell(
        onDoubleTap: () => homeController.deleteWish(wish.id),
        child: ListTile(
          leading: Image(
            image: NetworkImage(
              wish.image,
            ),
            width: 64,
            fit: BoxFit.fill,
          ),
          title: Text(
            wish.wish,
            style: textStyle(
              18,
              Colors.black,
              FontWeight.w700,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              '\$ ${wish.price}',
              style: textStyle(
                16,
                Colors.blueGrey,
                FontWeight.w600,
              ),
            ),
          ),
          trailing: Checkbox(
            value: wish.fulfilled,
            onChanged: (value) => homeController.fulfillWish(
              value!,
              wish.id,
            ),
          ),
        ),
      ),
    );
  }
}
