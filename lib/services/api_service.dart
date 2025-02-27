
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService{
  static final String _mainPath = 'https://pos-app-api-f7dmhmbzdnhngjas.uaenorth-01.azurewebsites.net/api/';

  static Future<dynamic> makeRequest(String path, Map<String,dynamic> body) async{

    final url = Uri.parse('$_mainPath$path');
    final headers = {'Content-Type':'application/json', };
    try{
      final response = await http.post(url, body: json.encode(body), headers: headers)
      .timeout(
        const Duration(seconds: 4000), 
        onTimeout: () {
          throw TimeoutException('Request timed out');
        }
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Successful response
        if (response.headers['content-type'] != null && 
          response.headers['content-type']!.contains('application/json')) 
        {
            return json.decode(response.body);
        } 
        else {
          print('Error: ${response.headers['content-type']}');
          throw Exception('Response content type is not JSON: ${response.headers['content-type']}'); // Or handle other content types
        }
      }
      else {
        // Handle error
        print('Error: ${response.statusCode}:${response.body}');
        throw Exception('API request failed: ${response.statusCode}');
    }
    }
    catch(e){
      rethrow;
    }    
  }
}