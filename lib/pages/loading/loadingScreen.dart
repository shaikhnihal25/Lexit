import 'package:flutter/material.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:lexit/pages/auth/loginPage.dart';

import '../indexPage.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void _waitAndNavigate() async {
    // Add some delay to display the splash screen for a few seconds (optional)
    await Future.delayed(const Duration(seconds: 5));

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _waitAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/loader.gif'),
          ),
          const Center(
            child: Text(
              'Hold ON! We are creating your account.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
