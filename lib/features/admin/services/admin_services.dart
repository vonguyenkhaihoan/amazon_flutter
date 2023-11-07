import 'dart:convert';
import 'dart:io';

import 'package:amazon_flutter/config/config.dart';
import 'package:amazon_flutter/constains/error_handling.dart';
import 'package:amazon_flutter/constains/utils.dart';
import 'package:amazon_flutter/models/order_model.dart';
import 'package:amazon_flutter/models/product_model.dart';
import 'package:amazon_flutter/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  // hamf bans sanr phamr
  // void sellProduct({
  //   required BuildContext context,
  //   required String name,
  //   required String description,
  //   required double price,
  //   required double quantity,
  //   required String category,
  //   required List<File> images,
  // }) async {
  //   try {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //     //ket noi den cloudinary
  //     final cloudinary = CloudinaryPublic('dgcuvbmzi', 'xhvxotwr');

  //     // tao bien luu tru image url
  //     List<String> imageUrls = [];

  //     for (int i = 0; i < images.length; i++) {
  //       CloudinaryResponse res = await cloudinary.uploadFile(
  //         CloudinaryFile.fromFile(images[i].path, folder: name),
  //       );
  //       imageUrls.add((res.secureUrl));
  //     }

  //     //taoj doi tuong product vaf truyen du lieu vao
  //     Product product = Product(
  //       name: name,
  //       description: description,
  //       quantity: quantity,
  //       images: imageUrls,
  //       category: category,
  //       price: price,
  //     );

  //     http.Response res = await http.post(
  //       Uri.parse(addProduct),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //       body: product.toJson(),
  //     );

  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         showSnackBar(context, 'Product Add Successfullly!', Colors.green);
  //         Navigator.pop(context);
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString(), Colors.red);
  //     print(e);
  //   }
  // }
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
      final cloudinary = CloudinaryPublic('dgcuvbmzi', 'xhvxotwr');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: "product/" + name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse(addProduct),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pop(context);
          showSnackBar1(context, 'Product Added Successfully!');
        },
      );
    } catch (e) {
      showSnackBar(
          context, e.toString(), const Color.fromARGB(255, 161, 117, 113));
    }
  }

  //get all product
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    //tao bien luu danh sach san pham
    List<Product> productList = [];

    try {
      http.Response res = await http.get(Uri.parse(getAllProduct), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          //chay vong lap san pham lays tudb
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            //them vao danh sach san pham
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

  //delete Product
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse(deleteProducts),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(
          context, e.toString(), const Color.fromARGB(255, 161, 117, 113));
    }
  }

  //get all order
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    //tao bien luu danh sach san pham
    List<Order> orderList = [];

    try {
      http.Response res = await http.get(Uri.parse(getAllOrder), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          //chay vong lap san pham lays tudb
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            //them vao danh sach san pham
            orderList.add(
              Order.fromJson(
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
    return orderList;
  }

  //change status order
  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse(changeStatusOrder),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(
          context, e.toString(), const Color.fromARGB(255, 161, 117, 113));
    }
  }
}
