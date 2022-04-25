import 'package:blog_api/model/category.dart';
import 'package:blog_api/widgets/home_product_category.dart';
import 'package:flutter/material.dart';

class HomeProductCategories extends StatefulWidget {
  final List<Category> categoryList;
  HomeProductCategories({Key? key, required this.categoryList}) : super(key: key);

  @override
  _HomeProductCategoriesState createState() => _HomeProductCategoriesState();
}

class _HomeProductCategoriesState extends State<HomeProductCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 205,child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.categoryList.length,
      itemBuilder: (context,index){
       return HomeProductCategory(categoryIcon: widget.categoryList[index].icon, categoryId: widget.categoryList[index].id, categoryName: widget.categoryList[index].name,);
      },
    ),);
  }
}