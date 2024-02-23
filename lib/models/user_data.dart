class UserData {
  final String email;
  final String name;
  final String phone;
  final String userType;

  UserData({
    required this.email,
    required this.name,
    required this.phone,
    required this.userType,
  });

  factory UserData.fromJson(Map<String, dynamic> snapshot) {
    return UserData(
        email: snapshot['email'],
        name: snapshot['name'],
        phone: snapshot['phone'],
        userType: snapshot['userType']);
  }

}
