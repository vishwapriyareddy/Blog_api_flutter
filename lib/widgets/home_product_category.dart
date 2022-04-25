import 'package:blog_api/screens/Products_By_Category_Screen.dart';
import 'package:flutter/material.dart';
class HomeProductCategory extends StatefulWidget {
final int categoryId;
final String categoryIcon;
final String categoryName;
  
   HomeProductCategory({Key? key, required this.categoryIcon, required this.categoryName, required this.categoryId}) : super(key: 
  key);

  @override
  _HomeProductCategoryState createState() => _HomeProductCategoryState();
}

class _HomeProductCategoryState extends State<HomeProductCategory> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 140.0,
      height: 190.0,
      child:  InkWell(
        onTap: (){
          Navigator.pop(context,MaterialPageRoute(builder: (context) => ProductsByCategoryScreen(categoryName:widget.categoryName, categoryId:widget.categoryId)));
        } ,
        child: Card(
      child: Column(
      children: <Widget>[
      Image.network(widget.categoryIcon,width: 190.0,height: 160.0,),
      Padding(padding: const EdgeInsets.all(8.0),
      child: Text(widget.categoryName),
      
      
      )
      ],  
      ),
        ),
      ),
    );
  }
}