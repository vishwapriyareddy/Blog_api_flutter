class User {
  late int id;
  late String name;
  late String email;
  late String password;

  toJson() {
    return {
      'id': id.toString,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
