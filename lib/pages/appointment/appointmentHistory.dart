import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:lexit/pages/appointment/appointmentDetails.dart';
import 'package:lexit/pages/appointmentBookingPage.dart';
import 'package:lexit/pages/indexPage.dart';
import 'package:velocity_x/velocity_x.dart';

class AppointmentHistorySCreen extends StatefulWidget {
  const AppointmentHistorySCreen({super.key});

  @override
  State<AppointmentHistorySCreen> createState() =>
      _AppointmentHistorySCreenState();
}

class _AppointmentHistorySCreenState extends State<AppointmentHistorySCreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0.0,
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: const Text(
          'Appointment History',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var appointments = snapshot.data!['appointments'];
                        var status =
                            snapshot.data!['appointments'][index]['status'];
                        String lawyerName = appointments[index]['lawyerName'];
                        String service = appointments[index]['service'];
                        String date = appointments[index]['date'];
                        String time = appointments[index]['time'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            30.heightBox,
                            'Active Appointment'
                                .text
                                .textStyle(const TextStyle(
                                    fontSize: 22, color: AppColors.textPrimary))
                                .make()
                                .pOnly(left: 20),
                            status == 'active'
                                ? ListTile(
                                    onTap: () {
                                      Get.to(AppointmentDetailsScreen(
                                        lawyerName: lawyerName,
                                        service: service,
                                        date: date,
                                        time: time,
                                      ));
                                    },
                                    tileColor: Color.fromRGBO(6, 184, 0, 0.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    title: Text(lawyerName),
                                    subtitle: Text(service),
                                    trailing: Text(date + '    |   ' + time),
                                    leading: Icon(
                                      Icons.outlined_flag_outlined,
                                      color: AppColors.successColor,
                                      size: 32,
                                    ),
                                  ).p(12)
                                : ListTile(
                                    tileColor: Color.fromRGBO(6, 184, 0, 0.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    title: Text('No Active Appointments'),
                                    subtitle: Text('Book a new appointment'),
                                    trailing: InkWell(
                                        onTap: () {
                                          Get.to(IndexPage());
                                        },
                                        child: Text(
                                          'Book Now',
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    leading: Icon(
                                      Icons.hourglass_empty,
                                      color: AppColors.successColor,
                                      size: 32,
                                    ),
                                  ).p(12),
                          ],
                        );
                      },
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(_auth.currentUser!.uid)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              'Expired Appointments ( History )'
                                  .text
                                  .textStyle(const TextStyle(
                                      fontSize: 22,
                                      color: AppColors.textPrimary))
                                  .make()
                                  .pOnly(left: 20),
                              ListView.builder(
                                itemCount:
                                    snapshot.data!['appointments'].length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  var appointments =
                                      snapshot.data!['appointments'];
                                  String lawyerName =
                                      appointments[index]['lawyerName'];
                                  String service =
                                      appointments[index]['service'];
                                  String date = appointments[index]['date'];
                                  String time = appointments[index]['time'];
                                  String status = appointments[index]['status'];
                                  if (status == "expired") {}
                                  return ListTile(
                                    tileColor:
                                        Color.fromRGBO(153, 153, 153, 0.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    title: Text(lawyerName + '  |  ' + status),
                                    subtitle: Text(service),
                                    trailing: Text(date + '    |   ' + time),
                                    // leading: Icon(
                                    //   Icons.history,
                                    //   color: AppColors.textSecondary,
                                    //   size: 32,
                                    // ),
                                  ).p(12);
                                },
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text('Loading'),
                          );
                        }
                      },
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Loading'),
                );
              }
            }),
      ),
    );
  }
}
