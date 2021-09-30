import 'dart:async';
import 'dart:convert';
import 'package:cs_test/api/api_utils.dart';
import 'package:cs_test/providers/providers.dart' show AuthAPIProvider;
import 'dart:convert' show json;

class AuthAPI {
  final AuthAPIProvider _apiProvider;
  
  AuthAPI(this._apiProvider);

  Future<APIResponse<String>> authLogin({ String email, String password }) async {
    var response;
    try {
      response = await _apiProvider.loginPost(email, password);
    } catch (exception) {
      if (exception is TimeoutException) return APIResponse<String>(isOk: false, result: null, status: 408, message: 'Request timeout');
      else return APIResponse<String>(isOk: false, result: null, status: 500, message: exception.toString());
    }
    
    if (response.statusCode != 200) {
      return APIResponse<String>(isOk: false, message: response.body, result: null, status: response.statusCode);
    }

    String token;
    try {
      dynamic responseBody = json.decode(response.body);
      if (responseBody != null && responseBody['token'] != null) {
        token = responseBody['token'];
      } else {
        throw Exception('Unexpected response body: ${response.body}');
      }
    } catch (exception) {
      print(exception);
      return APIResponse<String>(isOk: false, message: exception.toString(), result: null, status: response.statusCode);
    }
    
    return APIResponse<String>(isOk: true, message: 'OK', result: token, status: response.statusCode);
  }
}