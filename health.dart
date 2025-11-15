import 'package:flutter/material.dart';

class HealthTrackerScreen extends StatelessWidget {
  final String petId;

  const HealthTrackerScreen({Key? key, required this.petId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tracker'),
      ),
      body: Center(
        child: Text('Tracking health for pet: $petId'),
      ),
    );
  }
}
