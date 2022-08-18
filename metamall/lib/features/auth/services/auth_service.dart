import 'dart:convert';

import 'package:metamall/common/widgets/bottom_bar.dart';
import 'package:metamall/constants/error_handling.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/constants/utils.dart';
import 'package:metamall/features/admin/screens/admin_screen.dart';
import 'package:metamall/features/home/screens/home_screen.dart';
import 'package:metamall/models/user.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //signup user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: []);

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context,
                'Account created! Login with the same account credentials');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
      print(e.toString());
    }
  }

  //signin User
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      print(res.body);
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            User user = User.fromJson(res.body);
            await prefs.setString('x-auth-token', user.token);

            if (user.type == "user") {
              Navigator.pushNamedAndRemoveUntil(
                  context, BottomBar.routeName, (route) => false);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, AdminScreen.routeName, (route) => false);
            }
            showSnackbar(context, 'Signin Scuccessful');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
      print(e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/token IsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        //get userdata
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackbar(context, e.toString());
      print(e.toString());
    }
  }
}
