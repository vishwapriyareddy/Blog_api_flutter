import 'package:blog_api/model/category.dart';
import 'package:blog_api/model/product.dart';
import 'package:blog_api/widgets/home_hot_product.dart';
import 'package:blog_api/widgets/home_new_arrival_product.dart';
import 'package:blog_api/widgets/home_product_category.dart';
import 'package:flutter/material.dart';

class HomeNewArrivalProducts extends StatefulWidget {
  final List<Product> productList;
  HomeNewArrivalProducts({Key? key, required this.productList})
      : super(key: key);

  @override
  _HomeNewArrivalProductsState createState() => _HomeNewArrivalProductsState();
}

class _HomeNewArrivalProductsState extends State<HomeNewArrivalProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.productList.length,
        itemBuilder: (context, index) {
          return HomeNewArrivalProduct(
            product: widget.productList[index],
          );
        },
      ),
    );
  }
}
