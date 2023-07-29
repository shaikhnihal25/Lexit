import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/sockets/src/sockets_io.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:lexit/pages/indexPage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../auth/loginPage.dart';
import '../homePgae.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkNetworkState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // Add some delay to display the splash screen for a few seconds (optional)
    await Future.delayed(const Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is already logged in, navigate to HomePage
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => IndexPage()));
    } else {
      // User is not logged in, navigate to LoginPage
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  checkNetworkState() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      VxToast.show(context,
          msg: 'No Internet Connection!',
          bgColor: AppColors.errorColor,
          textColor: AppColors.background,
          showTime: 5000);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Customize your splash screen UI here
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/LEXIT.gif'),
      ),
    );
  }
}
