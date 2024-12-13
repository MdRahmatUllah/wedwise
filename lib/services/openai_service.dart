import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  static const String _baseUrl = 'https://api.openai.com/v1/chat/completions';

  Future<List<DateTime>> getWeddingDateSuggestions(
      DateTime preferredDate) async {
    print(
        'Getting wedding date suggestions for preferred date: $preferredDate');

    final apiKey = dotenv.env['OPENAI_API_KEY'];
    print('API Key available: ${apiKey != null}');

    if (apiKey == null) {
      throw Exception('OpenAI API key not found in environment variables');
    }

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a wedding planning assistant that suggests auspicious wedding dates.',
            },
            {
              'role': 'user',
              'content':
                  '''Given the preferred date ${preferredDate.toString()}, suggest 3 auspicious wedding dates within 3 months of this date. 
                          Consider factors like weekends, lunar calendar, and cultural significance. 
                          Return only the dates in YYYY-MM-DD format, separated by commas.'''
            }
          ],
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'] as String;

        // Parse the dates from the response
        final dateStrings = content.split(',').map((s) => s.trim()).toList();
        return dateStrings.map((dateStr) => DateTime.parse(dateStr)).toList();
      } else {
        throw Exception(
            'Failed to get date suggestions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting wedding date suggestions: $e');
      return [];
    }
  }
}
