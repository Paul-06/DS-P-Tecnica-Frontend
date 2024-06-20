import 'package:flutter/material.dart';
import '../models/post.dart';

class PostItem extends StatelessWidget {
  final Post post;

  PostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.contenido),
      subtitle: Text('@${post.username} - ${post.fechaPublicacion}'),
    );
  }
}
