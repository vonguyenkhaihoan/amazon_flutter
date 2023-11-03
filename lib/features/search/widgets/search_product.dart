import 'package:amazon_flutter/common/widgets/stars.dart';
import 'package:amazon_flutter/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchProduct extends StatelessWidget {
  final Product product;
  const SearchProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 0.5,
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // hien hinh anh
                Image.network(
                  product.images[0],
                  fit: BoxFit.cover,
                  height: 135,
                  width: 135,
                ),
                // Image.network(
                //   product.images[0],
                //   fit: BoxFit.fitHeight,
                //   height: 135,
                //   width: 135,
                // )
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Stars(
                        rating: 4,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '\$${product.price}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 16,
                          // color: Colors.redAccent,
                          // fontWeight: FontWeight.bold
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
