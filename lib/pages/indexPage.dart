import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lexit/backend/databaseServices.dart';
import 'package:lexit/constant/constants.dart';
import 'package:lexit/pages/appointment/appointmentHistory.dart';
import 'package:lexit/pages/appointmentBookingPage.dart';
import 'package:lexit/pages/documentPage.dart';
import 'package:lexit/pages/homePgae.dart';
import 'package:lexit/pages/notificationPage.dart';
import 'package:lexit/pages/profilePgae.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constant/appColors.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  String? profileImage;

  setProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profileImage = prefs.getString('updatedProfileImage') ??
        prefs.getString('profileImage');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setProfileImage();
  }

  final List<Widget> _icons = [
    Image.asset(
      'assets/icons/home.png',
      height: 30,
      width: 30,
    ),
    Image.asset(
      'assets/icons/calendar.png',
      height: 30,
      width: 30,
    ),
    Image.asset(
      'assets/icons/document.png',
      height: 30,
      width: 30,
    ),
    Image.asset(
      'assets/icons/circle-user.png',
      height: 30,
      width: 30,
    ),
  ];

  PageController _pageController = PageController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        elevation: 0, // Set elevation to 0 for no shadow
        backgroundColor:
            AppColors.background, // Customize the app bar background color
        title: const Text(
          'Lexit',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        toolbarHeight: 65, // Your app name here
        actions: [
          // Profile Avatar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const VxShimmer(
                        primaryColor: AppColors.background,
                        secondaryColor: AppColors.backgroundLight,
                        showAnimation: true,
                        showGradient: true,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 20,
                        ));
                  }
                  if (snapshot.hasData) {
                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;

                    final String name = userData['name'];
                    final String profileUrl = userData['imageUrl'];
                    return CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        profileUrl,
                      ),
                      radius: 20,
                    );
                  }
                  return const VxShimmer(
                      primaryColor: AppColors.background,
                      secondaryColor: AppColors.backgroundLight,
                      showAnimation: true,
                      showGradient: true,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                      ));
                }),
          ),
          // Notifications Icon Button
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              size: 28,
            ),
            onPressed: () {
              // Add the actions for the options icon button here
              // For example, show a dropdown menu with additional options.
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
          ),
          // Options Icon Button
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // LexitDatabase().uploadToFirebase();
              // Add the actions for the options icon button here
              // For example, show a dropdown menu with additional options.
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          const HomePage(),
          const AppointmentHistorySCreen(),
          LegalDocumentsPage(),
          UserProfilePage()
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
      extendBody: true,
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.textPrimary,
        selectedIconTheme: const IconThemeData(color: AppColors.textPrimary),
        showUnselectedLabels: false,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(color: AppColors.textPrimary),
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
          _pageController.animateToPage(value,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        },
        items: [
          BottomNavigationBarItem(
              icon: _icons[0],
              label: 'Home',
              backgroundColor: AppColors.background),
          BottomNavigationBarItem(icon: _icons[1], label: 'Appointments'),
          BottomNavigationBarItem(icon: _icons[2], label: 'Documents'),
          BottomNavigationBarItem(icon: _icons[3], label: 'Account')
        ]);
  }
}
