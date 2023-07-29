import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:lexit/pages/homePgae.dart';
import 'package:lexit/pages/indexPage.dart';
import 'package:lexit/pages/loading/loadingScreen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../pages/auth/signUpPage.dart';

class LexitAuthServices {
  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
        "name": name,
        "email": user?.email,
      });

      return user!;
    } catch (error) {
      print(error.toString());
    }
  }

  Future<User?> logInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const IndexPage()));

      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      VxToast.show(context,
          msg: error.message.toString(),
          bgColor: AppColors.errorColor,
          textColor: AppColors.background);
    }
  }
}
