import 'dart:convert';
import 'dart:io';

import 'package:metamall/constants/error_handling.dart';
import 'package:metamall/constants/global_variables.dart';
import 'package:metamall/constants/utils.dart';
import 'package:metamall/features/admin/models/sales.dart';
import 'package:metamall/models/order.dart';
import 'package:metamall/models/product.dart';
import 'package:metamall/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dvypwlby2', 'oij7k8w0');
      List<String> imgUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imgUrls.add(res.secureUrl);

        Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imgUrls,
          category: category,
          price: price,
        );
        http.Response response = await http.post(
          Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: product.toJson(),
        );
        httpErrorHandler(
            response: response,
            context: context,
            onSuccess: () {
              showSnackbar(context, 'Product Added Successfully');
              Navigator.pop(context);
            });
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  //get all products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-product'),
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

//delete product
  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id': product.id,
          },
        ),
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-orders'),
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
              orderList.add(
                Order.fromJson(
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
    return orderList;
  }

  void changeOrderStatus(
      {required BuildContext context,
      required int status,
      required Order order,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id': order.id,
            'status': status,
          },
        ),
      );
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
