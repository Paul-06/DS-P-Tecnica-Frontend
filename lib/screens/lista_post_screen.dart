import 'package:flutter/material.dart';
import '../services/post_service.dart';
import '../widgets/post_item.dart';
import '../models/post.dart';

class ListaPostScreen extends StatefulWidget {
  final String username;

  ListaPostScreen({required this.username});

  @override
  _ListaPostScreenState createState() => _ListaPostScreenState();
}

class _ListaPostScreenState extends State<ListaPostScreen> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  void _fetchPosts() {
    setState(() {
      futurePosts = PostService().getPosts(widget.username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Sin posts encontrados'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return PostItem(post: post);
              },
            );
          }
        },
      ),
    );
  }
}
