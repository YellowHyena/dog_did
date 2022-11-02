class UserData {
  final String id;
  final String email;
  final String name;
  UserData({
    required this.id,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': email,
      };
  static UserData fromJson(Map<String, dynamic> json) => UserData(name: json['name'], email: json['email'], id: json['id']);
}
