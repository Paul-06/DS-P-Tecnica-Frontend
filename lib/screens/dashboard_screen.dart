// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import '../models/post.dart';
// import '../widgets/lista_post.dart';
// import '../widgets/lista_seguidos.dart';
// import 'agregar_post_screen.dart';

// class DashboardScreen extends StatelessWidget {
//   final int userId;
//   final String username;

//   DashboardScreen({required this.userId, required this.username});

//   final ApiService apiService = ApiService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard de $username'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder<List<Post>>(
//               future: apiService.getPostsSeguidos(username),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No hay posts disponibles.'));
//                 } else {
//                   return ListaPost(posts: snapshot.data!);
//                 }
//               },
//             ),
//           ),
//           ListaSeguido(userId: userId),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AgregarPostScreen(userId: userId),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
