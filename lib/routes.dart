import 'package:flutter/material.dart';
import 'screens/add_product_screen.dart';
import 'screens/product_list_screen.dart';

// class AppRoutes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (_) => const ProductListScreen());
//       case '/add-product':
//         return MaterialPageRoute(builder: (_) => const AddProductScreen());
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${settings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }

// If you want named routes, create this file
class AppRoutes {
  static const String home = '/';
  static const String addProduct = '/add-product';
}