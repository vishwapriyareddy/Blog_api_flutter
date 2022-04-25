import 'package:blog_api/model/product.dart';
import 'package:blog_api/screens/product_detail.dart';
import 'package:flutter/material.dart';

class HomeNewArrivalProduct extends StatefulWidget {
  final Product product;
  HomeNewArrivalProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _HomeNewArrivalProductState createState() => _HomeNewArrivalProductState();
}

class _HomeNewArrivalProductState extends State<HomeNewArrivalProduct> {
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
