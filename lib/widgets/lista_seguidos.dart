// import 'package:flutter/material.dart';
// import '../models/usuario.dart';
// import '../services/api_service.dart';

// class ListaSeguido extends StatelessWidget {
//   final List<Usuario> users;
//   final String username;
//   final ApiService apiService = ApiService();

//   ListaSeguido({required this.users, required this.username});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(users[index].username),
//           trailing: IconButton(
//             icon: Icon(Icons.person_add),
//             onPressed: () async {
//               await apiService.followUser(username, users[index].id);
//               // Optionally: Refresh the list
//             },
//           ),
//         );
//       },
//     );
//   }
// }
