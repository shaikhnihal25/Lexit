// Import the necessary packages
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lexit/pages/auth/loginPage.dart';
import 'package:lexit/pages/loading/loadingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constant/appColors.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();
  String _gender = 'Male';
  File? _imageFile;

  final picker = ImagePicker();
  final _storage = firebase_storage.FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                'Enter Below Details To SignUp'
                    .text
                    .textStyle(const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold))
                    .make(),
                30.heightBox,
                _imageFile != null
                    ? InkWell(
                        onTap: _selectImage,
                        child: VxCircle(
                          radius: 125,
                          backgroundImage: DecorationImage(
                              image: FileImage(_imageFile!), fit: BoxFit.fill),
                        ),
                      )
                    : VxCircle(
                        radius: 125,
                        backgroundColor: AppColors.textSecondary,
                        child: Center(
                            child: IconButton(
                                onPressed: () {
                                  _selectImage();
                                },
                                icon: const Icon(Icons.image)))),
                Neumorphic(
                  style: NeumorphicStyle(
                    color: AppColors.background,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Your Name',
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
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Phone No.',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ).pOnly(top: 30, left: 30, right: 30),
                'Select Your Gender'
                    .text
                    .textStyle(const TextStyle(fontSize: 18))
                    .make()
                    .pOnly(top: 30),
                Neumorphic(
                  style: NeumorphicStyle(
                    color: AppColors.background,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 30, left: 30, top: 5, bottom: 5),
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      value: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        hintText: 'Create Password',
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
                      controller: _confirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        hintText: 'Re-Enter Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ).pOnly(top: 30, left: 30, right: 30),
                if (_imageFile != null &&
                    _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _confirmPassword.text.isNotEmpty)
                  NeumorphicButton(
                      style:
                          const NeumorphicStyle(color: AppColors.buttonPrimary),
                      onPressed: () {
                        _signup();
                      },
                      child: const SizedBox(
                        height: 50,
                        width: 380,
                        child: Center(
                            child: Text(
                          'SignUp',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      )).pOnly(top: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  void _signup() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LoadingScreen()));
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final phone = '+91' + _phoneController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPassword.text.trim();
      final gender = _gender;

      if (password != confirmPassword) {
        VxToast.show(context,
            msg: 'Password not matched!', bgColor: AppColors.errorColor);
      } else {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: confirmPassword);

        // Upload the image to Firebase Storage and get the download URL

        String imageUrl = '';
        if (_imageFile != null) {
          final ref = _storage.ref().child('users/${_auth.currentUser?.uid}');
          final uploadTask = ref.putFile(_imageFile!);
          final snapshot = await uploadTask.whenComplete(() {});
          imageUrl = await snapshot.ref.getDownloadURL();
        }

        // Save the user data in
        // Save the user data in Firestore
        await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'gender': gender,
          'imageUrl': imageUrl,
          'appointmentHistory': [
            {
              'title': '',
              'subtitle': '',
              'price': '',
              'date': '',
              'time': '',
              'service': '',
              'providerID': '',
              'status': ''
            }
          ]
        });

        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString('profileImage', imageUrl);
      }
      VxToast.show(context,
          msg: 'Your Account is Created! Now Login to Continue.',
          bgColor: AppColors.successColor);

      // User signed up successfully, handle navigation to the next screen
      // For example, navigate to a home page or dashboard
    } on FirebaseAuthException catch (e) {
      VxToast.show(context,
          msg: e.message.toString(), bgColor: AppColors.errorColor);
      // Handle signup errors
      print('Signup Error: $e');
    }
  }
}
