import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wishlist_app/controller/home_controller.dart';
import 'package:wishlist_app/utils.dart';
import 'package:wishlist_app/widgets/wishitem_widget.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final List<String> items = ['My account', 'Sign out'];

  HomeScreen({Key? key}) : super(key: key);

  dynamic openAddWishSheet(context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(
                () {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => homeController.selectImage(),
                            child: homeController.selectedImage.value == ''
                                ? const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.grey,
                                    size: 45,
                                  )
                                : Image(
                                    width: 90,
                                    height: 90,
                                    image: FileImage(
                                      File(
                                        homeController.selectedImage.value,
                                      ),
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextFormField(
                              controller: priceController,
                              style:
                                  textStyle(16, Colors.black, FontWeight.w500),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[300],
                                hintText: '\$ Price',
                                hintStyle:
                                    textStyle(16, Colors.grey, FontWeight.w500),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: titleController,
                        style: textStyle(16, Colors.black, FontWeight.w500),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: 'Title',
                          hintStyle:
                              textStyle(16, Colors.grey, FontWeight.w500),
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: TextButton(
                          onPressed: () async {
                            await homeController.addWish(
                              titleController.text,
                              double.parse(priceController.text),
                            );
                            titleController.clear();
                            priceController.clear();
                            homeController.selectedImage.value = '';
                            Get.back();
                            Get.snackbar('Success', 'Wish added');
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                          ),
                          child: Text(
                            'Add to my list',
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
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddWishSheet(context),
        backgroundColor: Colors.lightBlue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 25,
                bottom: 20,
                right: 25,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wish List',
                        style: textStyle(
                          30,
                          Colors.black,
                          FontWeight.w600,
                          fontType: 1,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[300],
                          shape: BoxShape.circle,
                        ),
                        child: Obx(
                          () => Center(
                            child: Text(
                              homeController.homeTab.value == 'Wishes'
                                  ? homeController.wishes.length.toString()
                                  : homeController.fulfilledWishes.length
                                      .toString(),
                              style: textStyle(
                                20,
                                Colors.white,
                                FontWeight.w600,
                                fontType: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: homeController.dropDownValue.value,
                            icon: const Icon(Icons.account_circle),
                            items: items
                                .map(
                                  (String item) => DropdownMenuItem(
                                    value: item,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(item),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              return homeController
                                  .changeDropDownValue(value.toString());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    (() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => homeController.changeTab('Wishes'),
                              child: Text(
                                'Wishes',
                                style: textStyle(
                                  20,
                                  homeController.homeTab.value == 'Wishes'
                                      ? Colors.black
                                      : Colors.grey,
                                  FontWeight.w600,
                                  fontType: 2,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () =>
                                  homeController.changeTab('Fulfilled'),
                              child: Text(
                                'Fulfilled',
                                style: textStyle(
                                  20,
                                  homeController.homeTab.value == 'Fulfilled'
                                      ? Colors.black
                                      : Colors.grey,
                                  FontWeight.w600,
                                  fontType: 2,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => homeController.homeTab.value == 'Wishes'
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) {
                        return WishItem(
                          wish: homeController.wishes[index],
                        );
                      }),
                      childCount: homeController.wishes.length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) {
                        return WishItem(
                          wish: homeController.fulfilledWishes[index],
                        );
                      }),
                      childCount: homeController.fulfilledWishes.length,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
