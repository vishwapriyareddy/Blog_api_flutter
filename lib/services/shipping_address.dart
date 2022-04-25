import 'package:blog_api/model/shipping.dart';
import 'package:blog_api/repository/repository.dart';

class ShippingService {
  late Repository _repository;

  ShippingService() {
    _repository = Repository();
  }

  addShipping(Shipping shipping) async {
    return await _repository.httpPost('shipping', shipping.toJson());
  }
}
