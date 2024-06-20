import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/models/post.dart';
import 'package:social_app/models/usuario.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5079/api';

  Future<List<Post>> getPostsSeguidos(String username) async {
    debugPrint('Fetching posts for username: $username');
    final response = await http.get(Uri.parse('$baseUrl/post/$username/posts/seguidos'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Post>> getPostsDeUsuario(int usuarioId) async {
    final response = await http.get(Uri.parse('$baseUrl/post/$usuarioId/posts'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Usuario>> getNoSeguidos(int id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/usuario/$id/noseguidos'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((usuario) => Usuario.fromJson(usuario)).toList();
    } else {
      throw Exception('Failed to load no seguidos');
    }
  }

  Future<void> seguirUsuario(int idSeguidor, int idSeguido) async {
    final response = await http
        .post(Uri.parse('$baseUrl/usuario/$idSeguidor/seguir/$idSeguido'));

    if (response.statusCode != 200) {
      throw Exception('Failed to follow user');
    }
  }

  Future<void> agregarPost(int idUsuario, String contenido) async {
    final response = await http.post(
      Uri.parse('$baseUrl/post'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"IdUsuario": idUsuario, "Contenido": contenido}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add post');
    }
  }
}
