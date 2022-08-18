import 'package:metamall/common/widgets/bottom_bar.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/features/admin/screens/admin_screen.dart';
import 'package:metamall/features/auth/screens/auth_screen.dart';
import 'package:metamall/features/auth/screens/signUp_screen.dart';
import 'package:metamall/features/auth/services/auth_service.dart';
import 'package:metamall/features/home/screens/home_screen.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:metamall/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Keys.messangerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ClashDisplay',
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(elevation: 0),
        iconTheme: IconThemeData(color: Colors.black),
        colorScheme: ColorScheme.dark(),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const AdminScreen()
          : const SignUpScreen(),
    );
  }
}
