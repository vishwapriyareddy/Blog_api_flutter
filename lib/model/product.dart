class Product {
  late int id;
  late String name;
  late String photo;
  late int price;
  late int discount;
  late String productDetail;
  late int quantity;

  toMap() {
    var map = Map<String, dynamic>();
    map['productId'] = id;
    map['productName'] = name;
    map['productPhoto'] = photo;
    map['productPrice'] = price;
    map['productDiscount'] = discount;
    map['productQuantity'] = quantity;
    return map;
  }
}
