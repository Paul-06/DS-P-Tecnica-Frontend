import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../utils/api_endpoints.dart';

class PostService {
  Future<List<Post>> getPosts(String username) async {
    final response = await http.get(Uri.parse('${ApiEndpoints.baseUrl}/post/$username/posts'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((post) => Post.fromJson(post)).toList();
    } else {
      // Manejamos errores y excepciones
      String errorMessage = 'Error al cargar posts';
      if (response.statusCode == 404) {
        errorMessage = response.body;
      } else if (response.statusCode == 400) {
        errorMessage = response.body;
      }
      throw Exception(errorMessage);
    }
  }
}
