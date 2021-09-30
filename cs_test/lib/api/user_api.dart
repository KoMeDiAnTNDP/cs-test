import 'dart:async';
import 'dart:convert';
import 'package:cs_test/api/api_utils.dart';
import 'package:cs_test/models/models.dart' show User;
import 'package:cs_test/providers/providers.dart' show UserAPIProvider;

class UserAPI {
  final UserAPIProvider _apiProvider;
  UserAPI(this._apiProvider);

  Future<APIResponse<User>> getUserByToken(String token) async {

  // var encodedToken = base64.encode(utf8.encode(token));
    var response;
    try {
      response = await _apiProvider.getWithToken(token);
    } catch (exception) {
      if (exception is TimeoutException) return APIResponse<User>(isOk: false, result: null, status: 408, message: 'Request timeout');
      else return APIResponse<User>(isOk: false, result: null, status: 500, message: exception.toString());
    }


    if (response.statusCode != 200) {
      return APIResponse<User>(isOk: false, result: null, status: response.statusCode, message: response.body);
    }

    User user;
    try {
      var responseBody = json.decode(response.body);
      if (responseBody != null && responseBody['id'] != null) {
        user = User.fromJson(responseBody);
      } else {
        throw Exception('Unexpected response body: ${response.body}');
      }
    } catch (exception) {
      print(exception);
      return APIResponse<User>(isOk: false, status: response.statusCode, result: null, message: exception.toString());
    }
    
    return APIResponse<User>(isOk: true, status: response.statusCode, result: user, message: 'OK');
  }
}