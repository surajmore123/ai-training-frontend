import 'package:http/http.dart' as http;

class ProcessAIRepository {
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<String> processAI() async {
    final response = await http.post(
      Uri.parse("$baseUrl/process-ai/"),
    );

    if (response.statusCode == 200) {
      return "AI processing completed";
    } else {
      throw Exception("AI processing failed");
    }
  }
}
