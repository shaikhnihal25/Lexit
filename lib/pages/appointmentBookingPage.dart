import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/route_manager.dart';
import 'package:lexit/backend/authServices.dart';
import 'package:lexit/backend/databaseServices.dart';
import 'package:lexit/backend/notification/notificationServices.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:lexit/pages/appointment/appointmentDetails.dart';
import 'package:lexit/pages/appointment/appointmentHistory.dart';

class AppointmentBookingScreen extends StatefulWidget {
  List<String>? services;
  List<String>? lawyers;
  AppointmentBookingScreen({super.key, this.lawyers, this.services});

  @override
  _AppointmentBookingScreenState createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  String selectedService = "Legal Consultation";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedLawyer = "John Doe";
  bool isBooked = false;

  final List<String> services = [
    "Legal Consultation",
    "Contract Review",
    "Litigation",
    "Other"
  ];
  final List<String> lawyers = [
    "John Doe",
    "Jane Smith",
    "Michael Johnson",
    "Emily Williams"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0.0,
        backgroundColor: AppColors.background,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
        title: const Text(
          'Book Appointment',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField<String>(
              focusColor: AppColors.primaryColor,
              iconEnabledColor: AppColors.primaryColor,
              value: widget.services![0],
              onChanged: (newValue) {
                setState(() {
                  selectedService = newValue!;
                });
              },
              items: widget.services!.map((service) {
                return DropdownMenuItem<String>(
                  value: service,
                  child: Text(service),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Select Service'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.buttonSecondary)),
              onPressed: () => _selectDate(context),
              child: Text(
                  'Select Date: ${selectedDate.toLocal().toString().split(' ')[0]}'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.buttonSecondary)),
              onPressed: () => _selectTime(context),
              child: Text('Select Time: ${selectedTime.format(context)}'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: widget.lawyers![0],
              onChanged: (newValue) {
                setState(() {
                  selectedLawyer = newValue!;
                });
              },
              items: widget.lawyers!.map((lawyer) {
                return DropdownMenuItem<String>(
                  value: lawyer,
                  child: Text(lawyer),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Select Lawyer'),
            ),
            const SizedBox(height: 32.0),
            NeumorphicButton(
              onPressed: () {
                setState(() {
                  isBooked = !isBooked;
                });

                if (isBooked) {
                  LexitDatabase().bookAppoints(
                      'lawyerId',
                      selectedLawyer,
                      selectedService,
                      '${selectedDate.toLocal().toString().split(' ')[0]}',
                      '${selectedTime.format(context)}');

                  Get.to(() => AppointmentDetailsScreen(
                        lawyerName: selectedLawyer,
                        service: selectedService,
                        time: selectedTime.format(context),
                        date: selectedDate.toLocal().toString().split(' ')[0],
                      ));
                }
                // Implement the logic to book the appointment here
              },
              style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                depth: 8,
                intensity: 0.7,
                lightSource: LightSource.topLeft,
                color: isBooked
                    ? AppColors.successColor
                    : AppColors
                        .buttonPrimary, // Change this to your desired button color
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Center(
                  child: Text(
                    isBooked ? "Done" : 'Book Appointment',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
