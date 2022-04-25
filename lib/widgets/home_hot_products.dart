import 'package:blog_api/model/category.dart';
import 'package:blog_api/model/product.dart';
import 'package:blog_api/widgets/home_hot_product.dart';
import 'package:blog_api/widgets/home_product_category.dart';
import 'package:flutter/material.dart';

class HomeHotProducts extends StatefulWidget {
  final List<Product> productList;
  HomeHotProducts({Key? key, required this.productList}) : super(key: key);

  @override
  _HomeHotProductsState createState() => _HomeHotProductsState();
}

class _HomeHotProductsState extends State<HomeHotProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.productList.length,
        itemBuilder: (context, index) {
          return HomeHotProduct(
            product: widget.productList[index],
          );
        },
      ),
    );
  }
}
