import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lexit/backend/databaseServices.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:lexit/constant/constants.dart';
import 'package:lexit/pages/auth/loginPage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:velocity_x/velocity_x.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  final picker = ImagePicker();
  File? _imageFile;
  final _storage = firebase_storage.FirebaseStorage.instance;

  void _selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });

    _uploadImage();
  }

  _uploadImage() async {
    String imageUrl = '';
    if (_imageFile != null) {
      final ref = _storage.ref().child('users/${_auth.currentUser?.uid}');
      final uploadTask = ref.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() {});
      imageUrl = await snapshot.ref.getDownloadURL();

      LexitDatabase().updateUserPhoto(imageUrl);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0.0,
        title: const Text(
          'Edit Your Profile',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          IconButton(
            onPressed: () => _editProfile(context),
            icon: const Icon(
              Icons.edit,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const VxShimmer(
                  child: SizedBox(
                    width: 200,
                    height: 120,
                  ),
                  primaryColor: AppColors.textSecondary,
                );
              } else if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;

                final String name = userData['name'];
                final String profileUrl = userData['imageUrl'];
                final String phone = userData['phone'];
                final String email = userData['email'];
                if (profileUrl.isNotEmpty && profileUrl != null) {
                  profileIconImage = profileUrl;
                  print(profileIconImage);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          VxToast.show(context,
                              msg: 'Long press and hold to update image',
                              bgColor: Colors.amber,
                              showTime: 3000);
                        },
                        onLongPress: (() {
                          _selectImage();
                        }),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(profileUrl),
                          backgroundColor: AppColors.backgroundLight,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Name'),
                      subtitle: Text(name),
                      minLeadingWidth: 2,
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(email),
                      minLeadingWidth: 2,
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Phone'),
                      subtitle: Text(phone),
                      minLeadingWidth: 2,
                    ),
                    const SizedBox(height: 24.0),
                    // const Text(
                    //   'Profession:',
                    //   style: TextStyle(
                    //       fontSize: 16.0, fontWeight: FontWeight.bold),

                    // Text(profession),
                    ListTile(
                      leading: const Icon(Icons.logout_outlined),
                      title: const Text('Logout'),
                      subtitle:
                          const Text('You have to login again to use Lexit'),
                      minLeadingWidth: 2,
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    )
                  ],
                );
              } else {
                return const VxShimmer(
                  child: SizedBox(
                    width: 200,
                    height: 120,
                  ),
                  primaryColor: AppColors.textSecondary,
                );
              }
            }),
      ),
    );
  }

  void _editProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 16.0),
                // TextFormField(
                //   controller: dobController,
                //   decoration: const InputDecoration(labelText: 'Date of Birth'),
                //   onTap: () async {
                //     DateTime? pickedDate = await showDatePicker(
                //       context: context,
                //       initialDate: dob,
                //       firstDate: DateTime(1900),
                //       lastDate: DateTime.now(),
                //     );

                //     if (pickedDate != null) {
                //       dobController.text =
                //           pickedDate.toLocal().toString().split(' ')[0];
                //     }
                //   },
                // ),
                // const SizedBox(height: 16.0),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: professionController,
                  decoration: const InputDecoration(labelText: 'Profession'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // setState(() {
                //   name = nameController.text;
                //   phone = phoneController.text;
                //   profession = professionController.text;
                //   dob = DateTime.parse(dobController.text);
                // });
                LexitDatabase().updateUserProfile(nameController.text,
                    emailController.text, phoneController.text, '');

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
