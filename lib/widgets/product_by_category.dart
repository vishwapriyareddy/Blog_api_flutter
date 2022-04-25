import 'package:blog_api/model/product.dart';
import 'package:blog_api/screens/product_detail.dart';
import 'package:flutter/material.dart';

class ProductByCategory extends StatefulWidget {
  final Product product;
  ProductByCategory({Key? key, required this.product}) : super(key: key);

  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 190,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProductDetail(product: widget.product)));
        },
        child: Card(
          child: Column(
            children: <Widget>[
              Text(widget.product.name),
              Image.network(
                widget.product.photo,
                width: 190.0,
                height: 160.0,
              ),
              Row(
                children: [
                  Text('Price:${widget.product.price}'),
                  Text('Discount:${widget.product.discount}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
