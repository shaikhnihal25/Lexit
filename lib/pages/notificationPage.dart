import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<String> notifications = [
    'New message from John Doe',
    'Reminder: Meeting at 3:00 PM',
    'You have a new task assigned',
    // Add more notifications here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notifications),
            title: Text(notifications[index]),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Handle notification tap here (e.g., navigate to a specific screen or show the notification details)
            },
          );
        },
      ),
    );
  }
}
