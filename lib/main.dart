import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_details_mvvm/view/screens/user_list_screen.dart';
import 'package:users_details_mvvm/viewModel/local/db_operations.dart';
import 'package:users_details_mvvm/viewModel/provider/user_provider.dart';

GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DBOperations().initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackBarKey,
      title: 'User Details App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: const UserListScreen(),
      ),
    );
  }
}
