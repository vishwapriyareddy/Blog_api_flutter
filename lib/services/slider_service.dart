import 'package:blog_api/repository/repository.dart';


class SliderService {
  
   late Repository _repository;
  SliderService(){
    _repository = Repository();
  }

  getSliders() async {
    return await _repository.httpGet('slider');
  }
}