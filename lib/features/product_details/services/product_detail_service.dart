import 'dart:convert';

import 'package:amazon_flutter/config/config.dart';
import 'package:amazon_flutter/constains/error_handling.dart';
import 'package:amazon_flutter/constains/utils.dart';
import 'package:amazon_flutter/models/product_model.dart';
import 'package:amazon_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailServices {
  //ham xep hang san pham
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse(apirateProducts),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pop(context);
          showSnackBar(context, 'Product review success!',Colors.green[400]!);
        },
      );
    } catch (e) {
      showSnackBar(
          context, e.toString(), const Color.fromARGB(255, 161, 117, 113));
    }
  }
}
