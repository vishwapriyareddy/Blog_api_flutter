import 'package:blog_api/model/product.dart';
import 'package:blog_api/screens/checkout_screen.dart';
import 'package:blog_api/screens/login_screen.dart';
import 'package:blog_api/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;
  CartScreen({Key? key, required this.cartItems}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late double _total;
  final CartService _cartService = CartService();
  @override
  void initState() {
    super.initState();
    _getTotal();
  }

  _getTotal() {
    _total = 0.0;
    widget.cartItems.forEach((item) {
      setState(() {
        _total += (item.price - item.discount) * item.quantity;
      });
    });
  }

  void _checkOut(List<Product> cartItems) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int? _userId = _prefs.getInt('userId');
    if (_userId != null && _userId > 0) {
      // navigate to checkout screen
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckoutScreen(cartItems: cartItems)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(cartItems: cartItems)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: Text('Items in Cart'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(widget.cartItems[index].photo),
              title: Text(widget.cartItems[index].name,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    '\$${widget.cartItems[index].price - widget.cartItems[index].discount}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' x ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${widget.cartItems[index].quantity}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' = ',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${(widget.cartItems[index].price - widget.cartItems[index].discount) * this.widget.cartItems[index].quantity}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              trailing: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _total += widget.cartItems[index].price -
                            widget.cartItems[index].discount;
                        widget.cartItems[index].quantity++;
                      });
                      _cartService
                          .increaseCartItemQuant(widget.cartItems[index]);
                    },
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 21,
                    ),
                  ),
                  Text('${widget.cartItems[index].quantity}',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (widget.cartItems[index].quantity > 1) {
                          _total -= widget.cartItems[index].price -
                              widget.cartItems[index].discount;
                          widget.cartItems[index].quantity--;
                        }
                      });
                      _cartService
                          .decreaseCartItemQuant(widget.cartItems[index]);
                    },
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 21,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Total : \$$_total',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
            ),
            Expanded(
              child: RaisedButton(
                color: Colors.redAccent,
                onPressed: () {
                  _checkOut(widget.cartItems);
                },
                child: Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
