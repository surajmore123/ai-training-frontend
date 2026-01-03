import 'dart:convert';
import 'package:http/http.dart' as http;

class ModuleRepository {
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<Map<String, dynamic>> fetchModule(String topic) async {
    final response = await http.get(
      Uri.parse("$baseUrl/module/$topic/"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load module");
    }
  }
}
