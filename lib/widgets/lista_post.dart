import 'package:flutter/material.dart';
import '../models/post.dart';

class ListaPost extends StatelessWidget {
  final List<Post> posts;

  ListaPost({required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(posts[index].contenido),
          subtitle: Text('${posts[index].username} - ${posts[index].fechaPublicacion}'),
        );
      },
    );
  }
}
