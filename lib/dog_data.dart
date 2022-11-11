class DogData {
  final String id;
  final String description;
  final String breed;
  final bool isFemale;
  final String name;
  final int age;
  final String imageURL;
  final String docPath;
  DogData({
    required this.id,
    required this.name,
    required this.age,
    required this.breed,
    required this.description,
    required this.isFemale,
    required this.imageURL,
    required this.docPath,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'breed': breed,
        'description': description,
        'isFemale': isFemale,
        'docPath': docPath,
      };
  static DogData fromJson(Map<String, dynamic> json) => DogData(name: json['name'], age: json['age'], id: json['id'], breed: json['breed'], description: json['description'], isFemale: json['isFemale'], imageURL: json['imageURL'], docPath: json['docPath']);
}
