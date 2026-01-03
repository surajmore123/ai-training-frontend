import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadRepository {
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<String> uploadText({
    required String title,
    required String content,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/transcripts/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "content": content,
      }),
    );

    if (response.statusCode == 201) {
      return "Text uploaded successfully";
    } else {
      throw Exception("Failed to upload text");
    }
  }
}
