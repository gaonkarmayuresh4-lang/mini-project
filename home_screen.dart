import 'package:flutter/material.dart';
import 'auth/login_screen.dart';
import 'add_pet_screen.dart';
import 'health_tracker_screen.dart';
import 'reminder_screen.dart';
import 'api_info_screen.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../models/pet_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authService = AuthService();
  final dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Pets"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          )
        ],
      ),
      body: StreamBuilder<List<PetModel>>(
        stream: dbService.getPets(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final pets = snapshot.data!;
          return ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              final pet = pets[index];
              return ListTile(
                title: Text(pet.name),
                subtitle: Text(pet.breed),
                leading: pet.imageUrl != null ? Image.network(pet.imageUrl!, width: 50, height: 50) : null,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HealthTrackerScreen(petId: pet.id)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "addPet",
            child: const Icon(Icons.pets),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddPetScreen())),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "reminder",
            child: const Icon(Icons.notifications),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReminderScreen())),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "tips",
            child: const Icon(Icons.info),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ApiInfoScreen())),
          ),
        ],
      ),
    );
  }
}
