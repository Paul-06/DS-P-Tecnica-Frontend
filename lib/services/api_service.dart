import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/models/post.dart';
import 'package:social_app/models/usuario.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5079/api';

  Future<List<Post>> getPostsSeguidos(String username) async {
    debugPrint('Fetching posts for username: $username');
    final response =
        await http.get(Uri.parse('$baseUrl/post/$username/posts/seguidos'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((post) => Post.fromJson(post)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('Sin posts de seguidos');
    } else {
      throw Exception('Error al cargar posts de seguidos');
    }
  }

  Future<List<Post>> getPostsDeUsuario(int usuarioId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/post/$usuarioId/posts'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((post) => Post.fromJson(post)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('Sin posts del usuario');
    } else {
      throw Exception('Error al cargar los posts del usuario');
    }
  }

  Future<List<Usuario>> getDemasUsuarios(String username) async {
    final response =
        await http.get(Uri.parse('$baseUrl/usuario/$username/usuarios'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((usuario) => Usuario.fromJson(usuario)).toList();
    } else if (response.statusCode == 400) {
      throw Exception('Sin usuarios');
    } else {
      throw Exception('Error al cargar usuarios');
    }
  }

  Future<void> seguirUsuario(int idSeguidor, int idSeguido) async {
    final response = await http
        .post(Uri.parse('$baseUrl/usuario/$idSeguidor/seguir/$idSeguido'));

    if (response.statusCode != 200) {
      throw Exception('Error al seguir usuario');
    }
  }

  Future<void> agregarPost(int idUsuario, String contenido) async {
    final response = await http.post(
      Uri.parse('$baseUrl/post'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"IdUsuario": idUsuario, "Contenido": contenido}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al crear post');
    }
  }
}
