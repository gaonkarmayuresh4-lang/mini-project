import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final titleCtrl = TextEditingController();
  DateTime selectedTime = DateTime.now().add(const Duration(seconds: 5));
  final notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Reminder")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: "Reminder Title")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await notificationService.scheduleNotification(
                  0,
                  "Pet Reminder",
                  titleCtrl.text,
                  selectedTime,
                );
              },
              child: const Text("Schedule Notification"),
            ),
          ],
        ),
      ),
    );
  }
}
