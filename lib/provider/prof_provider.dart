
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class ProfileProvider extends ChangeNotifier{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? userData = UserModel(name: "", email: "",image: "", id: "");
  GetUser() async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      userData = UserModel.fromJson(value.data()!);
  notifyListeners();
    });
  }
  RemoveUser(){
    userData = null;
  }
}