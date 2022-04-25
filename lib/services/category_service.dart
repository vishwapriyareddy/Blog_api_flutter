import 'package:blog_api/repository/repository.dart';


class CategoryService {
  
   late Repository _repository;
  CategoryService(){
    _repository = Repository();
  }

  getCatgories() async {
    return await _repository.httpGet('categories');
  }
}