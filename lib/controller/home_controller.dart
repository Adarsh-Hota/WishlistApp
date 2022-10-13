import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wishlist_app/modals/wish_modal.dart';

class HomeController extends GetxController {
  RxString homeTab = 'Wishes'.obs;
  RxString dropDownValue = 'My account'.obs;
  RxString selectedImage = ''.obs;
  RxList<WishModal> wishes = <WishModal>[].obs;
  RxList<WishModal> fulfilledWishes = <WishModal>[].obs;

  @override
  void onInit() {
    super.onInit();
    getWishes();
    getFulfilledWishes();
  }

  void changeTab(String value) {
    homeTab.value = value;
  }

  void changeDropDownValue(String newValue) async {
    dropDownValue.value = newValue;
    if (dropDownValue.value == 'Sign out') {
      await signOutUser();
      await Get.delete<HomeController>();
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> selectImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = pickedFile.path;
    }
  }

  void getFulfilledWishes() {
    fulfilledWishes.bindStream(
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('wishes')
          .where('fulfilled', isEqualTo: true)
          .snapshots()
          .map(
        (event) {
          List<WishModal> wishList = <WishModal>[];
          List<QueryDocumentSnapshot<Object?>> docsList = event.docs;
          for (var element in docsList) {
            wishList.add(WishModal.fromDocumentSnapshot(element));
          }

          return wishList;
        },
      ),
    );
  }

  Future<void> fulfillWish(bool wishStatus, String wishId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishes')
        .doc(wishId)
        .update({'fulfilled': wishStatus});
  }

  void getWishes() {
    wishes.bindStream(
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('wishes')
          .where('fulfilled', isEqualTo: false)
          .snapshots()
          .map(
        (event) {
          List<WishModal> wishList = <WishModal>[];
          List<QueryDocumentSnapshot<Object?>> docsList = event.docs;
          for (var element in docsList) {
            wishList.add(WishModal.fromDocumentSnapshot(element));
          }

          return wishList;
        },
      ),
    );
  }

  Future<void> addWish(String wish, double price) async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('File 1')
        .putFile(File(selectedImage.value));
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
    String imageUrl = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishes')
        .add({
      'wish': wish,
      'price': price,
      'image': imageUrl,
      'fulfilled': false,
      'wishedOn': DateTime.now(),
    });
  }

  Future<void> deleteWish(String wishId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishes')
        .doc(wishId)
        .delete();
  }
}
