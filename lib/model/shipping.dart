class Shipping {
  late int id;
  late String name;
  late String email;
  late String address;

  toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'email': email,
      'address': address
    };
  }
}
