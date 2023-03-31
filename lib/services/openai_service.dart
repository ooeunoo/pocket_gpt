import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pocket_gpt/config/openai_model.dart';

class OpenAIService {
  static const String apiKey =
      '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';
  static const String apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> askToChatGPT(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: utf8.encode(json.encode({
          "model": getOepnAIModel(OpenAIModel.gpt3_5_turbo),
          "messages": [
            {"role": "user", "content": prompt}
          ]
        })),
      );
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        final choices = data['choices'];
        if (choices != null && choices.isNotEmpty) {
          return choices[0]['message']['content'].toString().trim();
        } else {
          return 'Error: No response from ChatGPT';
        }
      } else {
        return 'Error: Failed to connect to ChatGPT API';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
