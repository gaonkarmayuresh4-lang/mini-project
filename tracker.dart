import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/health_record_model.dart';
import '../services/health_service.dart';

class HealthTrackerScreen extends StatefulWidget {
  final String petId;
  const HealthTrackerScreen({super.key, required this.petId});

  @override
  State<HealthTrackerScreen> createState() => _HealthTrackerScreenState();
}

class _HealthTrackerScreenState extends State<HealthTrackerScreen> {
  final descCtrl = TextEditingController();
  final healthService = HealthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Health Records")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(child: TextField(controller: descCtrl, decoration: const InputDecoration(labelText: "Record"))),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    final record = HealthRecord(
                      id: const Uuid().v4(),
                      petId: widget.petId,
                      description: descCtrl.text,
                      date: DateTime.now(),
                    );
                    await healthService.addHealthRecord(record);
                    descCtrl.clear();
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<HealthRecord>>(
              stream: healthService.getPetHealthRecords(widget.petId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final records = snapshot.data!;
                return ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final rec = records[index];
                    return ListTile(
                      title: Text(rec.description),
                      subtitle: Text(rec.date.toLocal().toString()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
