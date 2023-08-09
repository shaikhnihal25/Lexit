import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:lexit/constant/constants.dart';
import 'package:lexit/widgets/lexCard.dart';
import 'package:lexit/widgets/lexTextField.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isAvailable = [true, false, true, true, false];
  List<String> names = [
    "Bryan Mike",
    "Sushant Mahtre",
    "Kumar Shanvi",
    "Pooja Rathod",
    "Sahil Khan"
  ];
  List<String> images = [
    "https://images.unsplash.com/photo-1589829545856-d10d557cf95f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
    "https://images.unsplash.com/photo-1505664194779-8beaceb93744?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
    "https://images.unsplash.com/photo-1521791055366-0d553872125f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80",
    "https://images.unsplash.com/photo-1573496267526-08a69e46a409?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1469&q=80",
    "https://images.unsplash.com/photo-1537511446984-935f663eb1f4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80"
  ];
  List<String> prices = ["199", "249", "399", "500", "1199"];
  var uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            String? name = snapshot.data?['name'];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30, top: 30),
                  child: Text(
                    'Hey $name,',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, top: 10),
                  child: Text(
                    'Search best lawyers near you',
                    style:
                        TextStyle(fontSize: 28, color: AppColors.textSecondary),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: LexTextField(),
                ),
                ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LawyerCard(
                          image: images[index],
                          name: names[index],
                          price: prices[index],
                          isAvailable: isAvailable[index],
                          services: servicesList[index]),
                    );
                  },
                ),
              ],
            );
          }),
    ));
  }
}
