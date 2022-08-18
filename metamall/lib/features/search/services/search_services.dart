import 'dart:convert';

import 'package:metamall/constants/error_handling.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/constants/utils.dart';
import 'package:metamall/models/product.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> fetchSearchedProducts(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            for (var data in jsonDecode(res.body)) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    data,
                  ),
                ),
              );
            }
          });
    } catch (e) {
      // print(e.toString());
      showSnackbar(context, e.toString());
    }
    return productList;
  }
}
