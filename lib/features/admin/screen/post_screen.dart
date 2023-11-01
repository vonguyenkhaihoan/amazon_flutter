import 'package:amazon_flutter/features/admin/screen/add_product_screen.dart';
import 'package:flutter/material.dart';

class PostScren extends StatefulWidget {
  const PostScren({super.key});

  @override
  State<PostScren> createState() => _PostScrenState();
}

class _PostScrenState extends State<PostScren> {
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddproductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Product'),
      ),

      //nut hanh dong noi
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: navigateToAddProduct,
        tooltip: 'Add a Product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
