import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lexit/pages/detailed/detailScreen.dart';
import 'package:lexit/widgets/statusChip.dart';

class LawyerCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final List<String> services;
  final bool isAvailable;

  LawyerCard({
    required this.image,
    required this.name,
    required this.price,
    required this.services,
    this.isAvailable = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
            DetailedScreen(
              image: image,
              title: name,
              services: services,
              price: price,
              rating: 3.2,
              subtitle: 'This is subtitle ',
            ),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 400));
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.network(
                  image,
                  height: 220.0,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Consultation Fee: ₹$price',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Services:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: services
                          .map((service) => Text('- $service'))
                          .toList(),
                    ),
                    const SizedBox(height: 8.0),
                    AvailabilityChip(isAvailable: isAvailable),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
