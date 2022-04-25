import 'dart:convert';

import 'package:blog_api/model/category.dart';
import 'package:blog_api/model/product.dart';
import 'package:blog_api/providers/cart_provider.dart';
import 'package:blog_api/screens/cart_screen.dart';
import 'package:blog_api/services/cart_service.dart';
import 'package:blog_api/services/category_service.dart';
import 'package:blog_api/services/product_service.dart';
import 'package:blog_api/services/slider_service.dart';
import 'package:blog_api/widgets/carousel_slider.dart';
import 'package:blog_api/widgets/home_hot_products.dart';
import 'package:blog_api/widgets/home_new_arrival_products.dart';
import 'package:blog_api/widgets/home_product_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SliderService _sliderService = SliderService();
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();
  final List<Category> _categoryList = <Category>[];
  final List<Product> _productList = <Product>[];
  final CartService _cartService = CartService();
  late List<Product> _cartItems;
  List<Widget> items = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    _getAllSliders();
    _gtAllCategories();
    _getAllHotProducts();
    _getAllNewArrivalProducts();
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

  _getAllSliders() async {
    var sliders = await _sliderService.getSliders();
    var result = json.decode(sliders.body);
    result['data'].forEach((data) {
      setState(() {
        loading = false;
        items.add(Image.network(data['image_url']));
      });
    });
    print(result);
  }

  _gtAllCategories() async {
    var categories = await _categoryService.getCatgories();
    var result = json.decode(categories.body);
    result['data'].forEach((data) {
      var model = Category();
      model.id = data['id'];
      model.name = data['categoryName'];
      model.icon = data['categoryIcon'] ?? "";
      setState(() {
        loading = false;
        _categoryList.add(model);
      });
    });
  }

  _getAllHotProducts() async {
    var hotProducts = await _productService.getHotProduct();
    var result = json.decode(hotProducts.body);
    result['data'].forEach((data) {
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.productDetail = data['detail'];
      setState(() {
        loading = false;
        _productList.add(model);
      });
    });
  }

  _getAllNewArrivalProducts() async {
    var hotProducts = await _productService.getNewArrivalProduct();
    var result = json.decode(hotProducts.body);
    result['data'].forEach((data) {
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.productDetail = data['detail'];
      setState(() {
        loading = false;
        _productList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.cartItems();
    return Scaffold(
      appBar: AppBar(
        title: const Text('eComm App'),
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
      body: loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: ListView(
              children: <Widget>[
                carouselSlider(items),
                const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Product Categories")),
                HomeProductCategories(categoryList: _categoryList),
                const Padding(
                    padding: EdgeInsets.all(10.0), child: Text("Hot Products")),
                HomeHotProducts(productList: _productList),
                const Padding(
                    padding: EdgeInsets.all(10.0), child: Text("New Arrivals")),
                HomeNewArrivalProducts(productList: _productList)
              ],
            )),
    );
  }
}
