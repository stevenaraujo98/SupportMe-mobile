import 'package:dio/dio.dart';
import 'package:supportme/models/hueca.dart';
import 'package:supportme/models/menu.dart';

class HuecaService {
  static Dio _dio = Dio(BaseOptions(
      baseUrl: "http://localhost:8000/api", contentType: "application/json"));

  static Future<Map<String, dynamic>> post(Hueca hueca, List<Menu> menu) async {
    try {
      final response = await _dio.post("/huecas", data: {
        "hueca": hueca.toJson(),
        "menues": menu.map((item) => item.toJson()).toList()
      });
      return response.data;
    } on DioError catch (ex) {
      print(ex.response.data);
      return null;
    }
  }

  static Future<List<Hueca>> getHuecas() async {
    try {
      final response = await _dio.get("/huecas");
      List<Hueca> res = List<Hueca>();
      for (var dat in response.data) {
        res.add(Hueca.fromJson(dat));
      }
      return res;
    } catch (_) {
      return null;
    }
  }

  static Future<List<Menu>> getMenuHuecas(int id) async {
    List<Menu> res = List<Menu>();
    try {
      final response = await _dio.get("/menu/hueca/${id.toString()}");
      if (response.data != "") {
        for (var dat in response.data) {
          res.add(Menu.fromJson(dat));
        }
        return res;
      }
      res.add(Menu.zero());
      return res;
    } on DioError catch (ex) {
      print(ex.response.data);
      res.add(Menu.zero());
      return res;
    }
  }
}
