import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lexit/constant/appColors.dart';
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
  List<String> prices = ["199", "249", "399", "500", "1199"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 30),
            child: Text(
              'Hey Luke,',
              style: TextStyle(fontSize: 24),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 10),
            child: Text(
              'Search best lawyers near you',
              style: TextStyle(fontSize: 28, color: AppColors.textSecondary),
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
                    image:
                        'https://images.unsplash.com/photo-1549923746-c502d488b3ea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1471&q=80',
                    name: names[index],
                    price: prices[index],
                    isAvailable: isAvailable[index],
                    services: const [
                      'Real Estate',
                      'High Court',
                      'Documentation',
                    ]),
              );
            },
          ),
        ],
      ),
    ));
  }
}
