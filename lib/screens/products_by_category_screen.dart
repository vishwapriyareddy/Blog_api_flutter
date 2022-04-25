// ignore: file_names
import 'dart:convert';

import 'package:blog_api/model/product.dart';
import 'package:blog_api/services/product_service.dart';
import 'package:blog_api/widgets/product_by_category.dart';
import 'package:flutter/material.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  ProductsByCategoryScreen(
      {Key? key, required this.categoryName, required this.categoryId})
      : super(key: key);

  @override
  _ProductsByCategoryScreenState createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  final ProductService _productService = ProductService();
  final List<Product> _productListByCategory = <Product>[];
  bool loading = true;
  _getProductsByCategory() async {
    var products =
        await _productService.getProductsByCategoryId(widget.categoryId);
    var _list = json.decode(products.body);
    _list['data'].forEach((data) {
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.productDetail = data['detail'];
      setState(() {
        loading = false;
        _productListByCategory.add(model);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: GridView.builder(
                  itemCount: _productListByCategory.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return ProductByCategory(
                      product: _productListByCategory[index],
                    );
                  }),
            ),
    );
  }
}
