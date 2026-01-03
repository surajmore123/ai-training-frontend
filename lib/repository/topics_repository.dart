import 'dart:convert';
import 'package:http/http.dart' as http;

class TopicsRepository {
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<List<dynamic>> fetchTopics() async {
    final response = await http.get(
      Uri.parse("$baseUrl/topics/"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch topics");
    }
  }
}
