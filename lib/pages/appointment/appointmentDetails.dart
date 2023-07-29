import 'package:flutter/material.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:velocity_x/velocity_x.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  String? lawyerName;
  String? service;
  String? date;
  String? time;
  AppointmentDetailsScreen(
      {super.key, this.lawyerName, this.service, this.date, this.time});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
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
          'Appointment Details',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scan this QR by lawyer to verify your appointment booking.',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary),
            ).pOnly(top: 30, left: 30, right: 60),
            Image.asset('assets/images/sampleQR.png').p(36),
            const VxDivider(
              color: AppColors.textPrimary,
              width: 3.0,
            ),
            const Text(
              'Appointment Details',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ).pOnly(left: 30, top: 30),
            Text(
              "Lawyer Name :  " + widget.lawyerName! ?? "",
              style: const TextStyle(fontSize: 20),
            ).pOnly(left: 30, top: 30),
            Text(
              "Service :   " + widget.service! ?? "",
              style: const TextStyle(fontSize: 20),
            ).pOnly(left: 30, top: 10),
            Text(
              "Appointment Date :    " + widget.date! ?? "",
              style: const TextStyle(fontSize: 20),
            ).pOnly(left: 30, top: 10),
            Text(
              "Appointment Time :    " + widget.time! ?? "",
              style: const TextStyle(fontSize: 20),
            ).pOnly(left: 30, top: 10),
          ],
        ),
      )),
    );
  }
}
