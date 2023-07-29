// Import the necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lexit/backend/authServices.dart';
import 'package:lexit/backend/notification/notificationServices.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:lexit/pages/auth/signUpPage.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              120.heightBox,
              'LEXIT'
                  .text
                  .textStyle(const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 18))
                  .make(),
              'One Shop For All Legal Needs'.text.make(),
              80.heightBox,
              Align(
                alignment: Alignment.centerLeft,
                child: 'Please login to continue'
                    .text
                    .textStyle(
                        TextStyle(fontSize: 26, color: AppColors.textSecondary))
                    .align(TextAlign.left)
                    .make()
                    .pOnly(left: 30),
              ),
              Neumorphic(
                style: NeumorphicStyle(
                  color: AppColors.background,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ).pOnly(top: 30, left: 30, right: 30),
              Neumorphic(
                style: NeumorphicStyle(
                  color: AppColors.background,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ).pOnly(top: 30, left: 30, right: 30),
              Align(
                alignment: Alignment.centerRight,
                child: 'forgot password?'
                    .text
                    .textStyle(TextStyle(color: AppColors.textSecondary))
                    .make()
                    .pOnly(right: 30, top: 20),
              ),
              NeumorphicButton(
                  style: NeumorphicStyle(color: AppColors.buttonPrimary),
                  onPressed: () {
                    LexitAuthServices().logInWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                        context);
                  },
                  child: const SizedBox(
                    height: 50,
                    width: 200,
                    child: Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  )).pOnly(top: 60),
              30.heightBox,
              'Create a new account?'.richText.tap(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              }).make(),
            ],
          ),
        ),
      ),
    );
  }
}
