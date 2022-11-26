import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project/provider/prof_provider.dart';
import 'package:graduation_project/view/widgets/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../view/design/login_screen.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();


  void googleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await _auth.signInWithCredential(credential).then((user) async {
      await user.user!.uid.isEmpty ? saveUser(_googleSignIn.currentUser!.displayName!, user):
      Get.offAll(Nav());
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("gid", _googleSignIn.currentUser!.id);

    notifyListeners();
  }

  void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(Nav());
    } catch (e) {
      Get.snackbar("Login Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("id", _auth.currentUser!.uid);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void signOut() async {
    await _auth.signOut();
    ProfileProvider().RemoveUser();
    Get.offAll(LoginScreen());
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove("id");
      preferences.remove("gid");

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void register(String name, String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      await saveUser(name, user);

    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("uid", _auth.currentUser!.uid);
    notifyListeners();
    Get.offAll(Nav());
  }

  saveUser(String name, UserCredential user) async {
    UserModel userModel = UserModel(
        name: name,
        email: user.user!.email!,
        image: "",
        id: user.user!.uid);
    await _firestore
        .collection("users")
        .doc(user.user!.uid)
        .set(userModel.toJson());
  }


}
