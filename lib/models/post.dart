class Post {
  final String contenido;
  final String username;
  final DateTime fechaPublicacion;

  Post({
    required this.contenido,
    required this.username,
    required this.fechaPublicacion,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      contenido: json['contenido'],
      username: json['username'],
      fechaPublicacion: DateTime.parse(json['fechaPublicacion']),
    );
  }
}
