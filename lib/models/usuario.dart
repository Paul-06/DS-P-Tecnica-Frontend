class Usuario {
  final int id;
  final String username;

  Usuario({required this.id, required this.username});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      username: json['username'],
    );
  }
}
