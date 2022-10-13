import 'package:cloud_firestore/cloud_firestore.dart';

class WishModal {
  late String id;
  late String wish;
  late double price;
  late String image;
  late bool fulfilled;
  late Timestamp wishedOn;

  WishModal(
    this.id,
    this.wish,
    this.price,
    this.image,
    this.fulfilled,
    this.wishedOn,
  );

  WishModal.fromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc) {
    id = doc.id;
    wish = doc['wish'];
    price = doc['price'];
    image = doc['image'];
    fulfilled = doc['fulfilled'];
    wishedOn = doc['wishedOn'];
  }
}
