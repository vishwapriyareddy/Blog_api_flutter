import 'package:blog_api/model/user.dart';
import 'package:blog_api/repository/repository.dart';

class UserService {
  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

  createUser(User user) async {
    return await _repository.httpPost('register', user.toJson());
  }

  login(User user) async {
    return await _repository.httpPost('login', user.toJson());
  }
}
