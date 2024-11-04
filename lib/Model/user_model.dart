class UserModel {
  final String username;
  final String email;
  final String password;
  final String id;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.id,
  });

  // Factory constructor to create a UserModel object from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      email: map['email'],
      password: map['password'],
      id: map['id'],
    );
  }

  // Method to convert the UserModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'id': id,
    };
  }
}
