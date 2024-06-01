class Compte {
  String email;
  String password;

  Compte({
    required this.email,
    required this.password,
  });

  factory Compte.fromJson(Map<String, dynamic> json) {
    return Compte(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
