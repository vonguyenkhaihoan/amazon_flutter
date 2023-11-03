import 'dart:convert';

import 'package:amazon_flutter/config/config.dart';
import 'package:amazon_flutter/constains/error_handling.dart';
import 'package:amazon_flutter/constains/utils.dart';
import 'package:amazon_flutter/models/product_model.dart';
import 'package:amazon_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  // Future<List<Product>> fetchCategoryProducts({
  //   required BuildContext context,
  //   required String category,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);

  //   //tao bien luu danh sach san pham
  //   List<Product> productList = [];

  //   try {
  //     http.Response res = await http.get(
  //       Uri.parse("$url/api/products?catergory=$category"),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //     );

  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         //chay vong lap san pham lays tudb
  //         for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //           //them vao danh sach san pham
  //           productList.add(
  //             Product.fromJson(
  //               jsonEncode(
  //                 jsonDecode(res.body)[i],
  //               ),
  //             ),
  //           );
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString(), Colors.red);
  //   }
  //   return productList;
  // }

  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse(apiProducts + '?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
    return productList;
  }
}
