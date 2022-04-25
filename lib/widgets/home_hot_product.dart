import 'package:blog_api/model/product.dart';
import 'package:blog_api/screens/product_detail.dart';
import 'package:flutter/material.dart';

class HomeHotProduct extends StatefulWidget {
  final Product product;
  HomeHotProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _HomeHotProductState createState() => _HomeHotProductState();
}

class _HomeHotProductState extends State<HomeHotProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.0,
      height: 260.0,
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
