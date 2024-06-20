import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AgregarPostScreen extends StatefulWidget {
  final int userId;

  AgregarPostScreen({required this.userId});

  @override
  _AgregarPostScreenState createState() => _AgregarPostScreenState();
}

class _AgregarPostScreenState extends State<AgregarPostScreen> {
  final TextEditingController _controller = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Contenido'),
              maxLines: 5,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_controller.text.isNotEmpty) {
                  await apiService.agregarPost(widget.userId, _controller.text);
                  Navigator.pop(context); // Vuelve al dashboard después de agregar el post
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('El contenido no puede estar vacío')),
                  );
                }
              },
              child: Text('Agregar Post'),
            ),
          ],
        ),
      ),
    );
  }
}
