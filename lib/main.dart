import 'package:flutter/material.dart';
import '../services/api_service.dart';  // Asegúrate de que esta importación sea correcta.
import '../models/post.dart'; // Asegúrate de que esta importación sea correcta.
import '../models/usuario.dart'; // Asegúrate de que esta importación sea correcta.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  int _currentIndex = 0;

  final List<int> userIds = [1, 2, 3];
  final List<String> usernames = ['Alfonso', 'Ivan', 'Alicia'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social App'),
      ),
      body: _buildDashboard(userIds[_currentIndex], usernames[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Alfonso'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Ivan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Alicia'),
        ],
      ),
    );
  }

  Widget _buildDashboard(int userId, String username) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<Post>>(
                        future: apiService.getPostsSeguidos(username),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text('Sin posts encontrados'));
                          } else {
                            return ListView(
                              children: snapshot.data!
                                  .map((post) => ListTile(
                                        title: Text(post.contenido),
                                        subtitle: Text('${post.username} - ${post.fechaPublicacion}'),
                                      ))
                                  .toList(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(width: 1),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Timeline',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<Post>>(
                        future: apiService.getPostsDeUsuario(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text('Sin posts encontrados'));
                          } else {
                            return ListView(
                              children: snapshot.data!
                                  .map((post) => ListTile(
                                        title: Text(post.contenido),
                                        subtitle: Text('${post.username} lo posteaste el ${post.fechaPublicacion}'),
                                      ))
                                  .toList(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<List<Usuario>>(
          future: apiService.getNoSeguidos(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Sin usuarios encontrados'));
            } else {
              return Column(
                children: snapshot.data!
                    .map((usuario) => ListTile(
                          title: Text(usuario.username),
                          trailing: IconButton(
                            icon: Icon(Icons.person_add),
                            onPressed: () => apiService.seguirUsuario(userId, usuario.id),
                          ),
                        ))
                    .toList(),
              );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                apiService.agregarPost(userId, value).then((_) {
                  setState(() {});
                }).catchError((error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Error al crear post')));
                });
              }
            },
            decoration: InputDecoration(
              labelText: 'Crear un nuevo post',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
