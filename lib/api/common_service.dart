
import 'package:dio/dio.dart';
import '../net/dio_manager.dart';
import 'Api.dart';


class CommonService{
  void getBanner(Function callback) async {
    DioManager.singleton.dio.get(Api.HOME_CATEGORIES).then((response) {
      callback(response.data);
    });
  }



}