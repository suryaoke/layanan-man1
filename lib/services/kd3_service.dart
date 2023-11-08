import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:layanan/models/kd3_model.dart';
import 'package:layanan/services/auth_service.dart';
import 'package:layanan/shared/shared_values.dart';

class Kd3Service {
  Future<List<Kd3Model>> getKd3s() async {
    try {
      final token = await AuthService().getToken();

      var response = await http.get(
        Uri.parse('$baseUrl/kd3'),
        headers: {
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> kd3Data = jsonDecode(response.body)['kd3'];
        List<Kd3Model> kd3List =
            kd3Data.map((item) => Kd3Model.fromJson(item)).toList();
        return kd3List;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
