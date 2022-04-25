import 'package:blog_api/repository/repository.dart';


class ProductService {
  
   late Repository _repository;


  ProductService(){
    _repository = Repository();
  }

  getHotProduct() async {
    return await _repository.httpGet('get-all-hot-products');
  }
   getNewArrivalProduct() async {
    return await _repository.httpGet('get-all-new-arrival-products');
  }
   getProductsByCategoryId(categoryId) async {
    return await _repository.httpGetById('get-products-by-category',categoryId);
  }
}