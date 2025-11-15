class PetModel {
  String id;
  String name;
  String breed;
  int age;
  String? imageUrl;
  String? notes;

  PetModel({required this.id, required this.name, required this.breed, required this.age, this.imageUrl, this.notes});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'breed': breed,
    'age': age,
    'imageUrl': imageUrl,
    'notes': notes,
  };

  factory PetModel.fromMap(Map<String, dynamic> map) => PetModel(
    id: map['id'],
    name: map['name'],
    breed: map['breed'],
    age: map['age'],
    imageUrl: map['imageUrl'],
    notes: map['notes'],
  );
}
