import 'dart:convert';

import 'package:metamall/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackbar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackbar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackbar(context, response.body);
  }
}
