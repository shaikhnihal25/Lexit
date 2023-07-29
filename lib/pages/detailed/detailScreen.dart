import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/route_manager.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:lexit/pages/appointmentBookingPage.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailedScreen extends StatefulWidget {
  String? image;
  String? title;
  String? subtitle;
  String? price;
  String? description;
  double? rating;
  List<String>? services;
  String? address;
  DetailedScreen(
      {super.key,
      this.title,
      this.subtitle,
      this.price,
      this.description,
      this.image,
      this.rating,
      this.services,
      this.address});

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: context.screenHeight / 2.2,
                width: context.screenWidth,
                decoration: BoxDecoration(
                    color: AppColors.background,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.image ??
                            'https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image.png'))),
                child: Stack(
                  children: [
                    Container(
                      height: context.screenHeight / 18,
                      width: context.screenWidth,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.2),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              CupertinoIcons.back,
                              size: 36,
                              color: AppColors.primaryColor,
                            )).pOnly(left: 10),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              ListTile(
                title: Text(
                  widget.title ?? "",
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.subtitle ?? "",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                minLeadingWidth: 0.0,
                trailing: VxRating(
                  onRatingUpdate: (value) {},
                  value: widget.rating ?? 4.2,
                  maxRating: 5.0,
                  isSelectable: false,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Services:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ).pOnly(left: 15),
              const SizedBox(height: 4.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.services!
                    .map((service) => Text(
                          '- $service',
                          style: const TextStyle(fontSize: 16),
                        ))
                    .toList(),
              ).pOnly(left: 15),

              //-------Location-----------//
              const Text('Address',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                  .pOnly(left: 15, top: 30),
              Text(
                      widget.address ??
                          "Shop no. 06, Akash Nagar, MG Road, Chembur, Mumbai-400088.",
                      style: const TextStyle(fontSize: 16))
                  .pOnly(left: 15, top: 5),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NeumorphicButton(
          style: const NeumorphicStyle(
            color: AppColors.buttonPrimary,
            border: NeumorphicBorder.none(),
          ),
          onPressed: () {
            Get.to(AppointmentBookingScreen(
              lawyers: [
                widget.title ?? "",
              ],
              services: widget.services,
            ));
          },
          child: SizedBox(
            height: 50,
            width: context.screenWidth,
            child: const Center(
                child: Text(
              'Book Appointment',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
          )),
    );
  }
}
