import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/user.dart';

class UserFirebase {
  final firestoreInstance = FirebaseFirestore.instance;

  Future createUser(User user) async {
    return await firestoreInstance
        .collection('User')
        .doc(user.userID)
        .set(user.toJson());
  }

  Future<User> getUser(String userID) async {
    User user;

    final snapshot =
        await FirebaseFirestore.instance.collection('User').doc(userID).get();
    user = User.fromJson(snapshot.data(), userID);

    return user;
  }

  Future updateUser(User user) async {
    return await firestoreInstance
        .collection('User')
        .doc(user.userID)
        .update(user.toJson());
  }
}
