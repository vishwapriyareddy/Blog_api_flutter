import 'package:blog_api/model/product.dart';
import 'package:blog_api/providers/cart_provider.dart';
import 'package:blog_api/screens/cart_screen.dart';
import 'package:blog_api/screens/home.dart';
import 'package:blog_api/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();
  late List<Product> _cartItems;

  @override
  void initState() {
    super.initState();
    _getCartItems();
  }

  _getCartItems() async {
    _cartItems = <Product>[];
    var cartItems = await _cartService.getCartItems();
    cartItems.forEach((data) {
      var product = Product();
      product.id = data['productId'];
      product.name = data['productName'];
      product.photo = data['productPhoto'];
      product.price = data['productPrice'];
      product.discount = data['productDiscount'];
      product.productDetail = data['productDetail'] ?? 'No detail';
      product.quantity = data['productQuantity'];

      setState(() {
        _cartItems.add(product);
      });
    });
  }

  _addToCart(BuildContext context, Product product) async {
    var result = await _cartService.addToCart(product);
    if (result > 0) {
      _showSnackMessage(Text(
        'Item added to cart successfully!',
        style: TextStyle(color: Colors.green),
      ));
    } else {
      _showSnackMessage(Text(
        'Failed to add to cart!',
        style: TextStyle(color: Colors.red),
      ));
    }
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.cartItems();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => HomeScreen()));
        //     },
        //     icon: Icon(Icons.arrow_back_ios)),        title: Text(widget.product.name),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(
                            cartItems: _cartItems,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                width: 30,
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Positioned(
                      child: Stack(
                        children: <Widget>[
                          Icon(Icons.brightness_1,
                              size: 25, color: Colors.black),
                          Positioned(
                            top: 4.0,
                            right: 8.0,
                            child: Center(
                                child: Text(
                                    cartProvider.getCartQuantity.toString())),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                padding: EdgeInsets.only(bottom: 80.0),
                height: 190,
                width: 120,
                child: Image.network(widget.product.photo),
              ),
              footer: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  child: ListTile(
                    leading: Text(
                      widget.product.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    title: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          '${widget.product.price - widget.product.discount}',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                            child: Text(
                          '${widget.product.price}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                onPressed: () async {
                  var result = await cartProvider.addToCart(widget.product);
                  if (result > 0) {
                    _showSnackMessage(Text(
                      'Item added to cart successfully!',
                      style: TextStyle(color: Colors.green),
                    ));
                  } else {
                    _showSnackMessage(Text(
                      'Failed to add to cart!',
                      style: TextStyle(color: Colors.red),
                    ));
                  }
                  //   _addToCart(context, widget.product);
                },
                textColor: Colors.redAccent,
                child: Row(
                  children: [
                    Text('Add to Cart'),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.shopping_cart))
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_border)),
            ],
          ),
          const Divider(),
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ListTile(
                title: Text(
                  "Product detail",
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(widget.product.productDetail),
              ),
            )
          ])
        ],
      ),
    );
  }
}
